# ADR-004: Use Amazon Route 53 Latency-Based Routing

## Status

Accepted 2026-07-26

## Context

RideShare runs actively in two regional EKS clusters. Each cluster is exposed
through its own NGINX Ingress Controller and AWS Network Load Balancer.

Users must access both deployments through one hostname:

```text
rideshare.lukmonadeokun.com
```

Testing showed that a load balancer and NGINX Ingress can remain reachable even
when the RideShare application is unavailable. Routing must therefore evaluate
application health rather than network availability alone.

## Decision

Use Amazon Route 53 Latency-Based Routing with two alias records:

- `us-east-2` regional ingress
- `us-east-1` regional ingress

Route 53 will direct users to the lowest-latency healthy region. Each region
will have an independent application-level HTTP health check.

## Alternatives Considered

- **Single regional endpoint:** Rejected because it provides no regional
  redundancy.
- **Active-passive failover:** Rejected because both clusters are intended to
  serve production traffic.
- **Weighted routing:** Rejected as the permanent strategy because it requires
  manually managed traffic percentages.
- **AWS Global Accelerator:** Rejected for now because its faster failover does
  not justify the additional cost and infrastructure.

## Consequences

### Positive

- Users access one stable hostname.
- Both regional clusters actively serve traffic.
- Unhealthy application regions are removed from DNS responses.
- Users are generally routed to the lowest-latency healthy region.
- Both regional environments are continuously exercised.

### Negative

- Failover is affected by DNS caching and is not instantaneous.
- Existing WebSocket connections are not transferred during failover.
- Both clusters must remain production-ready.
- Shared RDS and ElastiCache remain common dependencies.

## Reconsider When

Review this decision if DNS failover cannot meet recovery objectives,
active-active routing is no longer required, precise traffic percentages are
needed, or AWS Global Accelerator's faster failover becomes worth the
additional cost.