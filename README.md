# RideShare Multi-Region Platform

This repository documents and implements the migration of the RideShare
application from a single-region Kubernetes deployment to a multi-region
Amazon EKS platform.

## Regions and clusters

| Role | AWS region | EKS cluster |
|---|---|---|
| Primary | us-east-2 | lukman-rideshare-cluster |
| Secondary | us-east-1 | faahidah-rideshare-cluster |

## Architecture evolution

### Current state

- Single regional ingress endpoint
- Application deployed to one primary EKS cluster
- PostgreSQL managed by CloudNativePG
- Redis managed by a Kubernetes Redis Operator
- Persistent storage provided through Amazon EBS

### Target state

- Two regional Amazon EKS clusters
- One global application hostname
- Amazon Route 53 health-aware routing
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- Application deployed consistently using one Helm chart
- External Secrets Operator integrated with AWS Secrets Manager

## Project status

Current engineering phase: Phase 0 — Architecture and Platform Design

## Documentation

- [Current architecture](docs/architecture/current-state/README.md)
- [Target architecture](docs/architecture/target-state/README.md)
- [Migration plan](docs/architecture/migration/migration-plan.md)
- [Success criteria](docs/project/success-criteria.md)