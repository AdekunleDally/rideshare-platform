# RideShare Platform

> Platform engineering and multi-region evolution of the RideShare application on AWS, from a single-region Amazon EKS deployment to a standardised, reproducible and resilient regional architecture using managed AWS services.

## Overview

`rideshare-platform` contains the infrastructure, deployment configuration, platform services, operational tooling and engineering documentation used to evolve the RideShare platform.

The project starts from an existing production-style environment running on `lukman-rideshare-cluster` in `us-east-2`.

That environment provides the engineering baseline for the project. Rather than replacing it without context, its architecture is assessed, its limitations are documented, and the findings are used to define the target platform and the sequence of changes required to reach it.

The target is a standardised two-region platform:

| Region | EKS Cluster | PostgreSQL | Redis |
|---|---|---|---|
| `us-east-1` | `rideshare-prod-use1` | Amazon RDS | Amazon ElastiCache |
| `us-east-2` | `rideshare-prod-use2` | Amazon RDS | Amazon ElastiCache |

The migration is being performed incrementally so that changes can be validated against the working application before superseded infrastructure is retired.

---

## Platform Evolution

```text
Existing platform
lukman-rideshare-cluster
us-east-2
        |
        v
Architecture and cluster assessment
        |
        v
Governance and target architecture
        |
        v
rideshare-prod-use1
us-east-1
        |
        +-- Amazon RDS
        +-- Amazon ElastiCache
        +-- Standardised EKS platform
        |
        v
Migration and application validation
        |
        v
Multi-region operation
        |
        v
rideshare-prod-use2
us-east-2
        |
        v
Standardised two-region platform
```

The detailed engineering narrative is maintained in the [Engineering Journey](./docs/engineering-journey.md).

---

## Architecture

The target platform uses independent Amazon EKS environments in `us-east-1` and `us-east-2`.

Each regional environment is responsible for running the RideShare application and the platform components required to expose, secure and operate it.

The architecture retains:

- Amazon EKS
- Helm
- Amazon ECR
- NGINX Ingress
- cert-manager
- External Secrets Operator
- AWS Secrets Manager
- Route 53
- IAM Roles for Service Accounts (IRSA)

The principal infrastructure changes are:

- CloudNativePG â†’ Amazon RDS for PostgreSQL
- Opstree Redis Operator â†’ Amazon ElastiCache
- legacy cluster configuration â†’ standardised regional configuration
- manually accumulated infrastructure â†’ reproducible platform definitions
- single-region operation â†’ multi-region architecture

Route 53 provides the DNS layer for the multi-region application endpoint, while application-level health checks are used to determine whether a regional application path is healthy.

The exact cross-region PostgreSQL replication and failover topology is treated as a separate architectural decision because it directly affects consistency, Recovery Point Objective (RPO), Recovery Time Objective (RTO), operational complexity and cost.

See the [Target Architecture](./docs/architecture/target-state/RideShare-Platform-Target-Architecture-v3.2.md) for the complete design.

---

## Repository Responsibilities

The RideShare application and the platform used to run it are maintained separately.

### `rideshare-pro`

The [`rideshare-pro`](https://github.com/adekunledally/rideshare-pro) repository owns application development, including:

- microservice source code
- business logic
- application dependencies
- Dockerfiles
- application tests
- container image build workflows

Application releases are built as container images and published to Amazon ECR.

### `rideshare-platform`

This repository owns platform delivery and operation, including:

- AWS and EKS infrastructure
- architecture and governance
- application deployment Helm charts
- environment-specific configuration
- platform services
- secrets integration
- ingress and TLS
- managed data-service integration
- deployment and promotion configuration
- observability
- operational procedures
- migration tooling
- validation evidence

The boundary between the repositories is therefore:

> **`rideshare-pro` builds the application.  
> `rideshare-platform` defines how released application versions are deployed and operated.**

This is why application Helm charts are maintained under `applications/` in this repository. They describe deployment behaviour and environment configuration; they do not contain or own the application business logic.

---

## Original Platform

The original RideShare platform runs on:

- `lukman-rideshare-cluster`
- AWS Region `us-east-2`
- Amazon EKS
- CloudNativePG for PostgreSQL inside Kubernetes
- Opstree Redis Operator for Redis inside Kubernetes
- NGINX Ingress
- cert-manager
- External Secrets Operator
- AWS Secrets Manager
- Amazon ECR
- Helm

The environment is functional and provides the baseline against which the new platform is being designed and validated.

However, it predates the governance and regional standards introduced by this project and is therefore not considered the target implementation.

Its configuration and operational characteristics are documented in the [Current-State Architecture](./docs/architecture/current-state/current-architecture.md) and [Existing Cluster Assessment](./infrastructure/assessments/cluster-assessment.md).

---

## Target Platform

The target architecture consists of two standardised regional environments:

### `us-east-1`

```text
rideshare-prod-use1
        |
        +-- Amazon EKS
        +-- Amazon RDS for PostgreSQL
        +-- Amazon ElastiCache for Redis
        +-- NGINX Ingress
        +-- cert-manager
        +-- External Secrets Operator
        +-- AWS Secrets Manager
        +-- RideShare application services
```

### `us-east-2`

```text
rideshare-prod-use2
        |
        +-- Amazon EKS
        +-- Amazon RDS for PostgreSQL
        +-- Amazon ElastiCache for Redis
        +-- NGINX Ingress
        +-- cert-manager
        +-- External Secrets Operator
        +-- AWS Secrets Manager
        +-- RideShare application services
```

The objective is not simply to operate two Kubernetes clusters. Both regions should follow the same platform standards, naming conventions, deployment model and operational practices.

Regional differences should be expressed through environment-specific configuration rather than through independently maintained implementations.

---

## Repository Structure

```text
rideshare-platform/
â”‚
â”œâ”€â”€ applications/
â”‚   â””â”€â”€ RideShare Helm charts and regional application configuration
â”‚
â”œâ”€â”€ docs/
â”‚   â”œâ”€â”€ architecture/
â”‚   â”œâ”€â”€ governance/
â”‚   â””â”€â”€ engineering-journey.md
â”‚
â”œâ”€â”€ infrastructure/
â”‚   â””â”€â”€ AWS/EKS definitions and infrastructure assessments
â”‚
â”œâ”€â”€ platform/
â”‚   â””â”€â”€ Shared Kubernetes platform components
â”‚
â”œâ”€â”€ operations/
â”‚   â””â”€â”€ Operational procedures and runbooks
â”‚
â”œâ”€â”€ scripts/
â”‚   â””â”€â”€ Deployment, migration and validation automation
â”‚
â””â”€â”€ evidence/
    â””â”€â”€ Implementation and validation evidence
```

### `applications/`

Contains the Helm charts and environment-specific configuration required to deploy released RideShare application images onto the platform.

### `infrastructure/`

Contains infrastructure definitions, EKS configuration and assessments of the existing environment.

### `platform/`

Contains Kubernetes platform components shared by the application environment, such as ingress, certificate management and external secret integration.

### `docs/`

Contains the architecture, governance model, Architecture Decision Records (ADRs), engineering journey and platform evolution documentation.

### `operations/`

Contains operational procedures and runbooks used to operate and troubleshoot the platform.

### `scripts/`

Contains automation supporting deployment, assessment, migration and validation activities.

### `evidence/`

Contains evidence produced during implementation and validation so that significant engineering outcomes can be traced back to actual platform behaviour.

---

## Engineering Approach

The platform is being evolved through a sequence of documented and validated changes rather than through a one-time rebuild.

The existing environment provides a working baseline. Changes are introduced incrementally, validated against the application and then incorporated into the target architecture.

Major architectural decisions are captured as ADRs. Infrastructure and deployment configuration are maintained in version control, while migration work is validated against the running application before the infrastructure it replaces is retired.

This approach is particularly important for stateful platform components.

For example, replacing the Redis Operator with Amazon ElastiCache involves more than provisioning an ElastiCache replication group. The application must be reconfigured to use the managed Redis endpoint, authentication and TLS settings must be validated, the RideShare workflows must continue to operate correctly, and only then can the Kubernetes-hosted Redis implementation and its operator be retired.

The same principle applies to PostgreSQL migration, ingress, DNS, secrets management and eventually multi-region operation.

---

## Application Deployment

Application services are deployed using Helm charts maintained under:

```text
applications/rideshare/
```

The umbrella chart manages the deployment configuration for the RideShare microservices.

Environment-specific values are used to separate regional configuration from reusable application deployment definitions.

For example:

```text
applications/rideshare/
â”œâ”€â”€ Chart.yaml
â”œâ”€â”€ values.yaml
â”œâ”€â”€ values-us-east-1.yaml
â””â”€â”€ charts/
    â”œâ”€â”€ driver-service/
    â”œâ”€â”€ email-service/
    â”œâ”€â”€ frontend/
    â”œâ”€â”€ matching-service/
    â”œâ”€â”€ rider-service/
    â””â”€â”€ trip-service/
```

The platform repository does not build these applications.

Instead, application images are produced by the application repository, published to Amazon ECR and referenced by version from the deployment configuration in this repository.

This separation allows application development and platform delivery to evolve independently while maintaining a clear release boundary through container images.

---

## Managed Data Services

One of the principal changes in the target architecture is moving stateful data services out of the Kubernetes clusters.

### PostgreSQL

The original platform runs PostgreSQL through CloudNativePG.

The target platform uses Amazon RDS for PostgreSQL.

This moves database infrastructure responsibilities such as instance lifecycle, backups and underlying database infrastructure management to a managed AWS service while keeping application database configuration under platform control.

### Redis

The original platform runs Redis inside Kubernetes through the Opstree Redis Operator.

The target platform uses Amazon ElastiCache.

Application services connect to ElastiCache using environment-specific configuration and credentials delivered through the platform's secrets-management path.

Once application connectivity and end-to-end RideShare behaviour have been validated against ElastiCache, the Kubernetes RedisCluster and Redis Operator can be retired from the target environment.

The reasoning behind this change is documented in [ADR-003: Managed Redis](./docs/architecture/decisions/ADR-003-managed-redis.md).

---

## Secrets Management

Application credentials are not intended to be stored directly in Helm values or Kubernetes manifests.

The platform uses:

```text
AWS Secrets Manager
        |
        v
External Secrets Operator
        |
        v
Kubernetes Secret
        |
        v
Application Pod
```

This provides a controlled boundary between AWS-managed secrets and the Kubernetes workloads that consume them.

IRSA is used where appropriate to allow Kubernetes service accounts to access AWS services without embedding long-lived AWS credentials inside workloads.

---

## Ingress and Application Access

NGINX Ingress provides the Kubernetes ingress layer for the RideShare application.

The public application endpoint is:

```text
https://rideshare.lukmonadeokun.com
```

Ingress routing directs requests to the appropriate RideShare services, including:

```text
/api/v1/riders
/api/v1/drivers
/api/v1/trips
/api/v1/fares
/api/v1/email
/api/v1/matching/ws
/
```

WebSocket traffic for the matching service is handled separately so that connection upgrade behaviour and long-running WebSocket sessions can be configured appropriately.

TLS certificates are managed through cert-manager.

---

## Validation

Infrastructure creation alone is not treated as proof that a migration or platform change is complete.

Changes are validated at multiple levels, including:

- Kubernetes resource health
- application readiness and liveness
- service-to-service connectivity
- managed database connectivity
- Redis connectivity
- TLS and ingress behaviour
- WebSocket connectivity
- secret delivery
- application-level health endpoints
- end-to-end RideShare business workflows

Where appropriate, the resulting evidence is retained under `evidence/`.

The complete validation approach is documented in the [Validation Plan](./docs/architecture/platform-evolution-roadmap/validation-plan.md).

---

## Delivery Status

| Phase | Objective | Status |
|---|---|---|
| Phase 0 | Assess the existing platform and define the target architecture | Complete |
| Phase 1 | Establish platform governance and engineering standards | Complete |
| Phase 2 | `Build the target multi-region platform and migrate PostgreSQL and Redis to AWS-managed services | Complete |
| Phase 3 | Reproducible delivery automation | In progress |
| Phase 4 | Observability, operations and resilience validation | Planned |

A phase is considered complete when its implementation and required validation have been completed and the relevant evidence has been recorded.

The multi-region continuous-delivery milestone in Phase 3 is complete. GitHub Actions now performs controlled Helm deployments to `rideshare-prod-use1` and `rideshare-prod-use2`, validates the Kubernetes rollouts and workloads, and checks both regional and production application health endpoints. The use1 path is protected by the `production-use1` GitHub Environment approval gate. See the [multi-region CD validation record](./evidence/application-validation/2026-09-02-multi-region-cd-validation.md).

Phase 3 remains in progress until its remaining exit criteria, including deployment rollback validation, have been completed and evidenced.

See the [Platform Evolution Roadmap](./docs/architecture/platform-evolution-roadmap/platform-roadmap.md) for the implementation sequence.

---

## Documentation

The repository is intended to be read as an engineering progression rather than as a collection of unrelated infrastructure files.

For the clearest view of the project, follow this order:

1. [Engineering Journey](./docs/engineering-journey.md)
2. [Current-State Architecture](./docs/architecture/current-state/current-architecture.md)
3. [Existing Cluster Assessment](./infrastructure/assessments/cluster-assessment.md)
4. [Target Architecture](./docs/architecture/target-state/RideShare-Platform-Target-Architecture-v3.2.md)
5. [Architecture Decision Records](./docs/architecture/decisions/README.md)
6. [Platform Evolution Roadmap](./docs/architecture/platform-evolution-roadmap/platform-roadmap.md)
7. [Validation Plan](./docs/architecture/platform-evolution-roadmap/validation-plan.md)
8. [Evidence Index](./evidence/README.md)

The [Engineering Traceability Matrix](./docs/engineering-traceability.md) connects the major engineering requirements and architectural decisions to their implementation and supporting evidence.

---

## Current Direction

Both production regions now use the same controlled Helm delivery model, with successful post-deployment validation recorded for `rideshare-prod-use1` and `rideshare-prod-use2`.

The immediate focus is completing the remaining Phase 3 automation criteria, beginning with documented and validated deployment rollback behaviour. After Phase 3 is complete, work proceeds to Phase 4 observability, operational readiness and regional resilience testing.