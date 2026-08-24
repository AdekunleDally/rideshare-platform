# Target Architecture

## Purpose

This document defines the target architecture for the RideShare platform following the assessment of the existing Kubernetes environment. It outlines the desired end-state architecture that improves resilience, scalability, operational efficiency, and maintainability while preserving components that have already proven effective.

The target architecture builds upon the current Amazon EKS platform rather than replacing it. It adopts AWS managed services where appropriate and introduces architectural improvements to support a production-ready, multi-region deployment model.

---

# Design Objectives

The target platform is designed to achieve the following objectives:

- Improve application availability and resilience.
- Reduce operational overhead for stateful services.
- Increase fault tolerance through regional redundancy.
- Standardise infrastructure provisioning and application deployment.
- Strengthen security using least-privilege access and managed identity.
- Improve observability and operational visibility.
- Maintain a cloud-native architecture based on Kubernetes.

---

# Target Architecture Overview

The RideShare platform will consist of two Amazon EKS clusters deployed across separate AWS Regions.

- **Primary Region:** us-east-2
- **Secondary Region:** us-east-1

Each region hosts a complete deployment of the application stack, enabling regional failover and reducing the impact of infrastructure failures.

External traffic is routed through Amazon Route 53 using latency-based routing with health evaluation, allowing traffic to be directed to the healthiest and lowest-latency regional endpoint.

```text
                              Users
                                │
                                ▼
                     rideshare.example.com
                                │
                       Amazon Route 53
             Latency Routing + Health Checks
                    ┌───────────┴───────────┐
                    ▼                       ▼
            us-east-2                 us-east-1
         Amazon EKS Cluster      Amazon EKS Cluster
                    │                       │
          NGINX Ingress Controller  NGINX Ingress Controller
                    │                       │
             RideShare Services     RideShare Services
```

---

# Compute Architecture

Amazon EKS remains the application hosting platform.

Each regional cluster hosts:

- Frontend
- Rider Service
- Driver Service
- Trip Service
- Matching Service
- Email Service

Application deployments continue to be managed using Helm.

Cluster Autoscaler automatically adjusts worker node capacity based on application demand.

---

# Networking Architecture

Application traffic follows the path below:

```
Internet
    │
Amazon Route 53
    │
Regional Network Load Balancer
    │
NGINX Ingress Controller
    │
Kubernetes Services
    │
Application Pods
```

NGINX Ingress Controller continues to provide:

- TLS termination
- Host and path-based routing
- WebSocket support
- Load balancing to Kubernetes Services

Route 53 health checks ensure that traffic is only directed to healthy regional endpoints.

---

# Data Architecture

## PostgreSQL

The assessment identified CloudNativePG as a reliable Kubernetes-native database platform. However, managing a production database inside Kubernetes increases operational responsibility.

The target architecture replaces CloudNativePG with **Amazon RDS for PostgreSQL**.

Benefits include:

- Automated backups
- Automated patching
- Managed failover
- High Availability (Multi-AZ)
- Reduced database administration
- Simplified operational management

Application services continue to access PostgreSQL using standard PostgreSQL connections.
 
---

## Redis

The existing Redis Operator provides a functional clustered Redis deployment.

To reduce operational complexity, the target architecture adopts **Amazon ElastiCache for Redis**.

Benefits include:

- Managed Redis clusters
- Automatic failover
- Automatic maintenance
- Simplified upgrades
- Improved operational reliability

Redis continues to provide caching and transient application data.

---

# Security Architecture

The target platform continues to use AWS Identity and Access Management (IAM) integrated with Kubernetes through IAM Roles for Service Accounts (IRSA).

Sensitive configuration remains stored in AWS Secrets Manager and synchronised into Kubernetes using External Secrets Operator.

TLS certificates continue to be managed automatically by cert-manager using Let's Encrypt.

---

# Platform Services

The following platform services are retained:

| Component | Purpose |
|----------|---------|
| NGINX Ingress Controller | Application ingress and routing |
| cert-manager | TLS certificate lifecycle |
| External Secrets Operator | Secret synchronisation |
| Cluster Autoscaler | Automatic node scaling |
| Amazon EBS CSI Driver | Persistent volume provisioning |
| Helm | Application deployment |

These components align well with Kubernetes best practices and require no architectural replacement.

---

# Observability

The target platform should provide end-to-end operational visibility through a centralised observability stack.

The platform should support:

- Metrics collection
- Log aggregation
- Distributed tracing
- Health monitoring
- Alerting

This enables faster fault detection and improved operational insight.

---

# Deployment Model

Infrastructure should be provisioned using Infrastructure as Code.

Recommended tooling:

- Terraform for AWS infrastructure
- Helm for Kubernetes applications
- GitHub Actions (or equivalent CI/CD platform) for deployment automation

This approach ensures repeatable and consistent deployments across regions.

---

# Disaster Recovery

The target architecture improves resilience by introducing regional redundancy.

Failure scenarios include:

- Pod failure
- Worker node failure
- Load balancer failure
- Cluster failure
- Regional failure

Route 53 health checks redirect traffic away from unhealthy regional endpoints, while managed AWS services provide high availability for the supporting infrastructure.

---

# Architecture Summary

The target architecture evolves the existing RideShare platform into a resilient, cloud-native, multi-region solution.

It preserves the strengths identified during the current-state assessment—Amazon EKS, NGINX Ingress Controller, Helm, cert-manager, External Secrets Operator, and IAM Roles for Service Accounts—while reducing operational overhead through the adoption of Amazon RDS for PostgreSQL and Amazon ElastiCache for Redis.

The resulting architecture provides improved scalability, availability, security, and operational simplicity while maintaining a Kubernetes-native deployment model.