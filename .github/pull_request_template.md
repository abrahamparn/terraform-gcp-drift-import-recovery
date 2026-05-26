# Pull Request

## Summary

Describe what this PR changes.

## Type of Change

- [ ] Terraform code
- [ ] Drift detection workflow
- [ ] Import lab
- [ ] State recovery lab
- [ ] Documentation
- [ ] GitHub workflow

## Terraform Checks

- [ ] terraform fmt -recursive passed
- [ ] terraform validate passed
- [ ] terraform plan reviewed
- [ ] no unexpected destroy actions
- [ ] no secrets committed
- [ ] terraform.tfvars not committed

## Drift/State Safety Checks

- [ ] This PR does not accidentally remove resources from state
- [ ] Any import instructions are documented
- [ ] Any state commands are documented as lab-only
- [ ] Recovery steps are documented

## Evidence

Paste command output:

```text
terraform plan -var-file=environments/dev.tfvars
terraform state list
```
