# Cloud Conventions

## Overview

This document defines the cloud conventions that govern how AWS resources are
organised and managed throughout the evolution of the RideShare Platform.

These conventions promote consistency, maintainability and operational
simplicity as the platform evolves from a single-region Amazon EKS deployment
to a production-oriented, multi-region AWS platform.

The conventions apply across all AWS environments and regions that support the
platform.

---

## Objectives

The Cloud Conventions are intended to:

- promote consistent use of AWS resources;
- support standardized multi-region deployments;
- simplify platform management;
- reduce configuration drift; and
- establish a common approach to cloud resource organization.

---

# Naming Conventions

Cloud resources should use descriptive and consistent names that clearly
identify their purpose.

Naming should:

- reflect the resource's function
- remain consistent across regions
- distinguish shared resources from regional resources
- avoid ambiguous or environment-specific abbreviations where practical.

---

# Resource Organization

AWS resources should be organized according to their deployment scope.

Resources are generally classified as either:

- **Global**, where a single resource supports the entire platform; or
- **Regional**, where resources are deployed independently within each AWS
  Region.

This organization supports a scalable and maintainable multi-region
architecture.

---

# Regional Conventions

Regional deployments should follow the same engineering standards wherever
practical.

Platform capabilities should remain functionally consistent across supported
AWS Regions, while regional differences should be minimized and documented when
necessary.

---

# Resource Tagging

AWS resources should be consistently tagged to improve management, governance
and operational visibility.

Where supported, resources should include information such as:

- application
- environment
- region
- ownership
- management responsibility.

Tagging conventions should remain consistent across all supported regions.

---

# Identity and Access

Access to AWS resources should follow the principle of least privilege.

Cloud identities should:

- use role-based access where practical;
- avoid long-lived credentials;
- separate human and workload identities; and
- grant only the permissions required for their intended purpose.

---

# Networking

Networking should support secure and reliable communication between platform
components.

Cloud networking should:

- minimize unnecessary public exposure;
- favour secure communication;
- support resilient regional deployments; and
- provide consistent access to platform services.

---

# Managed Services

Where practical, managed AWS services should be preferred over self-managed
alternatives when they reduce operational complexity, improve reliability or
provide operational capabilities that support the platform's evolution.

---

# Relationship to Other Governance Documents

This document defines the AWS conventions that support the RideShare Platform.

Related governance documents include:

- **Platform Standards**, which define the engineering standards applied across
  the platform;
- **Repository Standards**, which define repository organization;
- **Platform Inventory**, which records the AWS resources and platform
  components currently in use; and
- **Documentation Standards**, which define how engineering knowledge is
  maintained.