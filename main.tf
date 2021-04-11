variable "kube_host" {
}

variable "kube_crt" {
  default = ""
}
variable "kube_key" {
  default = ""
}
variable app_name {
  type        = string
  default     = ""
  description = "description"
}

variable app_version {
  type        = string
  default     = ""
  description = "description"
}
variable app_repo {
  type        = string
  default     = ""
  description = "description"
}

provider "helm" {
  kubernetes {
    host     = var.kube_host
    client_certificate = base64decode(var.kube_crt)
    client_key = base64decode(var.kube_key)
    insecure = true
  }
}

provider "kubernetes" {
  host     = var.kube_host
  client_certificate = base64decode(var.kube_crt)
  client_key = base64decode(var.kube_key)
  insecure = true
}

resource "kubernetes_namespace" "i" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }
}

variable domain_name {
  type        = string
  default     = ""
  description = "description"
}


resource "helm_release" "i" {
  depends_on = [kubernetes_namespace.i]

  name       = var.app_name
  namespace  = kubernetes_namespace.i.metadata[0].name

  repository = var.app_repo
  chart      = var.app_name
  version    = var.app_version

  cleanup_on_fail = true
  dependency_update = true
  recreate_pods = true

  # values = [
  #   file("./config/values.yml")
  # ]

  set_sensitive {
    name = "bitwardenrs.domain"
    value = var.domain_name
  }

}