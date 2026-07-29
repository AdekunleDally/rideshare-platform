# Current-State Architecture (Engineering Baseline)

## Purpose

This document establishes the engineering baseline from which the RideShare
Platform evolution begins. It describes the original cloud-native architecture
that serves as the reference point for all subsequent engineering initiatives.

The baseline architecture consists of a single-region deployment on Amazon EKS
using in-cluster data services and supporting platform components.

---

## Context

The RideShare Platform is being evolved rather than rebuilt.

The objective is to incrementally modernise an existing Kubernetes-based
application into a production-oriented, multi-region platform that adopts
managed AWS services, standardised platform practices, automation and
operational controls.

This document represents the starting point of that journey.

---

# Architecture Overview

The engineering baseline consists of:

- AWS region: us-east-2
- Container registry: Amazon Elastic Container Registry (ECR)
- NGINX Ingress Controller
- Amazon EKS cluster: lukman-rideshare-cluster
- Application namespace: rideshare
- Public hostname: rideshare.lukmonadeokun.com
- Ingress: NGINX Ingress Controller
- PostgreSQL: CloudNativePG
- Redis: Redis Operator
- Storage: Amazon EBS through the EBS CSI driver
- Secrets: AWS Secrets Manager synchronized through External Secrets Operator
- TLS: cert-manager
- Package manager: Helm

---

# Architectural Characteristics

## Compute Platform

- Single Amazon EKS cluster
- Kubernetes-native application deployment
- Regional deployment model

---

## Application Platform

The RideShare application is deployed as a collection of loosely coupled
microservices using Helm.

Core services include:

- Frontend
- Rider Service
- Driver Service
- Trip Service
- Matching Service
- Email Service

---

## Data Platform

Stateful services are hosted inside the Kubernetes cluster.

### PostgreSQL

- CloudNativePG Operator
- Kubernetes StatefulSets
- Persistent Volumes

### Redis

- Redis Operator
- Kubernetes StatefulSets
- Persistent Volumes

---

## Networking

Application traffic is managed through:

- NGINX Ingress Controller
- Kubernetes Services
- Internal Cluster DNS

TLS certificates are managed by cert-manager.

---

## Secrets Management

Application secrets are synchronized from AWS Secrets Manager using the
External Secrets Operator (ESO).

---

## Deployment

Applications are packaged as Helm charts and deployed into Amazon EKS.

Container images are stored in Amazon ECR.

---

## Current request flow

1. A user accesses rideshare.lukmonadeokun.com.
2. Route 53 resolves the hostname to the regional AWS load balancer.
3. The load balancer forwards traffic to the NGINX Ingress Controller.
4. NGINX routes requests to the relevant Kubernetes Service.
5. The Service forwards requests to the appropriate microservice pods.
6. Microservices communicate with PostgreSQL and Redis inside the cluster.

# Architecture Diagram


- [Current architecture](./single-region-architecture.png)
- [Current request flow](./single-region-request-flow.png)
---

# Strengths

The engineering baseline already demonstrates several modern cloud-native
practices, including:

- Kubernetes-native deployments
- Containerized microservices
- Declarative infrastructure
- Automated TLS certificate management
- Externalized secrets management
- Operator-based stateful workloads
- Helm-based application packaging

These capabilities provide a strong foundation for further platform evolution.

---

# Engineering Constraints

While the baseline architecture is functionally complete, several limitations
prevent it from meeting the objectives of a production-oriented multi-region
platform.

Key constraints include:

- Single regional deployment
- In-cluster PostgreSQL
- In-cluster Redis
- Limited regional resilience
- Manual operational processes
- Limited observability
- Platform configuration differences across environments
- A regional outage makes the application unavailable.
- PostgreSQL and Redis operations remain the responsibility of the Kubernetes
  platform team.
- The public hostname currently points to only one regional ingress endpoint.
- The platform has no global health-based traffic failover.


These constraints define the engineering work addressed throughout the Platform
Evolution Roadmap.

---

# Related Documents

- [ Target State Architecture ](../target-state/README.md)
- [ Platform Evolution Roadmap ](../platform-evolution-roadmap/README.md)
- [Architecture Decision Records](../decisions/README.md)
- [Platform Standards](../../../platform/platform-standards.md)





