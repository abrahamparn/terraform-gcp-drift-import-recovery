locals {
  resource_prefix = "${var.environment}-${var.name_prefix}"

  common_labels = {
    environment = var.environment
    project     = "terraform-gcp-drift-import-recovery"
    managed_by  = "terraform"
  }
}