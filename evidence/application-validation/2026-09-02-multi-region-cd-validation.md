# Multi-Region Continuous Delivery Validation

## Validation Record

| Field | Value |
|---|---|
| Date | 2026-09-02 |
| Repository | `AdekunleDally/rideshare-platform` |
| Application | RideShare |
| Regions | `us-east-1` and `us-east-2` |
| EKS clusters | `rideshare-prod-use1` and `rideshare-prod-use2` |
| Result | Pass |

## Objective

Confirm that the RideShare application can be deployed repeatably to both
production EKS clusters through GitHub Actions, using GitHub OpenID Connect
(OIDC) for AWS authentication and post-deployment checks for Kubernetes and
application health.

## Delivery Controls

- Both regional workflows are started explicitly through `workflow_dispatch`.
- GitHub Actions requests short-lived AWS credentials through OIDC; no static
  AWS access keys are stored in the workflows.
- The `us-east-1` workflow uses the protected `production-use1` GitHub
  Environment and its deployment approval gate.
- Concurrency groups prevent overlapping deployments to the same target.
- Helm uses the regional values file for the selected cluster.
- `helm upgrade --install` waits for the release and fails on timeout.

## Validation Performed

The regional deployment workflows performed the following checks:

1. Confirmed the AWS identity assumed by GitHub Actions.
2. Generated kubeconfig for the intended EKS cluster and region.
3. Confirmed access to the `rideshare` namespace.
4. Built the RideShare umbrella-chart dependencies.
5. Applied the regional release with Helm.
6. Confirmed the resulting Helm release status.
7. Waited for all six application deployments to complete their rollouts.
8. Listed deployments and pods in the `rideshare` namespace.
9. Called the regional application health endpoint.
10. Called the production application health endpoint.

## Observed Results

### `rideshare-prod-use2` (`us-east-2`)

- AWS OIDC authentication and EKS access succeeded.
- The Helm deployment completed successfully.
- Post-deployment rollout and workload validation succeeded.
- `https://use2.rideshare.lukmonadeokun.com/application-healthz` returned
  `OK`.
- `https://rideshare.lukmonadeokun.com/application-healthz` returned `OK`.

### `rideshare-prod-use1` (`us-east-1`)

- The `production-use1` approval gate was exercised successfully.
- AWS OIDC authentication and EKS access succeeded.
- The Helm deployment completed successfully.
- The GitHub Actions job completed successfully in 1 minute 34 seconds.
- The application deployments reached their expected availability:

| Deployment | Available replicas |
|---|---:|
| `driver-service` | 2/2 |
| `email-service` | 2/2 |
| `frontend` | 2/2 |
| `health-check` | 1/1 |
| `matching-service` | 2/2 |
| `rider-service` | 2/2 |
| `trip-service` | 2/2 |

- Newly created application pods were `Running` with zero restarts during the
  validation window.
- `https://use1.rideshare.lukmonadeokun.com/application-healthz` returned
  `OK`.
- `https://rideshare.lukmonadeokun.com/application-healthz` returned `OK`.
- The successful use1 validation is recorded by GitHub Actions run
  `33617546962`, job `100206796501`.

## Conclusion

Multi-region continuous delivery is implemented and validated for both
production regions. The workflows prove authenticated AWS access, correct EKS
targeting, repeatable Helm delivery, successful Kubernetes rollouts, healthy
workloads and successful regional and production application health checks.

This completes the continuous-delivery milestone within Phase 3. Phase 3
remains in progress until the remaining published exit criteria, including
deployment rollback validation, are completed and evidenced.

## Related Implementation

- [use1 deployment workflow](../../.github/workflows/deploy-use1.yaml)
- [use2 deployment workflow](../../.github/workflows/deploy-use2.yaml)
- [Platform Evolution Roadmap](../../docs/architecture/platform-evolution-roadmap/platform-roadmap.md)
- [Validation Plan](../../docs/architecture/platform-evolution-roadmap/validation-plan.md)
