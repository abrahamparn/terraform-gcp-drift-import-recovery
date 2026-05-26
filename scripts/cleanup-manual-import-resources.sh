#!/bin/bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-}"
MANUAL_NETWORK_NAME="${MANUAL_NETWORK_NAME:-manual-import-network}"

if [[ -z "${PROJECT_ID}" ]]; then
  echo "ERROR: PROJECT_ID environment variable is required."
  exit 1
fi

echo "Deleting manual/imported VPC: ${MANUAL_NETWORK_NAME}"

gcloud compute networks delete "${MANUAL_NETWORK_NAME}" \
  --project="${PROJECT_ID}" \
  --quiet

echo "Cleanup complete."
