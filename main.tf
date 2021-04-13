resource "kubernetes_namespace" "i" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }
}

resource "helm_release" "i" {
  depends_on = [kubernetes_namespace.i]

  name      = var.app_name
  namespace = kubernetes_namespace.i.metadata[0].name

  repository = var.app_repo
  chart      = var.app_name
  version    = var.app_version

  cleanup_on_fail   = true
  dependency_update = true
  recreate_pods     = true

  # values = [
  #   file("./config/ingress.yml")
  # ]

  set {
    name  = "image.tag"
    value = var.image_tag
  }

  set_sensitive {
    name  = "bitwardenrs.domain"
    value = "https://${var.domain_name}"
  }

}