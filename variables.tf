variable "project_id" {
  description = "Google Cloud project ID where resrouces will be created."
  type        = string

  validation {
    condition     = length(var.project_id) > 0
    error_message = "Project id must not be empty."
  }
}

variable "region" {
  description = "Default Google Cloud region for regional resources."
  type        = string
  default     = "asia-southeast2"
}

variable "environment" {
  description = "Environment name used for resource naming"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of dev, staging, prod"
  }
}

variable "name_prefix" {
  description = "Base name prefix for lab resources."
  type        = string
  default     = "drift-lab"

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]*[a-z0-9])?$", var.name_prefix))
    error_message = "name_prefix must use lowercase letters, numbers, and hyphens."
  }
}

variable "network_name" {
  description = "Base VPC network name."
  type        = string
  default     = "network"
}

variable "subnet_name" {
  description = "Base subnet name."
  type        = string
  default     = "app-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the Terraform-managed subnet."
  type        = string
  default     = "10.90.1.0/24"

  validation {
    condition     = can(cidrhost(var.subnet_cidr, 0))
    error_message = "subnet_cider must be a valid IPv4 CIDR block."
  }
}

variable "firewall_source_ranges" {
  description = "Source ranges allowed by the Terraform-managed HTTP firewall rule."
  type        = list(string)
  default     = ["10.90.0.0/16"]
}

variable "firewall_allowed_ports" {
  description = "Allowed TCP ports in the Terraform-managed firewall rule."
  type        = list(string)
  default     = ["80"]
}


variable "drift_test_label" {
  description = "Label value used to demonstrate drift sensitive resource metadata"
  type        = string
  default     = "managed"
}