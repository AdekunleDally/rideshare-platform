# ADR-001: Adopt Two Standardised Regional Amazon EKS Platforms

## Status

Accepted

---

## Context

The original RideShare platform operates from a single Amazon EKS cluster:

- `lukman-rideshare-cluster` in `us-east-2`

This cluster represents the engineering baseline from which the platform is
being evolved.

Although the application is functional, the architecture places application
execution within a single regional failure domain. A sufficiently broad failure
affecting the EKS cluster, its supporting networking or ingress infrastructure,
or the AWS Region could make the application unavailable.

The existing environment also predates the governance, naming, deployment and
operational standards introduced as part of the platform engineering work in
this repository.

The objective is therefore not simply to add another EKS cluster to the
existing environment.

The platform will evolve from the legacy single-region implementation into two
standardised regional platforms:

| Region | Platform | Role |
|---|---|---|
| `us-east-1` | `rideshare-prod-use1` | First implementation of the standardised regional platform |
| `us-east-2` | `rideshare-prod-use2` | Second implementation of the same regional platform standard |

The first standardised environment is established in `us-east-1` as
`rideshare-prod-use1`.

This environment provides the initial implementation and validation point for
the target architecture, including the EKS configuration, platform components,
managed data-service integration, application deployment model and operational
standards defined by this project.

Once that regional pattern has been validated, the same standards will be
applied in `us-east-2` as `rideshare-prod-use2`, replacing
`lukman-rideshare-cluster` as the long-term `us-east-2` platform.

The resulting architecture will provide two independently deployable regional
EKS environments built from the same platform standards while presenting the
RideShare application through a single public endpoint.

The transition is therefore:

```text
Legacy regional platform
lukman-rideshare-cluster
us-east-2
        |
        v
Current-state assessment
and target architecture
        |
        v
First standardised regional platform
rideshare-prod-use1
us-east-1
        |
        v
Application and platform validation
        |
        v
Second standardised regional platform
rideshare-prod-use2
us-east-2
        |
        v
Two standardised regional platforms
us-east-1 + us-east-2
```

---

## Decision Drivers

This decision is driven by the following architectural objectives:

- Remove the application's dependency on a single regional execution
  environment.
- Establish independent regional application failure domains.
- Create a repeatable regional EKS platform rather than maintaining
  independently configured clusters.
- Apply consistent naming, governance and operational standards across
  environments.
- Support multi-region application deployment.
- Enable DNS-based regional traffic management and failover.
- Retain Kubernetes and Helm as the application deployment model.
- Separate application compute from stateful data infrastructure by adopting
  managed AWS data services.
- Provide a platform design that can be reproduced rather than relying on the
  accumulated state of the original cluster.
- Allow the new regional architecture to be validated before the legacy
  environment is retired.

---

## Decision

Adopt two standardised regional Amazon EKS platforms for the RideShare
application:

- `rideshare-prod-use1` in `us-east-1`
- `rideshare-prod-use2` in `us-east-2`

`rideshare-prod-use1` will be implemented first and used to establish and
validate the standard regional platform pattern.

Once validated, the same architecture, governance rules and deployment model
will be applied to `rideshare-prod-use2`.

The original `lukman-rideshare-cluster` will remain a migration baseline during
the transition but is not part of the final target architecture. It will be
retired after the replacement `us-east-2` environment has been implemented and
the required migration and validation activities have been completed.

Each target regional platform will provide its own:

- Amazon EKS cluster;
- application workloads;
- NGINX Ingress Controller;
- regional load-balancing infrastructure;
- certificate and TLS integration;
- External Secrets integration;
- required Kubernetes platform components; and
- regional application configuration.

Application deployment will be standardised through version-controlled Helm
charts with region-specific values used only where regional differences are
required.

The intended deployment model is:

```text
                    Route 53
                       |
             rideshare public endpoint
                       |
              +--------+--------+
              |                 |
              v                 v
       us-east-1             us-east-2
   rideshare-prod-use1   rideshare-prod-use2
              |                 |
              v                 v
         Regional             Regional
          Ingress              Ingress
              |                 |
              v                 v
        RideShare App        RideShare App
```

Amazon Route 53 will provide the DNS layer used to direct clients toward
healthy regional application endpoints according to the selected routing and
health-check strategy.

The two EKS clusters will not depend on one another for application execution.

Stateful services will also be moved out of the Kubernetes clusters as part of
the wider platform evolution:

- PostgreSQL will move from CloudNativePG to Amazon RDS for PostgreSQL.
- Redis will move from the Opstree Redis Operator to Amazon ElastiCache.

The exact cross-region topology for stateful services, particularly PostgreSQL
replication and failover, is treated as a separate architectural decision
because compute redundancy alone does not provide complete regional
independence for a stateful application.

---

## Regional Standardisation Model

The two target clusters are intended to be regional instances of the same
platform design, not separately engineered environments.

The platform should therefore follow this model:

```text
                   Platform standards
                          |
              +-----------+-----------+
              |                       |
              v                       v
       rideshare-prod-use1     rideshare-prod-use2
           us-east-1               us-east-2
              |                       |
              +-----------+-----------+
                          |
                   Same application
                   deployment model
```

Common behaviour should be maintained through reusable infrastructure
definitions, Helm charts, platform configuration and operational standards.

Regional differences should be explicit and limited to configuration that is
genuinely region-specific, such as:

- AWS Region;
- VPC and subnet identifiers;
- regional resource endpoints;
- regional Amazon ECR references where applicable;
- regional managed-service endpoints;
- certificate or DNS integration where required; and
- other AWS resource identifiers that cannot be shared across regions.

This reduces configuration drift and makes the second regional environment a
reproduction of an established platform pattern rather than another
independently constructed cluster.

---

## Migration Approach

The move to the two-region architecture will be incremental.

### Stage 1 — Preserve and Assess the Baseline

`lukman-rideshare-cluster` remains the reference implementation while its
architecture, dependencies and operational characteristics are assessed.

This allows the target design to be based on the behaviour of a working
application rather than assumptions about the existing environment.

### Stage 2 — Establish `rideshare-prod-use1`

Build the first governance-compliant regional platform in `us-east-1`.

This environment establishes the target pattern for:

- EKS configuration;
- naming and tagging;
- workload placement;
- ingress;
- TLS;
- secrets management;
- managed PostgreSQL;
- managed Redis;
- application Helm deployment; and
- operational validation.

### Stage 3 — Validate the Regional Pattern

Deploy the RideShare application to `rideshare-prod-use1` and validate the
platform from infrastructure through application behaviour.

Validation includes application health, service connectivity, ingress, TLS,
WebSockets, managed data-service connectivity and end-to-end RideShare
business workflows.

Infrastructure that has been superseded by the managed architecture can be
retired after the replacement has been validated.

### Stage 4 — Establish `rideshare-prod-use2`

Apply the validated regional platform pattern in `us-east-2` as
`rideshare-prod-use2`.

This replaces `lukman-rideshare-cluster` as the target `us-east-2` environment.

### Stage 5 — Operate the Multi-Region Platform

With both standardised regional environments available, introduce and validate
the required Route 53 traffic-management and regional failure behaviour.

The end state is:

```text
                  Public application endpoint
                           |
                        Route 53
                           |
                 +---------+---------+
                 |                   |
                 v                   v
          rideshare-prod-use1  rideshare-prod-use2
              us-east-1           us-east-2
                 |                   |
                 v                   v
           RideShare App        RideShare App
                 |                   |
                 +---------+---------+
                           |
                 Managed data layer
```

The architecture of the managed data layer and its cross-region behaviour is
governed by the relevant data-service ADRs rather than assumed by this
decision.

---

## Alternatives Considered

### 1. Continue Using `lukman-rideshare-cluster`

Retain the existing `us-east-2` environment as the sole production platform.

**Advantages**

- Lowest infrastructure cost.
- No regional migration required.
- Simplest operational model.
- Existing application behaviour is already understood.

**Disadvantages**

- Application execution remains dependent on one AWS Region.
- Regional resilience cannot be demonstrated.
- The existing environment predates the target governance and platform
  standards.
- Continued changes would further increase dependence on an environment that
  is intended to become the historical baseline.

**Decision**

Rejected because it does not meet the resilience, standardisation or
reproducibility objectives of the target platform.

---

### 2. Add a Second Cluster Without Standardising the Existing Platform

Add another EKS cluster in a second Region while continuing to treat
`lukman-rideshare-cluster` as the permanent `us-east-2` environment.

**Advantages**

- Faster path to having workloads in two AWS Regions.
- Reuses the existing cluster without requiring eventual replacement.
- Lower short-term migration effort.

**Disadvantages**

- Creates two regions built from different platform generations.
- Preserves legacy naming and configuration.
- Increases configuration drift.
- Makes regional behaviour harder to reproduce.
- Makes the second region an addition to the legacy architecture rather than
  part of a common platform standard.

**Decision**

Rejected.

The project is intended to establish a repeatable regional platform model.
`rideshare-prod-use1` and `rideshare-prod-use2` should therefore represent two
implementations of the same platform standard.

---

### 3. Use Two Amazon EKS Clusters in the Same Region

Deploy two independent clusters within a single AWS Region.

**Advantages**

- Protects against some individual cluster failures.
- Allows independent cluster maintenance.
- Avoids some cross-region networking considerations.

**Disadvantages**

- Both clusters remain exposed to the same regional failure domain.
- Does not provide geographic redundancy.
- Does not satisfy the multi-region objective.

**Decision**

Rejected because it addresses cluster-level redundancy but not regional
resilience.

---

### 4. Rely on a Single Multi-AZ Amazon EKS Cluster

Use the high-availability characteristics of Amazon EKS and distribute worker
capacity across multiple Availability Zones.

**Advantages**

- Provides strong availability within a Region.
- Simpler than multi-region operation.
- Lower infrastructure and operational overhead.

**Disadvantages**

- Does not protect the application from a regional failure.
- Certain cluster-wide or regional dependencies can still affect the entire
  application.

**Decision**

Multi-AZ deployment is retained as an availability requirement within each
regional platform, but it is not sufficient as the overall resilience
strategy.

---

### 5. Use a Warm-Standby Regional Cluster

Maintain the second regional environment primarily for disaster recovery
instead of continuously operating application workloads in both regions.

**Advantages**

- Potentially lower operating cost.
- Simpler normal traffic flow.
- Provides a dedicated disaster-recovery environment.

**Disadvantages**

- Recovery requires additional activation steps.
- The standby environment receives less continuous production validation.
- Configuration drift can remain unnoticed until failover is required.
- Recovery time is likely to be longer than with continuously operational
  regional environments.

**Decision**

Rejected for the target design.

The platform will maintain deployable and validated application environments
in both regions so that regional readiness is demonstrated continuously rather
than assumed.

---

### 6. Operate Two Standardised Regional Amazon EKS Platforms

Build `rideshare-prod-use1` and `rideshare-prod-use2` from the same platform
standards and operate the RideShare application regionally.

**Advantages**

- Establishes independent regional application failure domains.
- Provides a repeatable regional architecture.
- Enables continuous validation of both environments.
- Supports DNS-based regional traffic management.
- Reduces dependence on the historical cluster.
- Reuses the existing Kubernetes and Helm application deployment model.
- Provides a foundation for controlled resilience and failover testing.

**Disadvantages**

- Higher infrastructure cost.
- Greater operational complexity.
- Requires multi-cluster deployment, monitoring and troubleshooting.
- Requires deliberate management of regional configuration.
- Data-layer resilience must be designed separately from EKS resilience.

**Decision**

Accepted because it best satisfies the platform's resilience,
standardisation, reproducibility and operational objectives.

---

### 7. Replace Amazon EKS with Another Compute Platform

Move the RideShare workloads to another compute model rather than extending
the Kubernetes architecture.

**Advantages**

- Could reduce some Kubernetes operational responsibilities.
- Alternative managed services may simplify particular workload patterns.

**Disadvantages**

- Requires significant application and deployment redesign.
- Discards the existing Kubernetes and Helm investment.
- Introduces migration work unrelated to the principal architecture problem.
- Would make it more difficult to distinguish resilience improvements from a
  complete compute-platform migration.

**Decision**

Rejected because Amazon EKS remains appropriate for the application and the
current objective is to improve the surrounding platform architecture rather
than replace the application's compute model.

---

## Consequences

### Positive

- Replaces the single-region target architecture with two independent regional
  application environments.
- Establishes `rideshare-prod-use1` and `rideshare-prod-use2` as implementations
  of one platform standard.
- Removes the legacy cluster from the final target architecture.
- Improves regional application resilience.
- Supports Route 53 regional traffic management.
- Enables regional failure and recovery testing.
- Allows regional platform changes to be validated before the legacy
  environment is retired.
- Reuses the existing Kubernetes and Helm application deployment model.
- Creates a clearer separation between application compute and managed
  stateful services.
- Provides a reproducible foundation for future automation and operational
  improvements.

### Negative

- Increases infrastructure cost.
- Increases operational complexity.
- Requires deployment and monitoring across multiple clusters.
- Introduces configuration-drift risk if regional differences are not
  controlled.
- Requires deliberate handling of regional application releases.
- Requires a separate data-layer resilience strategy.
- DNS-based traffic changes are subject to health-check behaviour and client
  DNS caching.
- Existing client connections, including WebSocket sessions, cannot be assumed
  to survive a regional traffic transition.

---

## Risks and Mitigations

| Risk | Mitigation |
|---|---|
| Configuration drift between regional platforms | Maintain common Helm charts, reusable infrastructure definitions, version-controlled configuration and explicit regional overrides. |
| `rideshare-prod-use1` and `rideshare-prod-use2` evolve differently | Treat `rideshare-prod-use1` as the first implementation of a common regional standard and reproduce validated patterns in `rideshare-prod-use2`. |
| Migration from the legacy cluster introduces application regressions | Maintain `lukman-rideshare-cluster` during the transition and validate the replacement platform before retirement. |
| Infrastructure is healthy but the RideShare application is not | Use application-level health checks and end-to-end business-flow validation rather than relying solely on infrastructure health. |
| Regional traffic routing behaves unexpectedly | Validate Route 53 routing and health-check behaviour through controlled tests. |
| Data services remain a regional dependency despite multi-region EKS | Define PostgreSQL and Redis regional architecture through dedicated ADRs and validate their failure characteristics separately. |
| Regional configuration becomes difficult to maintain | Keep reusable configuration common and isolate only genuine regional differences in region-specific values and infrastructure definitions. |
| Operational complexity increases beyond team capability | Maintain runbooks, automation, observability and documented operational procedures as part of the platform rather than treating them as post-deployment additions. |

---

## Validation

This decision is considered implemented only when the target architecture has
been demonstrated through the running platform.

Validation will be performed progressively.

### `rideshare-prod-use1`

The first regional implementation must demonstrate that:

- the EKS platform can be created according to the defined standards;
- required platform components can be installed reproducibly;
- the RideShare application can be deployed through the platform Helm
  configuration;
- application services can use Amazon RDS and Amazon ElastiCache;
- ingress and TLS function correctly;
- WebSocket connectivity functions through the public application path;
- secrets are delivered through the intended secrets-management architecture;
  and
- the RideShare end-to-end business workflow operates successfully.

### `rideshare-prod-use2`

The second regional implementation must demonstrate that:

- the validated platform pattern can be reproduced in `us-east-2`;
- the application can be deployed using the same deployment model;
- regional differences are expressed through controlled configuration rather
  than separate platform implementations; and
- the environment can operate independently as an application execution
  platform.

### Multi-Region

The overall decision is complete when:

- `rideshare-prod-use1` is operational in `us-east-1`;
- `rideshare-prod-use2` is operational in `us-east-2`;
- both regions satisfy the required application health criteria;
- Route 53 can direct traffic according to the selected regional routing
  policy;
- regional failure behaviour has been tested;
- recovery behaviour has been tested;
- the required validation evidence has been recorded; and
- `lukman-rideshare-cluster` is no longer required as part of the target
  architecture.

---

## Reconsider When

Review this decision if:

- operating two regional EKS environments no longer provides sufficient value
  relative to its cost;
- business recovery objectives can be satisfied by a less expensive
  warm-standby model;
- application architecture changes make another compute model more
  appropriate;
- data-layer constraints prevent meaningful regional resilience;
- cross-region behaviour materially affects application performance;
- multi-cluster operations become operationally unsustainable;
- Route 53-based regional traffic management no longer satisfies the required
  recovery characteristics;
- the platform adopts a different multi-region or global deployment model; or
- business, regulatory, availability or recovery requirements materially
  change.

---

## Related Documents

- [Engineering Journey](../../engineering-journey.md)
- [Current-State Architecture](../current-state/current-architecture.md)
- [Target-State Architecture](../target-state/RideShare-Platform-Target-Architecture-v3.2.md)
- [Platform Evolution Roadmap](../platform-evolution-roadmap/platform-roadmap.md)
- [Validation Plan](../platform-evolution-roadmap/validation-plan.md)
- [Architecture Decision Records](./README.md)
- [Engineering Traceability Matrix](../../engineering-traceability.md)