variable "db_admin" {
  description = "MariaDB Database Admin Username"
  type        = string
  default     = "mariadbadmin"
}

variable "db_pass" {
  description = "MariaDB Database Admin Password"
  type        = string
  default     = "Br@inb0ard"
  sensitive   = true
}

variable "location" {
  type    = string
  default = "East US"
}

variable "min_tls_version" {
  type    = string
  default = "TLS1_2"
}

variable "snet_database_prefix" {
  description = "Database Subnet Prefix"
  type        = string
  default     = "10.221.10.0/24"
}

variable "snet_gateway_prefix" {
  description = "Gateway subnet prefix"
  type        = string
  default     = "10.221.9.0/24"
}

variable "snet_kube_prefix" {
  description = "Kubernetes Subnet Prefix"
  type        = string
  default     = "10.221.8.0/24"
}

variable "snet_monitoring_prefix" {
  type    = string
  default = "10.221.11.0/24"
}

variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map(any)
  default = {
    archuuid = "febbef83-b808-418a-804d-131468a0d204"
    env      = "Development"
  }
}

variable "vnet_main_addrspace" {
  description = "Virtual Network Address Space"
  type        = string
  default     = "10.221.0.0/16"
}

