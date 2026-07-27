# Success Criteria

The project is complete only when all of the following have been demonstrated.

## Cluster readiness

- Both EKS clusters are accessible from the operator workstation.
- Both clusters provide the required platform components.
- Both clusters run the same application release.
- All application pods are healthy in both clusters.

## Managed services

- Both clusters can connect to Amazon RDS.
- Both clusters can connect to Amazon ElastiCache.
- No application depends on the old CloudNativePG or Redis Operator services.
- Secrets are obtained through AWS Secrets Manager and External Secrets
  Operator.

## Traffic management

- rideshare.lukmonadeokun.com can route to either regional cluster.
- Route 53 health checks report both regional endpoints correctly.
- An unhealthy regional endpoint is removed from DNS responses.
- The healthy cluster continues serving application traffic.

## Validation

- Rider workflow works through the global hostname.
- Driver workflow works through the global hostname.
- Database writes remain available during application-cluster failover.
- Redis connectivity remains available during application-cluster failover.
- Failover and recovery times are documented.

## Documentation

- Current and target architectures are documented.
- Deployment steps are reproducible.
- Operational runbooks exist.
- Cleanup instructions are tested.