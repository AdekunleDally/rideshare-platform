# RideShare Disaster Recovery Runbook

## Purpose

This runbook defines the controlled disaster recovery procedure for the RideShare production platform.

The platform uses an active/passive multi-region architecture:

- **Primary region:** us-east-1
- **Standby region:** us-east-2
- **Primary EKS cluster:** rideshare-prod-use1
- **Standby EKS cluster:** rideshare-prod-use2
- **Primary database:** rideshare-prod-use1-postgres
- **Standby database:** rideshare-prod-use2-postgres

The us-east-2 PostgreSQL database operates as a cross-region read replica during normal operation and must be promoted before the standby region can accept production write traffic.

---

# 1. Normal Operating State

Expected architecture:

```text
Internet
   |
   v
rideshare.lukmonadeokun.com
   |
   v
us-east-1
   |
   +---- EKS applications
   |
   +---- Regional Redis
   |
   +---- RDS PostgreSQL (Read/Write)
                |
                | Cross-region replication
                v
          us-east-2 RDS
            (Read Only)
```

The us-east-2 EKS application stack remains deployed and available as the standby application environment.

Redis is regional and independent. Redis data is considered transient and is not replicated between regions.

---

# 2. Regional Health Endpoints

The following operational DNS names provide independent regional health visibility:

```text
use1.rideshare.lukmonadeokun.com
use2.rideshare.lukmonadeokun.com
```

Health endpoint:

```text
/application-healthz
```

Examples:

```bash
curl -i https://use1.rideshare.lukmonadeokun.com/application-healthz

curl -i https://use2.rideshare.lukmonadeokun.com/application-healthz
```

Expected response:

```text
HTTP/1.1 200 OK

OK
```

Route 53 HTTPS health checks monitor these regional endpoints on port 443 using `/application-healthz`.

> **Important:** A successful use2 health check proves that the regional application ingress path is reachable. It does **not** prove that the use2 PostgreSQL database is writable.

---

# 3. Failover Conditions

Regional failover should be considered when the primary region experiences a significant outage that prevents the RideShare application from operating normally.

Examples include:

- Primary EKS cluster unavailable
- Primary ingress/load balancer unavailable
- Primary RDS database unavailable
- Significant regional AWS outage
- Extended application outage isolated to us-east-1

Failover is a controlled operational decision.

The Route 53 application health check alone must not automatically trigger regional failover.

---

# 4. Failover Procedure

## Step 1 — Confirm the Primary Failure

Check the primary regional health endpoint:

```bash
curl -i https://use1.rideshare.lukmonadeokun.com/application-healthz
```

Check the standby endpoint:

```bash
curl -i https://use2.rideshare.lukmonadeokun.com/application-healthz
```

Inspect the primary EKS cluster if it remains reachable:

```bash
kubectl --context \
  arn:aws:eks:us-east-1:287872994236:cluster/rideshare-prod-use1 \
  get pods -n rideshare
```

Do not initiate regional failover for a minor or isolated application issue that can be recovered safely in the primary region.

---

## Step 2 — Prevent Further Primary Writes

Where possible, prevent applications in us-east-1 from continuing to write to the primary database before promoting the standby database.

This reduces the risk of divergent writes during the recovery process.

The exact fencing mechanism depends on the nature of the incident.

If us-east-1 is completely unavailable, fencing might not be possible.

---

## Step 3 — Validate the Standby Region

Verify the use2 EKS cluster:

```bash
aws eks describe-cluster \
  --name rideshare-prod-use2 \
  --region us-east-2 \
  --query 'cluster.status' \
  --output text
```

Expected:

```text
ACTIVE
```

Verify the applications:

```bash
kubectl --context \
  arn:aws:eks:us-east-2:287872994236:cluster/rideshare-prod-use2 \
  get deployments -n rideshare
```

Verify the regional ingress:

```bash
curl -i https://use2.rideshare.lukmonadeokun.com/application-healthz
```

Expected:

```text
HTTP/1.1 200 OK
```

---

## Step 4 — Verify the Standby RDS Replica

Check the RDS instance:

```bash
aws rds describe-db-instances \
  --db-instance-identifier rideshare-prod-use2-postgres \
  --region us-east-2 \
  --query 'DBInstances[0].{
    Status:DBInstanceStatus,
    Source:ReadReplicaSourceDBInstanceIdentifier,
    ReplicationStatus:StatusInfos
  }' \
  --output yaml
```

Confirm that the instance is available and replication is healthy before promotion whenever the primary region is reachable.

---

## Step 5 — Promote the use2 PostgreSQL Replica

> **WARNING:** Promotion converts the us-east-2 read replica into an independent writable database.
>
> Do not execute this command during routine standby validation.

Promote the replica:

```bash
aws rds promote-read-replica \
  --db-instance-identifier rideshare-prod-use2-postgres \
  --region us-east-2
```

Monitor the instance:

```bash
aws rds describe-db-instances \
  --db-instance-identifier rideshare-prod-use2-postgres \
  --region us-east-2 \
  --query 'DBInstances[0].{
    Status:DBInstanceStatus,
    Source:ReadReplicaSourceDBInstanceIdentifier,
    Endpoint:Endpoint.Address
  }' \
  --output table
```

Wait until the database returns to:

```text
available
```

After promotion, the read-replica source should no longer represent the normal cross-region replica relationship.

---

## Step 6 — Verify PostgreSQL Is Writable

Before changing production DNS, verify that PostgreSQL is no longer operating as a standby.

Run:

```sql
SELECT pg_is_in_recovery();
```

Expected:

```text
false
```

Also run:

```sql
SHOW transaction_read_only;
```

Expected:

```text
off
```

> **Do not switch production traffic to use2 until these checks succeed.**

---

## Step 7 — Validate use2 Applications

Verify:

```bash
kubectl --context \
  arn:aws:eks:us-east-2:287872994236:cluster/rideshare-prod-use2 \
  get pods -n rideshare
```

Check the regional endpoint:

```bash
curl -i https://use2.rideshare.lukmonadeokun.com/application-healthz
```

Expected:

```text
HTTP/1.1 200 OK
```

At this point:

- EKS should be healthy
- Ingress should be healthy
- Redis should be available
- PostgreSQL should be writable
- Application pods should be healthy

Only then proceed with DNS cutover.

---

# 5. Route 53 Production Cutover

Production hostname:

```text
rideshare.lukmonadeokun.com
```

Normal state:

```text
rideshare.lukmonadeokun.com
            |
            v
      us-east-1 NLB
```

During a confirmed DR event, after successful RDS promotion and application validation, update the production Route 53 alias to the us-east-2 NLB.

us-east-2 NLB:

```text
ab644eb0ac16c4b898e0d80dd6311146-af327cff475e10b4.elb.us-east-2.amazonaws.com
```

NLB canonical hosted zone:

```text
ZLMOA37VPKANP
```

The Route 53 hosted zone is:

```text
Z07569371A0TFP9KONHFX
```

The DNS change should use an `UPSERT` operation so that the existing production A alias is replaced with the use2 NLB alias.

After the change reaches `INSYNC`, verify:

```bash
nslookup rideshare.lukmonadeokun.com
```

Then validate:

```bash
curl -i https://rideshare.lukmonadeokun.com/application-healthz
```

Finally perform application-level validation.

---

# 6. Post-Failover State

After successful failover:

```text
rideshare.lukmonadeokun.com
            |
            v
         us-east-2
            |
            +---- EKS applications
            |
            +---- Regional Redis
            |
            +---- RDS PostgreSQL
                   Read/Write
```

us-east-2 is now the active production region.

The former cross-region RDS replication relationship must not be assumed to still exist after promotion.

---

# 7. Failback

Failback is **not** simply:

```text
Point DNS back to us-east-1
```

After use2 has accepted production writes, the databases may contain different data.

Before returning production traffic to us-east-1:

1. Restore or rebuild the desired replication relationship.
2. Synchronize the database state.
3. Verify the new standby contains current production data.
4. Validate application infrastructure.
5. Perform a controlled DNS cutover.

Never point production traffic back to the old database without first reconciling the data.

---

# 8. RTO and RPO

During a DR exercise or real incident, record:

- Time failure was detected
- Time failover decision was made
- Time database promotion started
- Time database became writable
- Time DNS cutover started
- Time application became operational
- Observed replication lag
- Any data loss
- Any failed application operations

**RTO:**

Time from service disruption to restored production service.

**RPO:**

Amount of production data lost between the primary failure and the latest successfully replicated transaction available in the promoted standby.

These values should be measured through DR exercises rather than assumed.

---

# 9. Important Safety Rule

The required failover order is:

```text
Detect failure
    |
    v
Fence primary writes where possible
    |
    v
Validate use2
    |
    v
Promote use2 RDS
    |
    v
Confirm PostgreSQL is writable
    |
    v
Validate applications
    |
    v
Switch Route 53
    |
    v
Validate production
```

Never perform:

```text
Switch Route 53
    |
    v
Promote database
```

because production traffic could reach a read-only database.