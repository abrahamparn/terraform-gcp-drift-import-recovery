#!/bin/bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-}"
MANUAL_NETWORK_NAME="${MANUAL_NETWORK_NAME:-manual-import-network}"

if [[ -z "${PROJECT_ID}" ]]; then
  echo "ERROR: PROJECT_ID environment variable is required."
  echo "Example: export PROJECT_ID=your-gcp-project-id"
  exit 1
fi

echo "Creating manual VPC outside Terraform: ${MANUAL_NETWORK_NAME}"

gcloud compute networks create "${MANUAL_NETWORK_NAME}" \
  --project="${PROJECT_ID}" \
  --subnet-mode=custom

echo "Manual network created."
echo "Next: copy imports/imported-network.tf.example to imported-network.tf and run terraform import."
