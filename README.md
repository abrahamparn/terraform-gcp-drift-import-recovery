# Terraform GCP Drift Detection, Import, and State Recovery

This repository is a Terraform operational lab on Google Cloud.

It demonstrates how to detect infrastructure drift, inspect Terraform state, import existing resources, and recover from state inconsistencies.

## What This Project Proves

This project proves that I understand Terraform beyond happy-path provisioning.

It demonstrates:

- baseline infrastructure creation
- manual drift simulation
- drift detection with `terraform plan`
- drift detection with `terraform plan -detailed-exitcode`
- refresh-only planning
- Terraform state inspection
- state backup using `terraform state pull`
- state recovery using `terraform import`
- importing manually created GCP resources
- scheduled drift detection using GitHub Actions
- GitHub issue creation when drift is detected
- Workload Identity Federation for keyless CI/CD authentication

## Why This Matters

Creating infrastructure is only one part of Terraform.

Real operational maturity also requires understanding what happens when:

- someone changes infrastructure manually
- state no longer matches real resources
- existing resources need to be imported
- Terraform wants to recreate something that already exists
- drift needs to be detected automatically

## Architecture

The infrastructure is intentionally small:

```text
Custom VPC
Subnet
Firewall rule
Service account
```

The goal is not complex architecture.

The goal is Terraform behavior.

## Repository Structure

```text
terraform-gcp-drift-import-recovery/
├── main.tf
├── variables.tf
├── outputs.tf
├── environments/dev.tfvars
├── imports/
├── docs/
├── scripts/
└── .github/workflows/
```

## Labs

| Lab   | Description                                      |
| ----- | ------------------------------------------------ |
| Lab 1 | Create baseline Terraform-managed infrastructure |
| Lab 2 | Simulate manual drift                            |
| Lab 3 | Detect drift with Terraform plan                 |
| Lab 4 | Import manually created infrastructure           |
| Lab 5 | Inspect Terraform state                          |
| Lab 6 | Recover after state removal                      |
| Lab 7 | Automate drift detection with GitHub Actions     |

## Important Warning

This repository intentionally demonstrates abnormal infrastructure situations.

Do not run these labs against production infrastructure.

Use a dedicated learning project.

## Quick Start

```bash
cp backend.tf.example backend.tf
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

## Simulate Drift

```bash
./scripts/simulate-drift.sh
```

Then detect:

```bash
terraform plan -var-file=environments/dev.tfvars
```

## Import Manual Resource

```bash
export PROJECT_ID="your-gcp-project-id"
./scripts/create-manual-import-resources.sh
cp imports/imported-network.tf.example imported-network.tf
terraform import -var-file=environments/dev.tfvars google_compute_network.imported_network "projects/${PROJECT_ID}/global/networks/manual-import-network"
```

## State Recovery Lab

```bash
terraform state list
terraform state pull > state-backups/before-recovery.json
terraform state rm google_compute_firewall.allow_http_internal
terraform plan -var-file=environments/dev.tfvars
terraform import -var-file=environments/dev.tfvars google_compute_firewall.allow_http_internal "projects/${PROJECT_ID}/global/firewalls/FIREWALL_RULE_NAME"
```

## Scheduled Drift Detection

The repository includes a GitHub Actions workflow:

```text
.github/workflows/drift-detection.yml
```

It runs:

```text
terraform plan -detailed-exitcode
```

If drift is detected, it creates a GitHub issue.

## Key Lesson

Terraform skill is not only creating resources.

The real skill is controlling change when infrastructure and state diverge.
