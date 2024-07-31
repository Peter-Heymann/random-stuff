variable "agent_count" {
  type    = number
  default = 3
}

variable "client_id" {
  default = "your client id"
}

variable "client_secret" {
  default = "you secret id"
}

variable "cluster_name" {
  type    = string
  default = "k8stest"
}

variable "dns_prefix" {
  type    = string
  default = "k8stest"
}

variable "location" {
  type    = string
  default = "Central US"
}

variable "log_analytics_workspace_location" {
  description = "Refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions"
  type        = string
  default     = "eastus"
}

variable "log_analytics_workspace_name" {
  type    = string
  default = "testLogAnalyticsWorkspaceName"
}

variable "log_analytics_workspace_sku" {
  description = "Refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing "
  type        = string
  default     = "PerGB2018"
}

variable "rg_name" {
  type    = string
  default = "rg_k8s"
}

variable "ssh_pub_key" {
  type    = string
  default = "your ssh public key"
}

variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map(any)
  default = {
    archuuid = "cfe22fe4-ed7b-426e-a233-5ef8f399e661"
    env      = "Development"
  }
}

