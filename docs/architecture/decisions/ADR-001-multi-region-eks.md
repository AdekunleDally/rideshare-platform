# ADR-001: Use Two Regional Amazon EKS Clusters

## Status

Accepted

## Context

The RideShare platform currently runs in one Amazon EKS cluster:

- `lukman-rideshare-cluster` in `us-east-2`

This creates a single regional failure domain. An outage affecting the cluster,
its networking, ingress infrastructure, or the entire AWS region could make the
application unavailable.

A second EKS cluster already exists:

- `faahidah-rideshare-cluster` in `us-east-1`

The platform requires regional application redundancy while retaining one
public hostname for users.

## Decision

Deploy the RideShare application and required platform components to both EKS
clusters.

Each cluster will have its own NGINX Ingress Controller and AWS load balancer.
Amazon Route 53 will sit in front of the regional load balancers and direct
users to a healthy regional deployment.

The same Helm charts will be used for both clusters, with region-specific
configuration supplied through separate values files.

Stateful services required by both regions, including PostgreSQL and Redis,
will be managed outside the lifecycle of either EKS cluster.

## Alternatives Considered

### Continue Using One EKS Cluster

Keep the complete RideShare platform in `lukman-rideshare-cluster`.

**Advantages**

- Lowest infrastructure cost.
- Simplest deployment and operational model.
- No multi-cluster configuration or synchronization concerns.

**Disadvantages**

- A cluster or regional outage can make the entire application unavailable.
- Regional failover cannot be tested.
- Maintenance affecting the cluster may interrupt the application.

**Outcome:** Rejected because it does not provide regional redundancy.

### Use Two EKS Clusters in the Same Region

Deploy the application to two clusters in `us-east-2`.

**Advantages**

- Protects against failure or misconfiguration of one cluster.
- Lower network latency between shared regional services.
- Avoids some cross-region networking and data-transfer costs.

**Disadvantages**

- Both clusters remain exposed to a `us-east-2` regional failure.
- Does not provide geographical failure isolation.
- Does not meet the multi-region availability objective.

**Outcome:** Rejected because it provides cluster redundancy but not regional
redundancy.

### Use One EKS Cluster Spanning Multiple Availability Zones

Continue using one multi-AZ EKS cluster with worker nodes distributed across
Availability Zones.

**Advantages**

- Protects against the failure of an individual Availability Zone.
- Simpler than operating multiple clusters.
- Uses standard EKS high-availability capabilities.

**Disadvantages**

- The control plane, networking, and application remain within one AWS region.
- A regional outage can still make the application unavailable.
- Cluster-wide configuration or deployment errors can affect all workloads.

**Outcome:** Retained as an availability measure within each region, but
rejected as the complete regional resilience strategy.

### Use a Warm-Standby Cluster

Maintain the second cluster with the required platform components, but deploy
or scale up the application only during an outage.

**Advantages**

- Lower compute cost in the secondary region.
- Provides a disaster-recovery environment.
- Reduces normal multi-region application traffic.

**Disadvantages**

- Recovery requires deployment or scaling operations.
- Failover is slower and more operationally complex.
- The standby environment may become stale or remain insufficiently tested.
- Recovery depends on automation working correctly during an incident.

**Outcome:** Rejected because both existing clusters are intended to remain
active and continuously validated.

### Use Two Active Regional EKS Clusters

Run the RideShare application in both `us-east-1` and `us-east-2`.

**Advantages**

- Provides independent regional application failure domains.
- Allows traffic to move away from an unhealthy cluster or region.
- Continuously exercises both regional deployments.
- Supports planned maintenance without a complete application outage.

**Disadvantages**

- Increases infrastructure and operational cost.
- Requires multi-cluster deployments, monitoring, security, and upgrades.
- Introduces configuration-drift risks.
- Requires careful handling of shared data and cross-region dependencies.

**Outcome:** Accepted because it best satisfies the regional availability
objective.

### Replace EKS with a Different Multi-Region Compute Platform

Migrate the application to services such as Amazon ECS, AWS App Runner, or
another managed compute platform.

**Advantages**

- Could reduce Kubernetes operational responsibilities.
- May provide a simpler deployment model for some services.

**Disadvantages**

- Requires substantial platform and deployment changes.
- Discards the existing Helm, Kubernetes, and EKS investment.
- Introduces migration risk unrelated to the current availability objective.

**Outcome:** Rejected because the existing application and operational model
are already based on Kubernetes and EKS.

## Consequences

### Positive

- A failure of one EKS cluster does not automatically remove the other
  deployment.
- The application gains regional redundancy and independent failure domains.
- Route 53 can direct new users away from an unhealthy regional deployment.
- Both clusters are continuously exercised instead of leaving one untested.
- Planned cluster maintenance can be performed with reduced application impact.
- The same Helm-based application deployment can be used in both regions.

### Negative

- Infrastructure and operational costs increase.
- Platform components must be installed, upgraded, monitored, and secured in
  both clusters.
- CI/CD must deploy and validate the application across multiple clusters.
- Configuration drift between regions becomes a risk.
- Regional capacity must be sufficient to handle additional traffic during an
  outage.
- Cross-region access to shared RDS and ElastiCache services may introduce
  latency and cost.
- DNS failover is affected by health-check intervals, TTLs, and resolver
  caching.
- Existing connections, including WebSockets, are not automatically transferred
  between regions.

## Reconsider When

Review this decision if:

- The cost of maintaining two active EKS clusters exceeds the availability
  benefit.
- Business recovery objectives can be satisfied by a lower-cost warm-standby
  model.
- One region cannot safely handle the full production workload during an
  outage.
- Cross-region latency materially affects application performance.
- Shared RDS or ElastiCache dependencies prevent meaningful regional
  independence.
- Configuration drift or multi-cluster operations become unmanageable.
- The platform adopts a centralized multi-cluster management solution that
  changes the operational model.
- The application moves to a compute platform that provides a simpler
  multi-region architecture.
- Regulatory or data-residency requirements prevent workloads or data from
  operating in both regions.
- Additional regions are required, making the current two-cluster architecture
  insufficient.
