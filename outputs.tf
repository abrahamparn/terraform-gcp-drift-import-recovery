output "network_name" {
  description = "Terraform managed vpc network name"
  value       = google_compute_network.managed.name
}

output "network_self_link" {
  description = "Terraform vpc network self link"
  value       = google_compute_network.managed.self_link
}

output "subnet_name" {
  description = "Terraform subnet name"
  value       = google_compute_subnetwork.managed.name
}

output "firewall_rule_name" {
  description = "terraform managed firewall rule name."
  value       = google_compute_firewall.allow_http_internal.name
}

output "service_account_email" {
  description = "Terraform service account email"
  value       = google_service_account.managed.email
}

output "lab_summary" {
  description = "Summary of the drift/import/state recovery lab baseline."
  value = {
    project_id      = var.project_id
    region          = var.region
    environment     = var.environment
    network_name    = google_compute_network.managed.name
    subnet_name     = google_compute_subnetwork.managed.name
    firewall_rule   = google_compute_firewall.allow_http_internal.name
    service_account = google_service_account.managed.email
  }
}