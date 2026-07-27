# RideShare Platform Architecture

## Overview

This directory contains the architectural documentation for the RideShare
Platform.

The objective of the platform is to evolve the RideShare application from a
single-region Kubernetes deployment into a highly available, multi-region
platform built on AWS managed services and Amazon EKS.

The architecture documentation explains **why** the platform is designed the
way it is before describing **how** it is implemented.

Implementation details, deployment procedures and operational runbooks are
documented elsewhere in the repository.

---

# Architecture Goals

The platform has the following architectural objectives:

- Improve application availability through regional redundancy.
- Reduce operational overhead by adopting managed AWS services.
- Separate stateless workloads from stateful infrastructure.
- Provide a single global application endpoint.
- Standardize platform components across AWS regions.
- Support future platform growth with minimal architectural change.
- Document engineering decisions for future maintainers.

---

# Current Architecture

The original platform consists of a single Amazon EKS cluster hosting both the
application workloads and supporting platform services.

Major characteristics include:

- Single Amazon EKS cluster
- CloudNativePG for PostgreSQL
- Redis Operator for Redis
- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Amazon Route 53
- Helm-based application deployments

While this architecture is suitable for development and learning, it introduces
regional dependency and requires the platform team to operate stateful
infrastructure inside Kubernetes.

Further details can be found in:

```
current-state/
```

---

# Target Architecture

The target platform separates application workloads from stateful services.

Application workloads continue running inside Amazon EKS while stateful
components are provided by managed AWS services.

The resulting architecture consists of:

- Two Amazon EKS clusters
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- AWS Secrets Manager
- External Secrets Operator
- NGINX Ingress Controller
- cert-manager
- Amazon Route 53 Latency-Based Routing
- Amazon ECR
- Helm-based application deployment

This architecture allows both regions to remain active while reducing
operational responsibility for databases and caching infrastructure.

Further details can be found in:

```
target-state/
```


---


# Architecture Principles

The platform is designed around the following principles.

## Managed Services First

Where practical, operational responsibility should be delegated to managed AWS
services rather than self-managed Kubernetes workloads.

Examples include:

- Amazon RDS instead of CloudNativePG
- Amazon ElastiCache instead of Redis Operator

---

## Stateless Application Clusters

Application clusters should contain only workloads required to serve
application traffic.

Persistent state should remain external to Kubernetes wherever practical.

---

## Independent Regional Deployments

Each Amazon EKS cluster should be capable of serving production traffic
independently.

A failure affecting one region should not require redeployment of the remaining
region.

---

## Single Public Endpoint

Users should access the platform through one stable DNS name regardless of the
AWS region serving the request.

Regional routing is an infrastructure concern rather than an application
concern.

---

## Infrastructure Consistency

Platform components should remain as consistent as possible across all
supported AWS regions.

Differences between regions should be limited to infrastructure configuration
rather than application behavior.

---

## Documented Engineering Decisions

Significant architectural decisions should be documented using Architecture
Decision Records (ADRs).

The goal is to preserve engineering reasoning rather than implementation
history.

---

# Architecture Decision Records

The following ADRs document the major architectural decisions made for the
platform.

| ADR | Decision |
|------|----------|
| ADR-001 | Use Two Regional Amazon EKS Clusters |
| ADR-002 | Use Amazon RDS for PostgreSQL |
| ADR-003 | Use Amazon ElastiCache for Redis |
| ADR-004 | Use Amazon Route 53 Latency-Based Routing |

Additional ADRs should be created whenever a decision has significant
architectural impact.


---

# Migration Strategy

The platform is migrated incrementally rather than rebuilt from scratch.

The high-level migration sequence is:

```
Single Region
        │
        ▼
Managed PostgreSQL
        │
        ▼
Managed Redis
        │
        ▼
Externalized Secrets
        │
        ▼
Second Regional Cluster
        │
        ▼
Global DNS Routing
        │
        ▼
Validation
```

Detailed migration documentation is available in:

```
migration/
```

---

# Architecture Documentation Structure

```
architecture/

├── README.md
├── current-state/
├── target-state/
├── decisions/
│   ├── ADR-001-two-regional-eks-clusters.md
│   ├── ADR-002-amazon-rds.md
│   ├── ADR-003-amazon-elasticache.md
│   └── ADR-004-route53-latency-routing.md
|
└── migration/
```

---

# Intended Audience

This documentation is intended for:

- Platform Engineers
- DevOps Engineers
- Cloud Engineers
- Site Reliability Engineers
- Solution Architects
- Future project maintainers

---

# Document Maintenance

Architecture documentation should be updated whenever:

- the target architecture changes;
- a significant architectural decision is made;
- a managed service is adopted or removed;
- a new AWS region is introduced;
- the migration strategy changes.

Implementation changes that do not affect architecture should not require
updates to this documentation.