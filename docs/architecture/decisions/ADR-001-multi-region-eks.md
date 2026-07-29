# ADR-001: Use Two Regional Amazon EKS Clusters

## Status

Accepted

---

## Context

The RideShare platform currently operates in a single Amazon EKS cluster:

- `lukman-rideshare-cluster` (`us-east-2`)

This architecture creates a single regional failure domain. An outage affecting
the cluster, its networking, ingress infrastructure, or the AWS region could
make the entire application unavailable.

A second Amazon EKS cluster is available:

- `faahidah-rideshare-cluster` (`us-east-1`)

The target architecture requires the application to remain available during the
loss of an individual cluster or AWS Region while continuing to provide users
with a single public endpoint.

---

## Decision Drivers

This decision is driven by the following architectural objectives:

- Improve platform availability.
- Eliminate a single regional failure domain.
- Support multi-region application deployments.
- Enable regional failover through DNS-based traffic routing.
- Maintain a consistent Kubernetes deployment model across regions.
- Reuse the existing Kubernetes and Helm investment.

---

## Decision

Deploy the RideShare application and its supporting platform components to both
Amazon EKS clusters.

Each cluster will operate independently with its own:

- NGINX Ingress Controller;
- Kubernetes workloads;
- AWS Network Load Balancer; and
- platform controllers.

Amazon Route 53 will provide a single public endpoint by routing traffic to a
healthy regional deployment using latency-based routing and health checks.

Application deployments will be standardized through a single Helm chart with
region-specific values files.

Stateful services shared by both regions, including PostgreSQL and Redis, will
be managed independently of either Kubernetes cluster using Amazon RDS and
Amazon ElastiCache.

---

## Alternatives Considered

### 1. Continue Using One Amazon EKS Cluster

Deploy the entire application to a single regional cluster.

**Advantages**

- Lowest infrastructure cost.
- Simplest operational model.
- Minimal deployment complexity.

**Disadvantages**

- Regional outage results in complete application unavailability.
- Planned maintenance introduces service disruption.
- No regional resilience.

**Decision**

Rejected because it does not satisfy the availability objectives.

---

### 2. Use Two Amazon EKS Clusters in the Same Region

Deploy two independent clusters within `us-east-2`.

**Advantages**

- Protects against individual cluster failures.
- Simpler regional networking.
- Lower cross-region latency.

**Disadvantages**

- Does not protect against regional outages.
- Does not provide geographic redundancy.

**Decision**

Rejected because regional resilience remains a single point of failure.

---

### 3. Continue with a Single Multi-AZ Amazon EKS Cluster

Rely solely on Kubernetes high availability across multiple Availability Zones.

**Advantages**

- Native Amazon EKS high availability.
- Simpler platform management.
- Lower operational overhead.

**Disadvantages**

- Regional failures remain service impacting.
- Cluster-wide failures affect the entire platform.

**Decision**

Retained as an availability measure within each region but not sufficient as
the primary resilience strategy.

---

### 4. Use a Warm-Standby Regional Cluster

Maintain a secondary cluster for disaster recovery but keep it inactive during
normal operation.

**Advantages**

- Lower infrastructure cost.
- Dedicated disaster recovery environment.

**Disadvantages**

- Slower recovery.
- Increased operational complexity during failover.
- Standby environment may not remain production ready.

**Decision**

Rejected because continuously running both regions provides greater confidence
through ongoing validation.

---

### 5. Operate Two Active Regional Amazon EKS Clusters

Run the application continuously in both AWS Regions.

**Advantages**

- Independent regional failure domains.
- Continuous validation of both environments.
- Supports regional failover.
- Reduces maintenance impact.

**Disadvantages**

- Higher infrastructure cost.
- Increased operational complexity.
- Greater configuration management responsibility.

**Decision**

Accepted because it best satisfies the platform's availability and resilience
objectives.

---

### 6. Replace Amazon EKS with Another Compute Platform

Migrate the application to an alternative managed compute service.

**Advantages**

- Potentially simpler platform management.
- Reduced Kubernetes operational overhead.

**Disadvantages**

- Requires significant application and deployment redesign.
- Discards existing Kubernetes investment.
- Does not directly address the immediate resilience objective.

**Decision**

Rejected because it introduces unnecessary migration risk unrelated to the
current architectural goals.

---

## Consequences

### Positive

- Introduces independent regional failure domains.
- Improves application availability.
- Enables Route 53 regional traffic routing.
- Supports planned maintenance with reduced service disruption.
- Keeps both regional deployments continuously validated.
- Reuses the existing Kubernetes and Helm deployment model.

### Negative

- Increases infrastructure and operational costs.
- Requires multi-cluster deployment and monitoring.
- Introduces configuration drift risk.
- Requires consistent operational practices across regions.
- Shared managed services may introduce cross-region latency.
- DNS failover is subject to health-check timing and DNS caching.
- Existing client sessions, including WebSocket connections, are not preserved
  during failover.

---

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Configuration drift between clusters | Standardize deployments through Helm, version-controlled configuration and documented platform standards. |
| Regional deployment inconsistency | Validate both clusters before each release. |
| Increased operational complexity | Maintain comprehensive architecture documentation, ADRs and operational runbooks. |
| Regional failover does not behave as expected | Validate Route 53 health checks and perform planned failover testing. |

---

## Validation

This decision is considered successfully implemented when:

- the RideShare application is deployed successfully in both Amazon EKS
  clusters;
- both regional deployments operate independently;
- Route 53 successfully routes traffic to healthy regions;
- regional failover has been validated through controlled testing; and
- both clusters can be maintained using the same deployment process.

---

## Reconsider When

Review this decision if:

- the operational cost outweighs the availability benefits;
- a warm-standby architecture becomes sufficient for business recovery
  objectives;
- cross-region latency materially impacts application performance;
- shared managed services prevent effective regional independence;
- multi-cluster operations become operationally unsustainable;
- the platform adopts a different multi-region deployment model; or
- business, regulatory or architectural requirements significantly change.

---

## Related Documents

- Current-State Architecture
- Target-State Architecture
- Platform Evolution and Migration Plan
- Dependency Map
- Risks and Mitigation Plan
- Validation Plan