# ADR-003: Use Amazon ElastiCache for Redis

## Status

Accepted 2026-07-26

## Context

RideShare currently runs Redis inside Kubernetes using the Opstree Redis
Operator.

Both EKS clusters require Redis for driver locations, availability, matching
state, sessions, caching, and other short-lived operational data.

Keeping Redis in one cluster would make the other region dependent on it.
Running independent Redis clusters could produce inconsistent matching,
location, session, and availability state.

## Decision

Use one Amazon ElastiCache for Redis deployment shared by both EKS clusters.

Store sensitive connection details in AWS Secrets Manager and synchronize them
into both clusters using External Secrets Operator.

Retire the existing Redis Operator deployment only after connectivity and all
Redis-dependent workflows have been validated from both regions.

## Alternatives Considered

- **Redis Operator in one cluster:** Rejected because both regions would depend
  on that cluster.
- **Independent Redis in each region:** Rejected because application state
  could diverge between regions.
- **Regional Redis with application-level synchronization:** Rejected because
  it requires event replication, conflict resolution, and significant
  application redesign.
- **Remove Redis:** Rejected because PostgreSQL and pod-local caches do not
  adequately replace the current Redis workloads.

## Consequences

### Positive

- Both clusters access the same Redis state.
- Redis is independent of either EKS cluster's lifecycle.
- AWS manages Redis infrastructure and node replacement.
- Redis Operator resources can be removed after migration.
- The application clusters become more stateless.

### Negative

- ElastiCache becomes a shared dependency.
- Cross-region Redis access may increase latency and cost.
- Latency-sensitive matching and location operations may be affected.
- TLS, authentication, endpoint type, and Redis client compatibility must be
  validated.
- A shared Redis outage can affect both application regions.

## Reconsider When

Review this decision if cross-region latency affects real-time workflows,
ElastiCache becomes an unacceptable regional dependency, costs become
significant, or the application requires independent regional operation. Redis
Global Datastore or regional Redis ownership may then be appropriate.