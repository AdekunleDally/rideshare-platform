# ADR-002: Use Amazon RDS for PostgreSQL

## Status

Accepted

---

## Context

The RideShare platform currently runs PostgreSQL within
`lukman-rideshare-cluster` using CloudNativePG.

The target architecture introduces two active Amazon EKS clusters:

- `rideshare-prod-use1` (`us-east-1`)
- `rideshare-prod-use2` (`us-east-2`)

Both regional deployments require access to the same rider, driver, trip and
payment data.

Keeping PostgreSQL inside a Kubernetes cluster tightly couples the platform's
system of record to the lifecycle of that cluster. As the platform evolves to a
multi-region architecture, the database must remain independently available and
accessible from both regions.

---

## Decision Drivers

This decision is driven by the following architectural objectives:

- Decouple persistent data from Kubernetes.
- Provide a single authoritative system of record.
- Simplify database operations and maintenance.
- Support active multi-region application deployments.
- Reduce operational overhead associated with self-managed databases.
- Improve backup, recovery and operational resilience.

---

## Decision

Adopt Amazon RDS for PostgreSQL as the platform's primary relational database.

Amazon RDS will serve as the shared system of record for both Amazon EKS
clusters and will operate independently of the Kubernetes platform.

Database credentials will be stored in AWS Secrets Manager and synchronized into
both clusters using External Secrets Operator.

CloudNativePG will remain operational throughout the migration and will only be
decommissioned after data migration, application validation and rollback
procedures have been successfully completed.

---

## Alternatives Considered

### 1. Continue Using CloudNativePG in One Amazon EKS Cluster

Host PostgreSQL within a single Kubernetes cluster.

**Advantages**

- No migration effort.
- Existing operational model remains unchanged.
- Lower short-term implementation effort.

**Disadvantages**

- Database availability depends on one Kubernetes cluster.
- Regional resilience is not achieved.
- Database lifecycle remains coupled to Kubernetes.

**Decision**

Rejected because it introduces a single point of failure.

---

### 2. Deploy Independent PostgreSQL Databases per Region

Operate separate PostgreSQL instances in each AWS Region.

**Advantages**

- Regional database independence.
- Lower local database latency.

**Disadvantages**

- Requires application-level data synchronization.
- Risk of inconsistent or conflicting data.
- Increased operational complexity.

**Decision**

Rejected because RideShare requires a single authoritative data source.

---

### 3. Self-Manage PostgreSQL Replication

Operate PostgreSQL with self-managed cross-region replication.

**Advantages**

- Greater control over database configuration.
- Flexible replication topology.

**Disadvantages**

- Increased operational burden.
- Complex failover procedures.
- Replication lag and split-brain risks.
- Greater responsibility for backup and recovery.

**Decision**

Rejected because the operational complexity outweighs the benefits.

---

### 4. Use Amazon Aurora PostgreSQL

Adopt Amazon Aurora PostgreSQL instead of Amazon RDS.

**Advantages**

- Higher availability.
- Faster failover.
- Advanced replication capabilities.
- Supports future multi-region database architectures.

**Disadvantages**

- Increased infrastructure cost.
- Additional operational capabilities not currently required.
- Introduces complexity beyond the project's present needs.

**Decision**

Deferred. Amazon Aurora remains a viable future evolution if platform scale,
availability requirements or global database capabilities increase.

---

## Consequences

### Positive

- PostgreSQL becomes independent of Kubernetes.
- Both Amazon EKS clusters use the same authoritative data source.
- AWS manages database backups, maintenance and patching.
- Database operations become simpler than managing PostgreSQL within Kubernetes.
- Kubernetes clusters become more stateless.

### Negative

- Amazon RDS becomes a shared dependency for both regions.
- Cross-region database access may introduce additional latency.
- Network connectivity and security configuration become critical.
- Schema migrations must be coordinated carefully across regional deployments.
- A failure affecting the regional database can impact both application regions.

---

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Data migration failure | Perform validated backups before migration and retain CloudNativePG until migration has been verified. |
| Cross-region latency | Monitor database performance and review regional architecture as application demand grows. |
| Database connectivity failures | Configure resilient networking, security groups and connection management. |
| Amazon RDS becomes a shared dependency | Validate backup, recovery and disaster recovery procedures and monitor database availability continuously. |

---

## Validation

This decision is considered successfully implemented when:

- Amazon RDS is the authoritative PostgreSQL database;
- application data has been migrated successfully;
- both Amazon EKS clusters connect successfully to Amazon RDS;
- database credentials are synchronized through AWS Secrets Manager and External Secrets Operator;
- CloudNativePG has been safely decommissioned; and
- application functionality has been validated following migration.

---

## Reconsider When

Review this decision if:

- cross-region database latency significantly affects application performance;
- independent regional writes become a business requirement;
- database availability objectives exceed Amazon RDS capabilities;
- platform growth justifies Amazon Aurora Global Database or another distributed
  database architecture; or
- business, regulatory or disaster recovery requirements materially change.

---

## Related Documents

- Current-State Architecture
- Target-State Architecture
- Platform Evolution and Migration Plan
- Dependency Map
- Risks and Mitigation Plan
- Validation Plan
- ADR-001: Use Two Regional Amazon EKS Clusters