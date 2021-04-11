resource "kubernetes_ingress" "i" {
  depends_on = [helm_release.i]

  metadata {
    name      = var.app_name
    namespace = var.app_name
  }

  spec {
    # backend {
    #   service_name = "bitwardenrs"
    #   service_port = 80
    # }

    rule {
      host = "key.boop.ninja"
      http {
        path {
          backend {
            service_name = "bitwardenrs"
            service_port = 80
          }
          path = "/"
        }
      }
    }
  }
}
