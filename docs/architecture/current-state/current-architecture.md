# Current-State Architecture (Engineering Baseline)

## Purpose

This document establishes the engineering baseline for the RideShare Platform. It describes the current platform architecture, its major architectural components, and how those components interact to deliver the application.

The platform represents the starting point for the Platform Evolution initiative and serves as the reference architecture against which future architectural decisions, platform improvements, and migration activities are measured.

Unlike the Existing Cluster Assessment, which evaluates the health and suitability of the current environment, this document focuses on describing the platform as it is presently designed and implemented.

---

## Context

The RideShare Platform is being evolved rather than rebuilt.

The objective is to incrementally modernise an existing Kubernetes-based platform into a production-oriented, multi-region architecture that adopts managed AWS services, standardised platform engineering practices, infrastructure automation, and improved operational resilience.

This document represents the current architectural baseline from which that evolution begins.

---

# Architecture Overview

The current platform is deployed within a single AWS Region (**us-east-2**) on Amazon Elastic Kubernetes Service (Amazon EKS).

The application follows a Kubernetes-native microservices architecture where independent business services are deployed as containerised workloads and exposed through a single NGINX Ingress Controller.

Persistent application data is hosted inside the Kubernetes cluster using CloudNativePG for PostgreSQL and the Redis Operator for Redis, while AWS managed services provide DNS, identity, storage and container image management.

The engineering baseline consists of:

- AWS Region: us-east-2
- Amazon EKS Cluster: **lukman-rideshare-cluster**
- Amazon Route 53
- AWS Network Load Balancer (NLB)
- NGINX Ingress Controller
- Amazon Elastic Container Registry (ECR)
- CloudNativePG
- Redis Operator
- Amazon EBS CSI Driver
- External Secrets Operator
- AWS Secrets Manager
- cert-manager
- Helm

---

# High-Level Architecture

```text
                                    Internet
                                        │
                                        ▼
                           rideshare.lukmonadeokun.com
                                        │
                                        ▼
                              Amazon Route 53
                                        │
                                        ▼
                        AWS Network Load Balancer
                                        │
                                        ▼
                         NGINX Ingress Controller
                                        │
        ┌───────────────────────────────┼───────────────────────────────┐
        │                               │                               │
        ▼                               ▼                               ▼
  Rider Service                 Driver Service                 Frontend Service
        │                               │
        ├──────────────┬────────────────┤
        ▼              ▼                ▼
 Trip Service   Matching Service   Email Service
        │
        ├──────────────────────┐
        ▼                      ▼
 PostgreSQL               Redis Cluster
 (CloudNativePG)        (Redis Operator)
```

Architecture diagrams:

- [Current Architecture](./single-region-architecture.png)
- [Current Request Flow](./single-region-request-flow.png)

---

# Architectural Characteristics

## Compute Platform

The platform is hosted on a single Amazon EKS cluster in the **us-east-2** region.

The cluster consists of:

- AWS-managed Kubernetes control plane
- Two managed worker nodes
- Kubernetes scheduler
- Amazon EBS CSI Driver
- Metrics Server
- Cluster Autoscaler

Applications are deployed as Kubernetes Deployments and distributed across the worker nodes by the Kubernetes scheduler.

---

## Networking

External application traffic follows this path:

```
Internet
    ↓
Amazon Route53
    ↓
AWS Network Load Balancer
    ↓
NGINX Ingress Controller
    ↓
Kubernetes Services
    ↓
Application Pods
```

The ingress layer provides:

- Host-based routing
- Path-based routing
- TLS termination
- WebSocket support
- HTTP request forwarding

Current application routes include:

| Path | Destination |
|------|-------------|
| / | Frontend |
| /api/v1/riders | Rider Service |
| /api/v1/drivers | Driver Service |
| /api/v1/trips | Trip Service |
| /api/v1/fares | Trip Service |
| /api/v1/matching/ws | Matching Service |
| /api/v1/emails | Email Service |

A dedicated ingress resource supports persistent WebSocket connections for real-time rider and driver communication.

---

## Application Platform

The RideShare platform is implemented as a collection of loosely coupled microservices deployed using Helm.

Current services include:

| Service | Responsibility |
|----------|----------------|
| Frontend | User interface |
| Rider Service | Rider operations |
| Driver Service | Driver operations |
| Trip Service | Trip lifecycle management |
| Matching Service | Rider-driver matching |
| Email Service | Notification delivery |

Services communicate internally using Kubernetes ClusterIP Services.

---

## Data Platform

Stateful services are hosted inside the Kubernetes cluster.

### PostgreSQL

Persistent relational data is managed using CloudNativePG.

Current capabilities include:

- PostgreSQL 16
- Three database instances
- One primary instance
- Two replica instances
- Streaming replication
- Automatic failover
- Persistent Amazon EBS storage
- Internal TLS encryption

CloudNativePG manages replication, failover and database lifecycle operations.

### Redis

Caching and transient application data are managed using Redis.

Redis is deployed through the Redis Operator as a clustered deployment consisting of:

- Three Redis shards
- One leader and one follower per shard
- Persistent Amazon EBS storage

The Redis Operator manages cluster formation, replication and recovery.

---

## Storage

Persistent storage is dynamically provisioned using the Amazon EBS CSI Driver.

The platform currently uses the **gp2** StorageClass.

Persistent volumes are attached to:

- PostgreSQL
- Redis

Application workloads remain stateless and therefore do not require persistent storage.

---

## Platform Services

Several platform services provide supporting operational capabilities.

### NGINX Ingress Controller

Provides:

- External application access
- Request routing
- TLS termination
- WebSocket support

### cert-manager

Automates the provisioning and renewal of TLS certificates obtained from Let's Encrypt using the DNS-01 challenge.

### External Secrets Operator

Synchronises application secrets from AWS Secrets Manager into Kubernetes Secrets, allowing workloads to consume Kubernetes-native secrets without direct AWS API integration.

### Cluster Autoscaler

Automatically adjusts the number of worker nodes based on cluster resource utilisation.

---

## Identity and Security

The platform integrates Kubernetes with AWS Identity and Access Management (IAM).

IAM Roles for Service Accounts (IRSA) enable workloads such as cert-manager and Cluster Autoscaler to securely access AWS APIs without storing long-lived credentials inside containers.

Sensitive application configuration is stored in AWS Secrets Manager and synchronised into Kubernetes using External Secrets Operator.

TLS certificates secure external HTTPS traffic entering the platform.

---

## Container Images

Application container images are stored in Amazon Elastic Container Registry (Amazon ECR).

Images are deployed to Kubernetes using Helm-based application releases.

---

## Deployment Model

Applications are packaged as Helm charts and deployed into Amazon EKS.

Platform infrastructure integrates Kubernetes with AWS services including:

- Amazon Route 53
- Amazon ECR
- Amazon EBS
- AWS Secrets Manager
- IAM Roles for Service Accounts

Application workloads are organised into dedicated namespaces:

| Namespace | Purpose |
|------------|---------|
| rideshare | Application workloads |
| postgres | PostgreSQL |
| redis | Redis |
| ingress-nginx | NGINX Ingress Controller |
| cert-manager | Certificate Management |
| external-secrets | Secret Management |
| cnpg-system | CloudNativePG Operator |
| redis-system | Redis Operator |

Namespace isolation separates business workloads from shared platform services.

---

# Current Request Flow

A typical client request follows the sequence below:

1. A client accesses **rideshare.lukmonadeokun.com**.
2. Amazon Route 53 resolves the hostname.
3. Traffic is directed to the AWS Network Load Balancer.
4. The Network Load Balancer forwards requests to the NGINX Ingress Controller.
5. NGINX routes requests to the appropriate Kubernetes Service.
6. Kubernetes Services forward traffic to the appropriate application pods.
7. Application services communicate with PostgreSQL and Redis within the cluster.

---

# Architecture Strengths

The current platform already demonstrates several mature cloud-native engineering practices, including:

- Kubernetes-native application deployment
- Microservices architecture
- Helm-based application packaging
- Operator-managed stateful workloads
- Automated TLS certificate management
- Externalised secrets management
- Infrastructure integration with AWS managed services
- Automatic node scaling through Cluster Autoscaler
- Dynamic persistent storage provisioning

These capabilities provide a strong foundation for future platform evolution.

---

# Engineering Constraints

Although the current architecture is functionally complete, several limitations prevent it from meeting the objectives of a resilient, production-oriented platform.

Current constraints include:

- Single-region deployment
- In-cluster PostgreSQL
- In-cluster Redis
- Limited regional resilience
- Manual operational processes
- Limited observability
- Configuration differences across environments
- Regional outages affect application availability
- Database operations remain the responsibility of the Kubernetes platform team
- The public endpoint resolves to a single regional ingress
- No global health-based traffic routing or failover

These constraints define the engineering priorities addressed throughout the Platform Evolution Roadmap.

---

# Related Documents

- Target-State Architecture
- Existing Cluster Assessment
- Migration Evolution Strategy
- Architecture Decision Records
- Platform Standards