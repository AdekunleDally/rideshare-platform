# Platform Inventory

## Overview

This document provides an inventory of the major technologies and platform
components that support the RideShare Platform.

It serves as a high-level reference for the platform's current implementation
as it evolves from a single-region Amazon EKS deployment with Kubernetes
operators to a production-oriented, multi-region AWS platform using managed
services and Platform Engineering principles.

---

## Objectives

The Platform Inventory is intended to:

- provide visibility into the platform's major components;
- support architectural understanding;
- maintain a current reference of platform capabilities; and
- complement the architecture and governance documentation.

---

# Cloud Platform

| Component | Description |
|-----------|-------------|
| Cloud Provider | Amazon Web Services (AWS) |
| Deployment Model | Multi-region |
| Regions | us-east-1 and us-east-2 |

---

# Compute Platform

| Component | Purpose |
|-----------|---------|
| Amazon EKS | Kubernetes platform for application workloads |
| Kubernetes | Container orchestration |
| Helm | Application packaging and deployment |

---

# Networking

| Component | Purpose |
|-----------|---------|
| Amazon Route 53 | DNS and regional traffic routing |
| AWS Network Load Balancer | Regional ingress load balancing |
| NGINX Ingress Controller | HTTP(S) traffic routing into Kubernetes |

---

# Data Platform

| Component | Purpose |
|-----------|---------|
| Amazon RDS for PostgreSQL | Relational database |
| Amazon ElastiCache for Redis | Distributed caching |

---

# Security

| Component | Purpose |
|-----------|---------|
| AWS Secrets Manager | Centralized secrets management |
| External Secrets Operator | Secret synchronization |
| cert-manager | Certificate lifecycle management |
| Let's Encrypt | Public certificate authority |

---

# Platform Services

| Component | Purpose |
|-----------|---------|
| Horizontal Pod Autoscaler | Application autoscaling |
| Cluster Autoscaler | Kubernetes node autoscaling |

---

# Application Services

The RideShare Platform currently consists of the following business services:

- Frontend
- Rider Service
- Driver Service
- Trip Service
- Matching Service
- Email Service

---

# Current Platform Evolution

The platform currently reflects both its existing implementation and its target
architecture.

Current platform capabilities include:

- Amazon EKS
- Kubernetes
- Helm
- NGINX Ingress Controller
- External Secrets Operator
- cert-manager

The current platform uses Kubernetes-native operators for stateful services, while the target architecture adopts managed AWS services to improve scalability, operational efficiency and regional resilience

---

# Relationship to Other Governance Documents

This document records the major platform components currently used by the
RideShare Platform.

Related governance documents include:

- **Platform Standards**, which define the engineering standards applied across
  the platform.
- **Cloud Conventions**, which define the conventions for AWS resources.
- **Repository Standards**, which define how the repository is organized.
- **Documentation Standards**, which define how engineering documentation is
  maintained.