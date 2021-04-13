variable "kube_host" {
}

variable "kube_crt" {
  default = ""
}
variable "kube_key" {
  default = ""
}
variable "app_name" {
  type        = string
  default     = ""
  description = "description"
}
variable "app_version" {
  type        = string
  default     = ""
  description = "description"
}
variable "app_repo" {
  type        = string
  default     = ""
  description = "description"
}
variable "image_tag" {
  type        = string
  default     = ""
  description = "description"
}
variable "domain_name" {
  type        = string
  default     = ""
  description = "description"
}

output "domain" {
  value = "https://${var.domain_name}"
}

variable "smtp_host" {
  default = ""
}
variable "smtp_user" {
  default = ""
}
variable "smtp_password" {
  default = ""
}