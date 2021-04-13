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

  set {
    name  = "image.tag"
    value = var.image_tag
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  set_sensitive {
    name  = "bitwardenrs.domain"
    value = "https://${var.domain_name}"
  }

  set {
    name  = "bitwardenrs.smtp.enabled"
    value = "true"
  }
  set {
    name  = "bitwardenrs.smtp.from"
    value = "no-reply@${var.domain_name}"
  }
  set {
    name  = "bitwardenrs.smtp.fromName"
    value = "BitWarden"
  }
  set {
    name  = "bitwardenrs.smtp.host"
    value = var.smtp_host
  }
  set_sensitive {
    name  = "bitwardenrs.smtp.user"
    value = var.smtp_user
  }
  set_sensitive {
    name  = "bitwardenrs.smtp.password"
    value = var.smtp_password
  }
  set_sensitive {
    name  = "env.SMTP_USERNAME"
    value = var.smtp_user
  }
  set_sensitive {
    name  = "env.SMTP_PASSWORD"
    value = var.smtp_password
  }
}