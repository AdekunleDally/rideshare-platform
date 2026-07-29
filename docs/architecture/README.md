# RideShare Platform Architecture

## Overview

This directory contains the architecture documentation for the RideShare
Platform.

The platform is being evolved from a single-region Kubernetes deployment into a
standardised, multi-region platform running on Amazon EKS and supported by
managed AWS services.

Rather than focusing on implementation details, these documents describe the
architectural decisions, target design and migration strategy that guide the
platform's evolution.

Deployment procedures, operational runbooks and platform standards are
documented elsewhere in the repository.

---

# Architecture Objectives

The architecture has the following objectives:

- Improve application availability through multi-region deployment.
- Reduce operational overhead by adopting managed AWS services.
- Separate stateless application workloads from stateful infrastructure.
- Standardise platform components across AWS regions.
- Provide a single global application endpoint.
- Support future platform growth with minimal architectural change.
- Document significant architectural decisions.

---

# Architecture at a Glance

The architecture documentation is organised around three questions:

## Where are we today?

The **Current Architecture** documents the existing single-region platform and
establishes the architectural baseline for the project.

Documentation:

- [Current-State Architecture](./current-state/README.md)


---

## Where are we going?

The **Target Architecture** describes the desired multi-region platform after
the planned architectural changes have been completed.

Documentation:
- [Target-State Architecture](./target-state/README.md)

---

## How do we get there?

The **Migration Strategy** documents the incremental changes required to evolve
the current platform into the target architecture.

Documentation:
- [Migration Stategy](./migration/README.md)


---

# Architecture Principles

The platform is designed around the following principles.

## Managed Services

Where practical, operational responsibility should be delegated to managed AWS
services rather than self-managed Kubernetes workloads.

Examples include:

- Amazon RDS instead of CloudNativePG
- Amazon ElastiCache instead of Redis Operator

---

## Stateless Kubernetes Clusters

Amazon EKS clusters should host application workloads and supporting platform
components while persistent application data is provided by managed services
where appropriate.

---

## Independent Regional Deployments

Each regional Kubernetes cluster should be capable of serving application
traffic independently.

A failure affecting one AWS region should not require redeployment of the
remaining region.

---

## Consistent Platform Configuration

Platform components should be deployed consistently across all AWS regions.

Regional differences should be limited to infrastructure-specific
configuration rather than application behaviour.

---

## Single Public Endpoint

Users should access the application through a single DNS name( **rideshare.lukmonadeokun.com** ) regardless of the AWS region serving the request.

Regional traffic management remains an infrastructure concern rather than an
application concern.

---

## Documented Decisions

Architectural decisions should be captured as Architecture Decision Records
(ADRs) to preserve the reasoning behind significant design choices.

---

# Architecture Decision Records

Significant architectural decisions are documented as ADRs.

| ADR | Decision |
|------|----------|
| ADR-001 | [ Use Two Regional Amazon EKS Clusters](./decisions/ADR-001-multi-region-eks.md) |
| ADR-002 | [ Use Amazon RDS for PostgreSQL](./decisions/ADR-002-managed-postgresql.md) |
| ADR-003 | [ Use Amazon ElastiCache for Redis](./decisions/ADR-003-managed-redis.md) |
| ADR-004 | [ Use Amazon Route 53 Latency-Based Routing](./decisions/ADR-004-global-dns-routing.md) |

Future architectural decisions should be documented in the same manner.

---

# Architecture Documentation Structure

```text
architecture/
├── README.md
├── current-state/
├── target-state/
├── migration/
└── decisions/
```

---

# Recommended Reading Order

Readers new to the project should review the documentation in the following
order:

1. [ Current State Architecture ](./current-state/README.md)
2. [ Target State  Architecture ](./target-state/README.md)
3. [ Migration Strategy ](./migration/README.md)
4. [ Architecture Decision Records ](./decisions/README.md)

This sequence explains the platform's starting point, its intended destination,
the steps required to reach it and the reasoning behind the major
architectural decisions.

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

# Maintaining the Architecture Documentation

The architecture documentation should be updated whenever:

- the target architecture changes;
- a significant architectural decision is made;
- a managed service is adopted or replaced;
- a new AWS region is introduced; or
- the migration strategy changes.

Implementation changes that do not affect the overall architecture should be
documented elsewhere in the repository.