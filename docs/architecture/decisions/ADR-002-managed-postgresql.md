# ADR-002: Use Amazon RDS for PostgreSQL

## Status

Accepted  2026-07-26

## Context

RideShare currently runs PostgreSQL inside `lukman-rideshare-cluster` using
CloudNativePG. The application is moving to two active EKS clusters:

- `lukman-rideshare-cluster` in `us-east-2`
- `faahidah-rideshare-cluster` in `us-east-1`

Both clusters require the same rider, driver, trip, and payment data.

Keeping PostgreSQL in one EKS cluster would make both regions dependent on that
cluster. Running separate databases would create inconsistent data unless the
platform team operated cross-region replication and failover.

## Decision

Use one Amazon RDS for PostgreSQL deployment as the shared system of record for
both EKS clusters.

Store connection details in AWS Secrets Manager and synchronize them into both
clusters using External Secrets Operator.

Keep CloudNativePG available during migration and retire it only after the RDS
deployment and rollback process have been validated.

## Alternatives Considered

- **CloudNativePG in one cluster:** Rejected because both regions would depend
  on that cluster.
- **Separate regional databases:** Rejected because they could contain
  conflicting data.
- **Self-managed cross-region replication:** Rejected because of replication
  lag, failover, split-brain, backup, and recovery complexity.
- **Aurora PostgreSQL:** Not currently required, but may be reconsidered for
  advanced multi-region capabilities.

## Consequences

### Positive

- Both clusters use the same authoritative data.
- PostgreSQL is independent of either EKS cluster's lifecycle.
- AWS manages database maintenance, backups, and recovery features.
- The EKS clusters become more stateless.

### Negative

- RDS becomes a shared dependency for both regions.
- The remote region may experience higher latency and data-transfer costs.
- Network routing, security groups, connection limits, and schema migrations
  must be carefully managed.
- A regional RDS failure could still affect both application regions.

## Reconsider When

Review this decision if cross-region latency, cost, connection limits, recovery
requirements, independent regional writes, or multi-region database failover
become significant. Aurora Global Database or another regional data architecture
may then be more appropriate.