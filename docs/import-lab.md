# Import Lab

## Goal

Create a resource outside Terraform and import it into Terraform state.

## Create Manual Resource

```bash
export PROJECT_ID="your-gcp-project-id"
./scripts/create-manual-import-resources.sh
```

## Add Terraform Configuration

```bash
cp imports/imported-network.tf.example imported-network.tf
terraform fmt
```

## Import Resource

```bash
terraform import \
  -var-file=environments/dev.tfvars \
  google_compute_network.imported_network \
  "projects/${PROJECT_ID}/global/networks/manual-import-network"
```

## Verify

```bash
terraform state list
terraform state show google_compute_network.imported_network
terraform plan -var-file=environments/dev.tfvars
```

Expected:

```text
No changes
```
