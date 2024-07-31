variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map(any)
  default = {
    archuuid = "ae2fa45b-1e38-4bab-bcec-821496efa95d"
    env      = "Development"
  }
}

