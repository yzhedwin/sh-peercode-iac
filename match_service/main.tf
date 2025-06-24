resource "kubernetes_deployment" "peercode_match_service" {
  metadata {
    name = "peercode-match-service"
    labels = {
      app = "peercode-match-service"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-match-service"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.network/network" = "true"
          app                          = "peercode-match-service"
        }
      }

      spec {
        container {
          name              = "peercode-match-service"
          image             = "peercode_match_service:latest"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = var.match_service_port
          }
          port {
            container_port = var.openapi_service_port
          }
          env_from {
            config_map_ref {
              name = var.config_map
            }
          }
          env {
            name = "RABBITMQ_URL"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "RABBITMQ_URL"
              }
            }
          }
          env {
            name = "MONGO_PEERCODE_URL"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "MONGO_PEERCODE_URL"
              }
            }
          }
          env {
            name = "OPENAI_API_KEY"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "OPENAI_API_KEY"
              }
            }
          }
        }
        restart_policy = "Always"
      }
    }
  }
}
resource "kubernetes_service" "peercode_match_service" {
  metadata {
    labels = {
      app = "peercode-match-service"
    }
    name      = "peercode-match-service"
    namespace = "dev"

  }

  spec {
    type = "LoadBalancer"
    port {
      name        = var.match_service_port
      port        = var.match_service_port
      target_port = var.match_service_port
    }
    port {
      name        = var.openapi_service_port
      port        = var.openapi_service_port
      target_port = var.openapi_service_port
    }
    selector = {
      app = "peercode-match-service"
    }
  }
}

