# Current-State Architecture

## Purpose

This document describes the RideShare platform before the multi-region
migration.

The current implementation runs the complete application and its stateful
dependencies inside a single Amazon EKS cluster.

## Current deployment

- AWS region: us-east-2
- EKS cluster: lukman-rideshare-cluster
- Application namespace: rideshare
- Public hostname: rideshare.lukmonadeokun.com
- Ingress: NGINX Ingress Controller
- PostgreSQL: CloudNativePG
- Redis: Redis Operator
- Storage: Amazon EBS through the EBS CSI driver
- Secrets: AWS Secrets Manager synchronized through External Secrets Operator
- TLS: cert-manager
- Package manager: Helm

## Current request flow

1. A user accesses rideshare.lukmonadeokun.com.
2. Route 53 resolves the hostname to the regional AWS load balancer.
3. The load balancer forwards traffic to the NGINX Ingress Controller.
4. NGINX routes requests to the relevant Kubernetes Service.
5. The Service forwards requests to the appropriate microservice pods.
6. Microservices communicate with PostgreSQL and Redis inside the cluster.

## Current limitations

- The platform depends on one AWS region.
- The platform depends on one EKS cluster.
- A regional outage makes the application unavailable.
- PostgreSQL and Redis operations remain the responsibility of the Kubernetes
  platform team.
- The public hostname currently points to only one regional ingress endpoint.
- The platform has no global health-based traffic failover.

## Diagrams

- [Current architecture](./current-architecture.png)
- [Current request flow](./current-request-flow.png)