#!/usr/bin/env bash
set -euo pipefail

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: $1 is required but was not found in PATH." >&2
    exit 1
  fi
}

require_value() {
  local name="$1"
  local value="$2"

  if [[ -z "${value}" || "${value}" == "null" ]]; then
    echo "ERROR: ${name} output is empty. Run terraform apply -var-file=environments/dev.tfvars first." >&2
    exit 1
  fi
}

require_command terraform
require_command gcloud
require_command jq

LAB_SUMMARY="$(terraform output -json lab_summary)"
FIREWALL_RULE_NAME="$(jq -r '.firewall_rule // empty' <<<"${LAB_SUMMARY}")"
PROJECT_ID="$(jq -r '.project_id // empty' <<<"${LAB_SUMMARY}")"

require_value "lab_summary.firewall_rule" "${FIREWALL_RULE_NAME}"
require_value "lab_summary.project_id" "${PROJECT_ID}"

echo "Simulating drift on firewall rule: ${FIREWALL_RULE_NAME}"
gcloud compute firewall-rules update "${FIREWALL_RULE_NAME}" \
  --project="${PROJECT_ID}" \
  --allow=tcp:80,tcp:8080 \
  --quiet
echo "Drift simulated. Terraform configuration still expects only tcp:80."
echo "Run: terraform plan -var-file=environments/dev.tfvars"
