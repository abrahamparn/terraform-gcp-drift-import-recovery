# Design Decisions

## Decision 1 — Create a separate repository

This artifact is separate from the production-lite web platform because it intentionally simulates drift and state inconsistencies.

The goal is to avoid mixing failure-mode labs with the main platform repository.

## Decision 2 — Use simple GCP resources

The lab uses a VPC, subnet, firewall rule, and service account.

These resources are low-cost and easy to inspect.

The artifact focuses on Terraform behavior, not infrastructure complexity.

## Decision 3 — Use firewall rule drift as the main drift scenario

Firewall rules are easy to modify manually and easy to detect through Terraform plan.

The lab changes allowed ports outside Terraform, then uses Terraform to detect and revert the drift.

## Decision 4 — Use import for state recovery

When a resource is removed from Terraform state but still exists in Google Cloud, the preferred recovery method is to import it back into state.

This is safer than manually editing state or pushing state files.

## Decision 5 — Do not auto-apply drift remediation

The scheduled drift detection workflow only detects drift and creates a GitHub issue.

It does not automatically apply Terraform.

This avoids turning detection into uncontrolled remediation.

## Decision 6 — Use Workload Identity Federation

GitHub Actions authenticates to Google Cloud using Workload Identity Federation.

No service account JSON key is stored in GitHub.
