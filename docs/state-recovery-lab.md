# State Recovery Lab

## Goal

Simulate accidental state removal and recover by importing the existing resource back into state.

## Backup State

```bash
mkdir -p state-backups
terraform state pull > state-backups/before-state-rm.json
```

## Remove Firewall Rule from State

```bash
terraform state rm google_compute_firewall.allow_http_internal
```

This does not delete the real firewall rule.

## Observe Problem

```bash
terraform plan -var-file=environments/dev.tfvars
```

Terraform will try to create the firewall rule because it no longer exists in state.

Do not apply.

## Recover with Import

```bash
export PROJECT_ID="your-gcp-project-id"
export FIREWALL_RULE_NAME="dev-drift-lab-allow-http-internal"

terraform import \
  -var-file=environments/dev.tfvars \
  google_compute_firewall.allow_http_internal \
  "projects/${PROJECT_ID}/global/firewalls/${FIREWALL_RULE_NAME}"
```

## Verify Recovery

```bash
terraform state list
terraform plan -var-file=environments/dev.tfvars
```

Expected:

```text
No changes
```
