# Evidence Index

## Purpose

This directory is the audit trail for the platform evolution. It records the
outputs that prove the architecture was implemented and validated.

## Existing Evidence

The initial cluster assessment was captured by
[`scripts/cluster-assessment.sh`](../scripts/cluster-assessment.sh).

The dated baseline output is stored in:

- [`scripts/assessment-output/2026-07-30_14-44-38/`](../scripts/assessment-output/2026-07-30_14-44-38/)

It includes AWS, EKS, workloads, networking, identity, CloudNativePG, Redis,
storage, certificates and External Secrets information.

## Required Evidence Structure

```text
evidence/
├── baseline/
├── us-east-1-build/
├── postgres-migration/
├── redis-migration/
├── application-validation/
├── route53-failover/
├── observability/
├── us-east-2-rebuild/
└── final-compliance/
```

Each completed activity should include:

- date and environment;
- change or test performed;
- expected result;
- actual result;
- relevant command output, logs or screenshots;
- pass/fail conclusion;
- rollback result where applicable;
- linked issue, pull request or ADR.

## Completion Rule

A roadmap phase is not complete until the required validation evidence is
stored here and linked from the validation plan or migration report.
