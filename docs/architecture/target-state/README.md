# Target-State Architecture

## Objective

Transform the single-region RideShare deployment into a multi-region,
multi-cluster platform capable of continuing to serve traffic when one
regional EKS cluster becomes unavailable.

## Regional topology

### Primary region

- Region: us-east-2
- Cluster: lukman-rideshare-cluster
- Ingress hostname: rideshare.lukmonadeokun.com

### Secondary region

- Region: us-east-1
- Cluster: faahidah-rideshare-cluster
- Ingress hostname: rideshare.lukmonadeokun.com

Both clusters expose the same application hostname. Route 53 selects the
regional endpoint according to the configured routing and health-check policy.

## Global services

- Amazon Route 53
- Route 53 health checks
- Amazon ECR cross-region replication
- AWS Secrets Manager replication or region-specific secrets
- CI/CD deployment to both clusters

## Shared managed services

- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis

## Regional Kubernetes platform

Each cluster must provide:

- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Metrics Server
- Cluster Autoscaler
- EBS CSI driver where required
- The same application namespace
- The same Helm release and application versions

## Target request flow

1. Users access rideshare.lukmonadeokun.com.
2. Route 53 evaluates regional DNS records and endpoint health.
3. Traffic is returned to either the us-east-1 or us-east-2 ingress load
   balancer.
4. NGINX routes the request to the correct application service.
5. The microservices use shared Amazon RDS and Amazon ElastiCache services.
6. If one regional endpoint becomes unhealthy, Route 53 stops returning it
   according to the selected routing policy.