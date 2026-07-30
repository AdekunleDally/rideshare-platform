# RideShare Platform

> Engineering the evolution of a cloud-native RideShare application from a
> single-region Kubernetes deployment to a production-oriented, multi-region
> platform built on managed AWS services and Platform Engineering principles.

## Overview

RideShare Platform documents the engineering evolution of an existing
cloud-native RideShare application.

Beginning with a single-region Amazon EKS deployment that uses CloudNativePG
and the Redis Operator for Kubernetes-native data services, the project
incrementally evolves the platform into a standardised, production-oriented,
multi-region AWS architecture through managed services, platform governance,
infrastructure standardisation, deployment automation and operational
excellence.

Rather than rebuilding the application from scratch, the project demonstrates
how an existing cloud-native platform can be systematically modernised through
successive Platform Engineering initiatives.

---

## Engineering Baseline Repository

The engineering journey documented in this repository builds upon an existing
RideShare application that was previously implemented as a single-region
Amazon EKS deployment.

That original implementation is maintained separately in the
**RideShare Pro** repository and serves as the engineering baseline for this
project.

The baseline repository contains the original infrastructure, Kubernetes
platform components and application deployments from which the platform
evolves.

This repository does not duplicate that implementation. Instead, it documents
the architectural decisions, governance standards, infrastructure evolution
and operational practices required to transform the baseline into a
production-oriented, multi-region AWS platform.

**Engineering Baseline Repository**

[rideshare-pro](https://github.com/adekunledally/rideshare-pro)

---

## Repository at a Glance

The repository is organised into six complementary engineering areas that
collectively define how the platform is designed, governed, built, deployed
and operated.

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

Together, these engineering areas provide a structured view of the platform's
evolution from a single-region Kubernetes deployment to a production-oriented,
multi-region AWS platform.

---

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

---

## Engineering Evolution

```text
Engineering Baseline
Single-Region Amazon EKS
CloudNativePG
Redis Operator
                │
                ▼
Architecture and Platform Governance
                │
                ▼
Multi-Region Infrastructure Foundation
                │
                ▼
Managed AWS Data Services
                │
                ▼
Platform Automation
                │
                ▼
Operations and Reliability
```

---

## Current Platform Baseline

The current engineering baseline consists of an existing single-region
Kubernetes platform built on the following technologies and capabilities:

- One Amazon EKS cluster
- CloudNativePG
- Redis Operator
- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Helm
- Amazon ECR
- AWS Secrets Manager
- Amazon EBS CSI Driver

---

## Engineering Vision

The target platform is a standardised, production-oriented, multi-region AWS
environment built around the following capabilities.

### Cloud Foundation

- Two regional Amazon EKS clusters
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- Amazon Route 53 global traffic management

### Platform Engineering

- Platform governance and engineering standards
- Standardised infrastructure
- Automated infrastructure provisioning
- Automated application delivery
- Consistent platform capabilities across AWS regions

### Operations and Reliability

- Centralised observability
- Operational controls and runbooks
- Disaster recovery capabilities
- Resilience engineering
- Platform health monitoring

---

## Platform Evolution Roadmap

| Phase | Objective | Status |
|--------|-----------|--------|
| Phase 0 | Architecture and Strategy | ✅ Complete |
| Phase 1 | Platform Governance | ✅ Complete |
| Phase 2 | Infrastructure Foundation | 🚧 In Progress |
| Phase 3 | Platform Automation | ⏳ Planned |
| Phase 4 | Operations and Reliability | ⏳ Planned |

---

## Documentation

### Architecture

- Current-State Architecture
- Target-State Architecture
- Platform Evolution Roadmap
- Architecture Decision Records (ADRs)

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

### Implementation

- Infrastructure
- Shared Platform Capabilities
- Application Workloads

### Operations

- Platform Operations
- Reliability Engineering
- Disaster Recovery
- Operational Runbooks