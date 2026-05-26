resource "google_compute_network" "managed" {
  name                    = "${local.resource_prefix}-${var.network_name}"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "managed" {
  name                     = "${local.resource_prefix}-${var.subnet_name}"
  region                   = var.region
  network                  = google_compute_network.managed.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_http_internal" {
  name          = "${local.resource_prefix}-allow-http-internal"
  network       = google_compute_network.managed.name
  description   = "Terraform firewall rule used for drift detection demonstration"
  direction     = "INGRESS"
  source_ranges = var.firewall_source_ranges
  target_tags   = ["drift-lab-backend"]
  allow {
    protocol = "tcp"
    ports    = var.firewall_allowed_ports
  }

}

resource "google_service_account" "managed" {
  account_id   = "${var.environment}-${var.name_prefix}-sa"
  display_name = "Terraform Drift Lab Service Account"
  description  = "Service account used as a simple terraform IAM resourfe for state insspection"
}