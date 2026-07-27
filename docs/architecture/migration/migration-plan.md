# Migration Plan

## Migration principle

Make one architectural change at a time and validate it before proceeding.

## Phase 0: Architecture and design

- Document current architecture
- Define target architecture
- Record major architecture decisions
- Define success criteria
- Identify migration risks

## Phase 1: Platform inventory

- Inventory for both EKS clusters
- Capture Kubernetes versions
- Capture installed platform components
- Capture Helm releases
- Capture CRDs
- Capture namespaces
- Capture ingress and TLS configuration
- Compare both clusters

## Phase 2: Platform standardization

- Align namespaces
- Align NGINX Ingress installations
- Align cert-manager installations
- Align External Secrets Operator
- Align storage and autoscaling components
- Eliminate undocumented configuration differences

## Phase 3: Externalize application state

- Obtain RDS connection details
- Obtain ElastiCache connection details
- Configure Secrets Manager
- Synchronize secrets into both clusters
- Test connectivity from temporary pods
- Update application configuration
- Migrate PostgreSQL schema and required data
- Validate application functionality
- Remove in-cluster PostgreSQL and Redis only after successful validation

## Phase 4: Multi-cluster application deployment

- Use one Helm chart
- Create regional values files
- Deploy the same application version to both clusters
- Validate each cluster independently through its load balancer endpoint

## Phase 5: Global traffic management

- Create Route 53 health checks
- Create routing records for both regional endpoints
- Validate normal routing
- Simulate regional failure
- Measure failover time

## Phase 6: Operational readiness

- Implement CI/CD
- Add monitoring and alerts
- Document backup and recovery
- Write runbooks
- Document costs
- Test cleanup procedures