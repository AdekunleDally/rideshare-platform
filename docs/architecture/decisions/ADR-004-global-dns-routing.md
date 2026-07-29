# ADR-004: Use Amazon Route 53 Latency-Based Routing

## Status

Accepted

---

## Context

The RideShare platform is deployed to two active Amazon EKS clusters:

- `lukman-rideshare-cluster` (`us-east-2`)
- `faahidah-rideshare-cluster` (`us-east-1`)

Each cluster exposes the application through its own:

- NGINX Ingress Controller; and
- AWS Network Load Balancer.

Users should access the platform through a single public endpoint:

```text
rideshare.lukmonadeokun.com
```

During platform validation it was observed that an ingress controller and load
balancer can continue responding even when the RideShare application itself is
unhealthy. Regional traffic management must therefore make routing decisions
based on application health rather than infrastructure availability alone.

---

## Decision Drivers

This decision is driven by the following architectural objectives:

- Provide a single public application endpoint.
- Support active multi-region application deployments.
- Route users to the most appropriate healthy region.
- Improve regional application availability.
- Minimize operational complexity.
- Integrate with existing AWS networking services.

---

## Decision

Adopt Amazon Route 53 Latency-Based Routing as the platform's global traffic
management solution.

Amazon Route 53 will provide a single DNS endpoint that routes users to the
lowest-latency healthy regional deployment.

Each regional Amazon EKS cluster will publish its own application endpoint
through an AWS Network Load Balancer.

Independent application-level HTTP health checks will determine whether a
regional deployment should receive traffic.

Application health, rather than infrastructure availability alone, will govern
traffic routing decisions.

---

## Alternatives Considered

### 1. Use a Single Regional Endpoint

Expose only one regional deployment.

**Advantages**

- Simplest architecture.
- Lowest operational cost.
- Minimal DNS configuration.

**Disadvantages**

- No regional resilience.
- Regional failures result in complete application unavailability.
- Planned maintenance affects all users.

**Decision**

Rejected because it introduces a single regional failure domain.

---

### 2. Use Active-Passive DNS Failover

Operate one production region with a standby secondary region.

**Advantages**

- Lower operational cost.
- Simpler traffic management.
- Dedicated disaster recovery environment.

**Disadvantages**

- Secondary region receives little or no production traffic.
- Failover depends on standby readiness.
- Recovery is slower than an active-active architecture.

**Decision**

Rejected because both regional clusters are intended to remain active and
continuously validated.

---

### 3. Use Weighted Routing

Distribute traffic between regions using predefined percentages.

**Advantages**

- Useful for gradual deployments.
- Supports controlled traffic migration.
- Enables canary and blue-green deployment strategies.

**Disadvantages**

- Traffic distribution requires manual management.
- Does not automatically optimize for user latency.
- Requires additional operational oversight.

**Decision**

Rejected as the primary production routing strategy, although it remains useful
for future controlled rollout scenarios.

---

### 4. Use AWS Global Accelerator

Use AWS Global Accelerator instead of DNS-based routing.

**Advantages**

- Faster failover.
- Static Anycast IP addresses.
- Improved global network performance.
- Reduced dependency on DNS propagation.

**Disadvantages**

- Higher infrastructure cost.
- Additional operational complexity.
- Benefits do not currently justify the additional investment.

**Decision**

Deferred. AWS Global Accelerator remains a suitable future enhancement if
recovery objectives or global performance requirements increase.

---

### 5. Use Amazon Route 53 Latency-Based Routing

Route traffic using Amazon Route 53 latency-based routing and application health
checks.

**Advantages**

- Single public hostname.
- Automatic regional traffic routing.
- Supports active-active regional deployments.
- Integrates naturally with AWS networking.
- Cost-effective compared to more advanced traffic management solutions.

**Disadvantages**

- DNS failover is not instantaneous.
- Client-side DNS caching influences failover behaviour.
- Existing WebSocket connections are not preserved during regional failover.

**Decision**

Accepted because it provides the best balance between availability,
operational simplicity and cost for the current platform.

---

## Consequences

### Positive

- Users access the platform through a single stable hostname.
- Both regional deployments continuously receive production traffic.
- Unhealthy application regions are automatically removed from DNS responses.
- Users are generally routed to the lowest-latency healthy deployment.
- Planned regional maintenance has reduced user impact.

### Negative

- DNS caching affects failover timing.
- Existing WebSocket connections are not transferred during failover.
- Both regional deployments must remain production ready.
- Shared Amazon RDS and Amazon ElastiCache services remain common
dependencies.
- Regional traffic distribution cannot be controlled as precisely as weighted
routing.

---

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Traffic continues to an unhealthy application | Use application-level Route 53 health checks rather than infrastructure-only health checks. |
| DNS failover is slower than expected | Configure appropriate health check intervals and TTL values, and validate failover behaviour regularly. |
| Regional routing behaves unexpectedly | Perform planned failover testing and continuously monitor Route 53 health check status. |
| Shared backend services reduce effective regional independence | Validate application behaviour under regional failure scenarios and monitor backend service availability. |

---

## Validation

This decision is considered successfully implemented when:

- users access the application through a single public hostname;
- Route 53 routes users to the lowest-latency healthy region;
- unhealthy regional deployments are removed from DNS responses;
- planned regional failover testing succeeds; and
- application availability is maintained during regional failure simulations.

---

## Reconsider When

Review this decision if:

- DNS-based failover no longer satisfies recovery objectives;
- faster failover becomes a business requirement;
- more precise traffic control is required;
- application growth justifies AWS Global Accelerator or another global traffic
management solution; or
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