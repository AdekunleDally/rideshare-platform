# RideShare Platform

> Engineering the evolution of a cloud-native RideShare application from a
> single-region Kubernetes deployment to a production-oriented, multi-region
> platform built on managed AWS services and Platform Engineering principles.

## Overview

RideShare Platform documents the engineering evolution of an existing
cloud-native RideShare application.

The project begins with a single-region Amazon EKS deployment using
CloudNativePG and the Redis Operator as the engineering baseline and
incrementally evolves the platform into a standardised, production-oriented,
multi-region architecture through managed AWS services, platform governance,
deployment automation and operational excellence.

Rather than rebuilding the application from scratch, the project demonstrates
how an existing cloud-native platform can be systematically modernised through
successive engineering initiatives.

## Repository at a Glance

The repository is organised into six complementary engineering areas that
document how the RideShare platform is designed, governed, built, deployed and
operated.

```text
                         RideShare Platform
                                │
                                ▼
                     ┌─────────────────────┐
                     │    Architecture     │
                     │ What are we building│
                     │     and why?        │
                     └──────────┬──────────┘
                                │
                                ▼
                     ┌─────────────────────┐
                     │     Governance      │
                     │ What principles and │
                     │ standards guide us? │
                     └──────────┬──────────┘
                                │
                                ▼
              ┌─────────────────┴─────────────────┐
              │                                   │
              ▼                                   ▼
   ┌─────────────────────┐             ┌─────────────────────┐
   │   Infrastructure    │             │      Platform       │
   │ What cloud foundation│            │ What shared platform│
   │ supports the system? │            │ capabilities exist? │
   └──────────┬──────────┘             └──────────┬──────────┘
              │                                   │
              └─────────────────┬─────────────────┘
                                │
                                ▼
                     ┌─────────────────────┐
                     │    Applications     │
                     │ What business       │
                     │ workloads run here? │
                     └──────────┬──────────┘
                                │
                                ▼
                     ┌─────────────────────┐
                     │     Operations      │
                     │ How is the platform │
                     │ operated reliably?  │
                     └─────────────────────┘
```

Together, these areas provide a structured view of the platform's evolution
from a single-region Kubernetes deployment to a production-oriented,
multi-region AWS platform.
## Repository Structure

```text
rideshare-platform/
│
├── docs/
│   ├── architecture/
│   └── governance/
│
├── infrastructure/
│
├── platform/
│
├── applications/
│
├── operations/
│
├── README.md
└── CONTRIBUTING.md
```

## Engineering Evolution

```text
Single-Region Kubernetes Baseline
                ↓
Architecture and Platform Governance
                ↓
Multi-Region Platform Foundation
                ↓
Managed AWS Services
                ↓
Platform Automation
                ↓
Operations and Reliability

```

## Engineering Baseline

The project begins with an existing single-region Kubernetes platform composed
of the following technologies and capabilities:

- One Amazon EKS cluster
- CloudNativePG
- Redis Operator
- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Helm
- Amazon ECR

## Engineering Vision

The target state is a standardised, production-oriented, multi-region AWS
platform built around the following capabilities:

### Cloud and Data Foundation

- Two regional Amazon EKS clusters
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- Amazon Route 53 traffic management

### Platform Engineering

- Platform governance and engineering standards
- Automated infrastructure and application delivery
- Consistent platform capabilities across regions

### Operations and Reliability

- Centralised observability
- Operational controls and runbooks
- Resilience and disaster-recovery capabilities

## Platform Evolution Roadmap

| Phase | Objective | Status |
|---|---|---|
| Phase 0 | Architecture and Strategy | ✅ Complete |
| Phase 1 | Platform Governance | ✅ Complete |
| Phase 2 | Platform Evolution | ⏳ Planned |
| Phase 3 | Platform Automation | ⏳ Planned |
| Phase 4 | Platform Operations and Reliability | ⏳ Planned |

## Documentation

### Architecture

- Current-State Architecture
- Target-State Architecture
- Platform Evolution Roadmap
- Architecture Decision Records

### Governance

- Platform Standards
- Cloud Conventions
- Repository Standards
- Documentation Standards
- Platform Inventory
- Contribution Guidelines

### Project Planning

- Project Scope
- Success Criteria
- Execution Roadmap

### Implementation and Operations

- Infrastructure
- Shared Platform Capabilities
- Application Workloads
- Operations and Reliability