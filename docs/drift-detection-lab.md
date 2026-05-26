# Drift Detection Lab

## Goal

Simulate a manual infrastructure change and detect it with Terraform.

## Steps

1. Deploy baseline infrastructure.
2. Modify firewall rule outside Terraform.
3. Run Terraform plan.
4. Observe drift.
5. Revert drift with Terraform apply.

## Simulate Drift

```bash
./scripts/simulate-drift.sh
```

## Detect Drift

```bash
terraform plan -var-file=environments/dev.tfvars
```

## Detect Drift with Exit Code

```bash
terraform plan -var-file=environments/dev.tfvars -detailed-exitcode
```

Exit codes:

```text
0 = no changes
1 = error
2 = changes detected
```

## Recover

```bash
terraform apply -var-file=environments/dev.tfvars
```
