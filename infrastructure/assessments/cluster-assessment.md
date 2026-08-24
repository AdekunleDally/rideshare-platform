# Existing Cluster Assessment

## Document Information

| Item | Value |
|------|-------|
| Document | Existing Cluster Assessment |
| Platform | RideShare Platform |
| Environment | Amazon EKS |
| Cluster | lukman-rideshare-cluster |
| Region | us-east-2 |
| Assessment Type | Existing Infrastructure Assessment |
| Status | Completed |
| Date | July 2026 |

---

# Executive Summary

## Purpose

This assessment evaluates the existing RideShare Platform deployed on Amazon EKS.

The objective is to understand the current infrastructure, determine its suitability as the engineering baseline, identify strengths and technical debt, and provide recommendations for evolving the platform toward a production-ready, multi-region architecture.

Rather than documenting Kubernetes resources individually, this assessment evaluates the platform from a Platform Engineering perspective by analysing compute, networking, storage, identity, security, operational capabilities, platform services and managed workloads.

---

# Assessment Scope

The assessment covers the following engineering capabilities:

- Kubernetes platform
- Compute
- Networking
- Storage
- Identity & Access Management
- Secrets Management
- Certificate Management
- Data Services
- Platform Services
- Cluster Operations
- Governance
- Infrastructure Readiness

---

# Platform Overview

The RideShare platform is deployed on a single Amazon EKS cluster within the **us-east-2** region.

The platform hosts multiple containerised microservices that communicate through Kubernetes Services and are exposed externally through an NGINX Ingress Controller backed by an AWS Network Load Balancer.

Platform capabilities include:

- Amazon EKS
- NGINX Ingress Controller
- CloudNativePG
- Redis Operator
- cert-manager
- External Secrets Operator
- Metrics Server
- Cluster Autoscaler
- Amazon EBS CSI Driver

The platform already demonstrates many production-grade capabilities while remaining intentionally simple enough to support future infrastructure evolution.

---

# 1. Compute Assessment

## Current State

The platform runs on:

- Amazon EKS
- Kubernetes v1.34
- Managed Node Group
- Two worker nodes
- t3.large EC2 instances
- Amazon Linux 2023

The Kubernetes control plane is operational, and both worker nodes are healthy and available to host application workloads.

## Assessment

### Strengths

- Managed Kubernetes control plane
- Managed node group
- Current Kubernetes release
- OIDC enabled
- Appropriate instance size for the current workload

### Risks

- Single-region deployment
- Small worker node pool
- Limited fault tolerance against regional outages

## Recommendation

Retain Amazon EKS as the orchestration platform while extending the deployment to multiple AWS regions.

Status:

**Retain**

---

# 2. Networking Assessment

## Current State

Networking is built around:

- NGINX Ingress Controller
- AWS Network Load Balancer
- Kubernetes Services
- Route53 DNS
- TLS termination

Ingress routing exposes:

- Rider Service
- Driver Service
- Trip Service
- Matching Service
- Email Service
- Frontend

A dedicated WebSocket ingress supports persistent connections to the Matching Service. TLS is configured using a cert-manager issued certificate for `rideshare.lukmonadeokun.com`.

## Assessment

### Strengths

- Central ingress layer
- TLS enabled
- Host-based routing
- Path-based routing
- WebSocket support
- Dedicated health endpoint

### Risks

- Single ingress controller
- Single regional load balancer

## Recommendation

Retain the ingress architecture while introducing multi-region routing using Amazon Route 53 latency-based routing.

Status:

**Retain and Extend**

---

# 3. Storage Assessment

## Current State

Persistent storage is dynamically provisioned using AWS EBS volumes through the gp2 StorageClass.

PostgreSQL and Redis store their data on persistent Amazon EBS volumes, ensuring that application data survives Pod restarts, rescheduling, and node failures.

## Assessment

### Strengths

- Dynamic provisioning
- Persistent volumes
- Separate storage per workload

### Risks

- Legacy gp2 storage class
- Delete reclaim policy
- No volume expansion configured

## Recommendation

Adopt gp3 StorageClasses for improved performance and lower cost while reviewing reclaim policies for production environments.

Status:

**Standardise**

---

# 4. Identity & Security Assessment

## Current State

Identity is implemented using:

- Kubernetes RBAC
- Service Accounts
- IAM Roles for Service Accounts (IRSA)
- OIDC provider

Platform workloads such as cert-manager and Cluster Autoscaler use dedicated IAM roles. 
## Assessment

### Strengths

- OIDC enabled
- IRSA adopted
- Separation of service identities

### Risks

- RBAC permissions should be periodically reviewed
- Network policies are not extensively used

## Recommendation

Retain the identity model while introducing periodic RBAC audits and namespace-level network policies.

Status:

**Retain**

---

# 5. Secrets Management Assessment

## Current State

Secrets are synchronised from AWS Secrets Manager through External Secrets Operator using a shared ClusterSecretStore.

Application namespaces consume secrets through ExternalSecrets rather than manually managed Kubernetes Secrets.
## Assessment

### Strengths

- Centralised secret management
- Secret rotation support
- Infrastructure as Code
- Reduced secret duplication

### Risks

- Cluster-wide SecretStore represents a shared dependency

## Recommendation

Retain External Secrets Operator as the platform standard.

Status:

**Retain**

---

# 6. Certificate Management Assessment

## Current State

TLS certificates are managed through cert-manager using a ClusterIssuer.

The primary application certificate is valid and Ready.
## Assessment

### Strengths

- Automated certificate issuance
- Automated renewal
- Cluster-wide issuer

### Recommendation

Retain cert-manager as the certificate management solution.

Status:

**Retain**

---

# 7. Data Services Assessment

## PostgreSQL

### Current State

CloudNativePG provides:

- Three database instances
- High availability
- Replication
- Automatic failover
- Persistent storage
- TLS
- Replication slots

### Assessment

CloudNativePG provides an excellent operational database platform for Kubernetes but increases platform operational responsibility.

### Recommendation

Future production environments should migrate to Amazon RDS PostgreSQL to reduce operational overhead.

Status:

**Migrate**

---

## Redis

### Current State

Redis is deployed using the Opstree Redis Operator with:

- Three leaders
- Three followers
- Persistent storage
- High availability

### Assessment

The Redis Operator provides resilient clustering but requires operational ownership.

### Recommendation

Adopt Amazon ElastiCache for Redis in the target architecture.

Status:

**Migrate**

---

# 8. Platform Services Assessment

Current platform services include:

- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Metrics Server
- Cluster Autoscaler
- EBS CSI Driver

All platform services are healthy and appropriately separated into dedicated namespaces. 

## Recommendation

Retain these platform services while introducing GitOps-based lifecycle management.

Status:

**Retain**

---

# 9. Operations Assessment

## Current State

Operational capabilities include:

- Horizontal autoscaling support
- Cluster autoscaling
- Health endpoints
- TLS
- Persistent storage
- Dynamic provisioning

## Gaps

The following capabilities are not yet evident from the assessment evidence:

- Centralised logging
- Distributed tracing
- Prometheus monitoring
- Grafana dashboards
- Alertmanager
- Backup validation
- Disaster recovery testing

## Recommendation

Introduce a complete observability stack before production rollout.

Status:

**Introduce**

---

# 10. Governance Assessment

The platform demonstrates strong engineering consistency:

- Dedicated namespaces
- Operator-based architecture
- Infrastructure as Code
- Managed secrets
- Automated certificates
- High availability databases

Areas for improvement include:

- Standardised platform documentation
- Architecture Decision Records
- Infrastructure governance
- Platform lifecycle documentation
- Operational runbooks

---

# Engineering Recommendations

| Area | Recommendation |
|------|----------------|
| Amazon EKS | Retain |
| NGINX Ingress | Retain |
| cert-manager | Retain |
| External Secrets | Retain |
| Cluster Autoscaler | Retain |
| CloudNativePG | Migrate to Amazon RDS |
| Redis Operator | Migrate to Amazon ElastiCache |
| Storage | Standardise on gp3 |
| Observability | Introduce |
| Disaster Recovery | Introduce |
| Multi-region | Introduce |

---

# Migration Priorities

## Phase 1

- Standardise infrastructure
- Improve documentation
- Introduce observability

## Phase 2

- Migrate PostgreSQL to Amazon RDS
- Migrate Redis to Amazon ElastiCache

## Phase 3

- Multi-region deployment
- Route53 latency routing
- Cross-region resilience

---

# Conclusion

The existing RideShare Platform provides a strong engineering baseline for future platform evolution.

The platform already incorporates several production-grade capabilities, including managed Kubernetes, operator-based infrastructure, automated certificate management, centralized secrets management, high availability data services and infrastructure automation.

The primary opportunity is not to replace the existing platform but to evolve it by reducing operational complexity through managed AWS services, strengthening governance and observability, and extending the architecture into a resilient multi-region deployment.

Overall Assessment:

**Production-ready engineering baseline with clear opportunities for platform standardisation and managed service adoption.**