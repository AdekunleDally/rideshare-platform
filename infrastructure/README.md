# Infrastructure

## Overview

The Infrastructure layer defines and provisions the cloud foundation that
supports the engineering evolution of the RideShare Platform.

Rather than building a cloud platform from scratch, this repository documents
how an existing single-region Amazon EKS deployment evolves into a
production-oriented, multi-region AWS platform through infrastructure
standardisation, managed AWS services and Platform Engineering practices.

Infrastructure provides the cloud resources upon which the Platform and
Applications layers are deployed and operated.

---

## Engineering Baseline

The RideShare Platform builds upon an existing cloud-native application that
was previously implemented as a single-region Amazon EKS deployment.

The original implementation is maintained as a separate baseline repository
and serves as the starting point for the engineering evolution documented
throughout this project.

Rather than recreating that implementation, the Infrastructure layer evaluates
the existing cloud foundation, defines the target infrastructure and documents
the engineering decisions required to evolve the platform into a
production-oriented, multi-region AWS platform.



---

## Purpose

The purpose of the Infrastructure layer is to establish a reproducible,
secure and scalable cloud foundation that enables the platform to evolve
without disrupting application development.

It defines how cloud resources are provisioned, organised and managed while
maintaining clear separation between infrastructure, platform services and
application workloads.

---

## Role in the Platform Evolution

The engineering baseline begins with a single-region Amazon EKS deployment
defined in the
[`rideshare-pro`](https://github.com/<your-github-username>/rideshare-pro)
repository.

That implementation uses Kubernetes-native data services through
CloudNativePG and the Redis Operator.

As the platform evolves, the Infrastructure layer progressively introduces the
cloud capabilities required to support a resilient, production-oriented,
multi-region AWS platform, including:

- Standardised regional Amazon EKS clusters
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- Amazon Route 53 traffic management
- Standardised networking
- Infrastructure automation
- Identity and security controls
- Operational infrastructure capabilities

Each evolution phase builds upon the existing infrastructure while improving
availability, scalability, maintainability and operational maturity.

The intended evolution is:

```text
rideshare-pro baseline
Single-region Amazon EKS
CloudNativePG
Redis Operator
        |
        v
Infrastructure assessment and standardisation
        |
        v
Second regional Amazon EKS cluster
        |
        v
Amazon RDS and Amazon ElastiCache
        |
        v
Multi-region traffic management
        |
        v
Automation, observability and operational controls
```

---

## Current Engineering Stage

The current infrastructure baseline, implemented in
[`rideshare-pro`](https://github.com/<your-github-username>/rideshare-pro),
consists of:

- One Amazon EKS cluster
- CloudNativePG
- Redis Operator
- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Amazon EBS CSI Driver
- Amazon ECR
- AWS Secrets Manager

The Infrastructure layer progressively evolves this baseline by introducing:

- A standardised second Amazon EKS cluster
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- Multi-region infrastructure
- Infrastructure standardisation
- Automation
- Observability
- Operational controls
- Disaster recovery capabilities

This incremental approach demonstrates how an existing cloud-native platform
can evolve into a production-oriented AWS platform without requiring an
immediate complete redesign.

---

## Responsibilities

The Infrastructure layer defines, provisions and manages the cloud resources
required by the RideShare Platform.

### Compute

- Amazon EKS clusters
- Managed node groups
- Regional cluster configuration
- Cluster-level AWS add-ons

### Networking

- Virtual Private Cloud configuration
- Public and private subnets
- Route tables
- NAT gateways
- Load balancing
- Regional network connectivity
- Security groups

### Identity

- IAM roles and policies
- OIDC providers
- IAM Roles for Service Accounts
- Regional trust relationships
- Workload access to AWS services

### Data

Current engineering baseline:

- CloudNativePG
- Redis Operator

Target platform:

- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis

### Traffic Management

- Amazon Route 53
- Regional routing
- Health checks
- Failover and latency-routing controls

### Supporting Infrastructure

- Amazon ECR
- AWS Secrets Manager
- Amazon EBS
- Supporting AWS infrastructure services

Infrastructure resources are designed to be reusable, reproducible and
consistent across environments and AWS regions.

---

## Engineering Principles

Infrastructure should be:

- Declarative
- Reproducible
- Version controlled
- Secure by default
- Environment aware
- Region aware
- Independently deployable
- Traceable to engineering decisions
- Designed for incremental platform evolution

Infrastructure provides cloud capabilities.

Platform services consume infrastructure.

Applications consume platform services.

---

## Infrastructure Organisation

Infrastructure is organised by engineering capability rather than by
individual AWS services or provisioning tools.

This enables implementation technologies to evolve over time while preserving
clear engineering responsibilities and consistent repository organisation.

The existing implementation remains available in the
[`rideshare-pro`](https://github.com/<your-github-username>/rideshare-pro)
repository, while this repository contains the assessment, target designs and
authoritative infrastructure configuration produced during the platform
evolution.

The Infrastructure layer is organised as follows:

```text
infrastructure/
├── README.md
├── assessments/
├── eks/
├── networking/
├── identity/
├── data/
├── dns/
└── validation/

---

## Relationship to the Baseline Repository

The two repositories serve different but complementary purposes.

### `rideshare-pro`

Represents the original application and infrastructure implementation,
including the existing single-region EKS environment.

### RideShare Platform Repository

Represents the structured Platform Engineering initiative that evaluates,
standardises and evolves that baseline.

The relationship between them is:

```text
rideshare-pro
Original implementation
        |
        v
Infrastructure assessment
        |
        v
Architecture and governance decisions
        |
        v
Conforming target infrastructure
        |
        v
Managed services and multi-region platform
```

The baseline repository remains the historical implementation record.

This repository becomes the authoritative source for the platform's evolving
architecture, infrastructure standards and target implementation.

---

## Relationship to Other Layers

The Infrastructure layer provisions the cloud resources required by the
Platform layer.

The Platform layer installs shared Kubernetes capabilities and platform
services onto that foundation.

The Applications layer deploys business workloads that consume those platform
services.

The Operations layer defines how the complete platform is monitored,
maintained, secured and operated.

---

## Out of Scope

The Infrastructure layer provisions cloud infrastructure.

It does not contain:

- Application source code
- Kubernetes application deployments
- Platform service deployments
- Operational procedures
- General architecture documentation
- A duplicate copy of the `rideshare-pro` repository

These responsibilities belong to their respective repository layers or remain
in the original baseline repository.