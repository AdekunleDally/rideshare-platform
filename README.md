# RideShare Platform

> Engineering the evolution of a cloud-native RideShare application from a
> single-region Amazon EKS deployment with CloudNativePG and the Redis Operator
> into a reproducible, observable and resilient multi-region platform built on
> managed AWS services and Platform Engineering principles.

## Overview

This repository tells one engineering story:

```text
Original platform
lukman-rideshare-cluster in us-east-2
        |
        v
Current-state assessment
What works, what is constrained, and what fails the new standards
        |
        v
Target architecture and ADRs
What will be retained, replaced and standardised
        |
        v
Governance-compliant us-east-1 platform
rideshare-prod-use1 using RDS, ElastiCache and automation
        |
        v
Transitional multi-region operation
Legacy and compliant clusters coexist while migration is validated
        |
        v
Standardised us-east-2 platform
lukman-rideshare-cluster is replaced by rideshare-prod-use2
        |
        v
Evidence-driven completion
Automation, observability, failover and migration results are recorded
```

For the complete narrative, read [Engineering Journey](./docs/engineering-journey.md).

## Recommended Reading Order

1. [Engineering Journey](./docs/engineering-journey.md)
2. [Current-State Architecture](./docs/architecture/current-state/current-architecture.md)
3. [Existing Cluster Assessment](./infrastructure/assessments/cluster-assessment.md)
4. [Target Architecture](./docs/architecture/target-state/RideShare-Platform-Target-Architecture-v3.2.md)
5. [Architecture Decision Records](./docs/architecture/decisions/README.md)
6. [Platform Evolution Roadmap](./docs/architecture/platform-evolution-roadmap/platform-roadmap.md)
7. [Validation Plan](./docs/architecture/platform-evolution-roadmap/validation-plan.md)
8. [Evidence Index](./evidence/README.md)

## Original Platform

The engineering baseline is maintained in the separate
[`rideshare-pro`](https://github.com/adekunledally/rideshare-pro) repository.
It provides the application source code, Docker images, Helm application
configuration and the original Kubernetes implementation.

The original production-style platform is:

- `lukman-rideshare-cluster` in `us-east-2`
- a single Amazon EKS regional failure domain
- CloudNativePG for PostgreSQL inside Kubernetes
- the Opstree Redis Operator inside Kubernetes
- NGINX Ingress, cert-manager, External Secrets Operator, ECR and Helm.

It is functional and remains operational during migration, but it predates the
new governance model and is not the target standard.

## Target Platform

The target contains two equivalent regional platforms:

| Region | Target cluster | Data services |
|---|---|---|
| `us-east-1` | `rideshare-prod-use1` | Amazon RDS and Amazon ElastiCache |
| `us-east-2` | `rideshare-prod-use2` | Amazon RDS and Amazon ElastiCache |

Route 53 latency-based routing and application-level health checks provide one
public endpoint while each region retains its own EKS, ingress and application
execution capability.

The exact cross-region PostgreSQL replication and failover topology remains a
separate architectural decision because it determines consistency, RPO, RTO
and cost.

## What Changes

### Retained

Amazon EKS, the RideShare microservices, Helm, Amazon ECR, NGINX Ingress,
cert-manager, External Secrets Operator, AWS Secrets Manager, Route 53 and
IRSA.

### Replaced or standardised

- CloudNativePG is replaced by Amazon RDS for PostgreSQL.
- The Redis Operator is replaced by Amazon ElastiCache.
- The legacy cluster naming is replaced by regional naming.
- Historical configuration is converted into reproducible `eksctl`, Helm and
  scripted deployment definitions.
- Partial operations are expanded into standard metrics, logs, alerts,
  runbooks and recovery validation.

## Repository Responsibilities

```text
rideshare-pro                         rideshare-platform
Application repository               Platform repository
-----------------------               -------------------
Source code                           Architecture and governance
Dockerfiles                           AWS and EKS definitions
Application Helm charts               Platform Helm releases
Image build workflows       --->      Deployment and promotion controls
Business logic             Amazon     Observability and operations
                           ECR        Migration and validation evidence
```

## Repository Structure

```text
rideshare-platform/
├── docs/
│   ├── engineering-journey.md
│   ├── architecture/
│   └── governance/
├── infrastructure/
├── platform/
├── applications/
├── operations/
├── evidence/
└── scripts/
```

## Delivery Status

| Phase | Objective | Status |
|---|---|---|
| Phase 0 | Current assessment and target architecture | Complete |
| Phase 1 | Governance and standards | Complete |
| Phase 2 | Governance-compliant regional platform and managed data | In progress |
| Phase 3 | Reproducible delivery automation | Planned |
| Phase 4 | Observability, operations and resilience validation | Planned |

A phase is complete only when its validation evidence is recorded. Resource
creation alone is not completion.

## Reviewer Outcomes

The documentation and implementation are organised so that a reviewer can
identify:

- the original platform and its limitations
- the standards it did not fully meet
- the components retained and replaced
- how the second region improves on the baseline
- how PostgreSQL and Redis move to managed services
- whether the infrastructure can be reproduced
- what evidence proves the migration worked and
- which trade-offs shaped the final design.

See the [Engineering Traceability Matrix](./docs/engineering-traceability.md)
for direct links to each answer.
