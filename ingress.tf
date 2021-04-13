resource "kubernetes_ingress" "i" {
  depends_on = [helm_release.i]

  metadata {
    name      = var.app_name
    namespace = var.app_name
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          backend {
            service_name = "bitwardenrs"
            service_port = 80
          }
          path = "/"
        }
        path {
          backend {
            service_name = "bitwardenrs"
            service_port = 3012
          }
          path = "/notifications/hub"
        }
      }
    }
    tls {
      secret_name = kubernetes_secret.tls.metadata[0].name
    }
  }
}
