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

## Engineering Evolution

Single-Region Platform

↓

Multi-Region Platform

↓

Platform Governance

↓

Managed AWS Services

↓

Platform Automation

↓

Operations & Reliability

## Engineering Baseline

The engineering baseline consists of:

- Single Amazon EKS cluster
- CloudNativePG
- Redis Operator
- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Helm
- Amazon ECR

## Engineering Vision

The target platform consists of:

- Two standardized Amazon EKS clusters
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- Route 53 global traffic management
- Platform governance
- Deployment automation
- Observability
- Operational controls
- Disaster Recovery

## Platform Evolution Roadmap

| Phase | Objective | Status |
|--------|-----------|--------|
| Phase 0 | Architecture & Strategy | 🚧 In Progress |
| Phase 1 | Platform Governance | ⏳planned |
| Phase 2 | Platform Evolution |  ⏳planned |
| Phase 3 | Platform Automation | ⏳ Planned |
| Phase 4 | Platform Operations & Reliability | ⏳ Planned |

## Documentation

### Architecture

- Current-State Architecture
- Target-State Architecture
- Platform Evolution Roadmap
- Architecture Decision Records

### Project

- Scope
- Success Criteria
- Execution Roadmap

### Platform

- Platform Standards
- Cloud Conventions
- Platform Inventory