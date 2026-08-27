# ADR-003: Use Amazon ElastiCache for Redis

## Status

Accepted

---

## Context

The RideShare platform currently runs Redis within Kubernetes using the Opstree
Redis Operator.

The target architecture introduces two active Amazon EKS clusters:

- `rideshare-prod-use1` (`us-east-1`)
- `rideshare-prod-use2` (`us-east-2`)

Both regional deployments rely on Redis for:

- driver locations;
- driver availability;
- ride matching state;
- user sessions;
- caching; and
- other short-lived operational data.

Keeping Redis inside a Kubernetes cluster tightly couples operational state to
that cluster. As the platform evolves to a multi-region architecture, Redis
must remain independently available to both regions while maintaining a
consistent operational view of application state.

---

## Decision Drivers

This decision is driven by the following architectural objectives:

- Decouple operational state from Kubernetes.
- Provide a shared Redis service for both application regions.
- Simplify Redis operations and infrastructure management.
- Reduce operational overhead associated with self-managed Redis clusters.
- Support a consistent multi-region deployment model.
- Improve platform resilience and maintainability.

---

## Decision

Adopt Amazon ElastiCache for Redis as the platform's shared in-memory data
store.

Amazon ElastiCache will provide Redis services independently of either Amazon
EKS cluster and will be shared by both regional deployments.

Connection details will be stored in AWS Secrets Manager and synchronized into
both clusters using External Secrets Operator.

The existing Redis Operator deployment will remain operational throughout the
migration and will only be decommissioned after connectivity, application
behaviour and rollback procedures have been successfully validated.

---

## Alternatives Considered

### 1. Continue Using the Redis Operator in One Amazon EKS Cluster

Operate Redis within a single Kubernetes cluster.

**Advantages**

- No migration effort.
- Existing operational model remains unchanged.
- Lower short-term implementation effort.

**Disadvantages**

- Redis availability depends on one Kubernetes cluster.
- Operational state remains coupled to Kubernetes.
- Regional resilience is not achieved.

**Decision**

Rejected because it introduces a single regional dependency.

---

### 2. Deploy Independent Redis Clusters per Region

Operate separate Redis deployments in each AWS Region.

**Advantages**

- Regional Redis independence.
- Lower local latency.

**Disadvantages**

- Operational state can diverge between regions.
- Driver locations, ride matching and sessions may become inconsistent.
- Additional synchronization mechanisms would be required.

**Decision**

Rejected because the current application requires a consistent shared
operational state.

---

### 3. Synchronize Regional Redis Clusters

Maintain Redis in both regions with application-level synchronization.

**Advantages**

- Regional Redis availability.
- Potentially lower local latency.

**Disadvantages**

- Requires application redesign.
- Introduces event replication and conflict resolution.
- Significantly increases operational and architectural complexity.

**Decision**

Rejected because the additional complexity is not justified by the current
platform requirements.

---

### 4. Remove Redis

Eliminate Redis and rely solely on PostgreSQL or in-memory application caches.

**Advantages**

- Simplifies platform infrastructure.
- Removes an operational dependency.

**Disadvantages**

- PostgreSQL is not suitable for current caching and real-time workloads.
- Driver matching, location updates and session management would require major
  application redesign.
- Reduced application performance.

**Decision**

Rejected because Redis remains a fundamental platform dependency.

---

### 5. Use Amazon ElastiCache for Redis

Adopt Amazon ElastiCache as the shared Redis service.

**Advantages**

- Decouples Redis from Kubernetes.
- AWS manages Redis infrastructure and node replacement.
- Simplifies Redis operations.
- Supports consistent operational state across both regions.
- Enables Kubernetes clusters to become more stateless.

**Disadvantages**

- Introduces a shared managed dependency.
- Cross-region access may increase latency.
- Requires careful network and security configuration.

**Decision**

Accepted because it best satisfies the platform's operational and architectural
requirements.

---

## Consequences

### Positive

- Redis becomes independent of Kubernetes.
- Both Amazon EKS clusters access the same operational state.
- AWS manages Redis infrastructure and maintenance.
- Redis Operator resources can be retired after migration.
- Kubernetes clusters become more stateless.
- Platform operations become simpler than managing Redis within Kubernetes.

### Negative

- Amazon ElastiCache becomes a shared dependency.
- Cross-region Redis access may introduce additional latency.
- Real-time workloads remain dependent on regional network performance.
- TLS, authentication and client compatibility require validation.
- A regional Redis outage can affect both application regions.

---

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Migration introduces application disruption | Retain the Redis Operator until ElastiCache has been fully validated. |
| Cross-region latency affects real-time workloads | Monitor Redis performance and review the architecture as platform demand grows. |
| Connectivity or authentication failures | Store credentials in AWS Secrets Manager and synchronize them using External Secrets Operator. |
| Amazon ElastiCache becomes a shared dependency | Validate backup, recovery and operational procedures while continuously monitoring service health. |

---

## Validation

This decision is considered successfully implemented when:

- Amazon ElastiCache is the platform's primary Redis service;
- both Amazon EKS clusters successfully connect to Amazon ElastiCache;
- Redis-dependent application workflows operate correctly;
- credentials are synchronized through AWS Secrets Manager and External Secrets Operator;
- the Redis Operator has been safely decommissioned; and
- application functionality has been validated following migration.

---

## Reconsider When

Review this decision if:

- cross-region latency significantly impacts real-time application behaviour;
- independent regional operation becomes a business requirement;
- Redis availability objectives exceed the capabilities of the current
architecture;
- Redis Global Datastore or another distributed Redis architecture becomes
operationally justified; or
- business, regulatory or architectural requirements materially change.

---

## Related Documents

- Current-State Architecture
- Target-State Architecture
- Platform Evolution and Migration Plan
- Dependency Map
- Risks and Mitigation Plan
- Validation Plan
- ADR-001: Use Two Regional Amazon EKS Clusters