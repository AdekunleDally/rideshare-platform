# Engineering Traceability Matrix

This matrix connects the project narrative to the documents and evidence that
support it.

| Reviewer question | Authoritative answer | Implementation or evidence |
|---|---|---|
| What was the original platform? | [Current-State Architecture](./architecture/current-state/current-architecture.md) | [Baseline assessment output](../scripts/assessment-output/2026-07-30_14-44-38/) |
| What limitations did it have? | [Existing Cluster Assessment](../infrastructure/assessments/cluster-assessment.md) | Assessment output and risks register |
| Which standards did it fail to meet? | [Target Architecture — limitations and standards](./architecture/target-state/RideShare-Platform-Target-Architecture-v3.2.md) | Governance documents and deviation records |
| What was retained? | [Target Architecture — retained capabilities](./architecture/target-state/RideShare-Platform-Target-Architecture-v3.2.md) | Platform and application Helm releases as implemented |
| What was replaced? | Target Architecture and ADR-002/ADR-003 | RDS and ElastiCache migration evidence |
| How was the second region designed differently? | [Engineering Journey](./engineering-journey.md) and Target Architecture | `infrastructure/regions/us-east-1/` when implemented |
| How were PostgreSQL and Redis moved? | Target Architecture, ADR-002 and ADR-003 | Data migration reports, tests and rollback evidence |
| Can the infrastructure be reproduced? | [Infrastructure](../infrastructure/README.md) | `eksctl`, Helm, automation scripts and CI/CD runs |
| What proves the migration worked? | [Validation Plan](./architecture/platform-evolution-roadmap/validation-plan.md) | [Evidence Index](../evidence/README.md) |
| What trade-offs were made? | ADRs and Target Architecture | Decision review history and operational results |

## Source-of-Truth Rules

- Current facts belong in the current-state architecture and assessment output.
- Desired end-state decisions belong in the target architecture.
- The reason for a significant decision belongs in an ADR.
- Sequence, dependencies and gates belong in the platform evolution roadmap.
- Engineering rules belong in governance.
- Commands and deployable definitions belong in infrastructure, platform and
  application directories.
- Proof belongs in `evidence/`.
