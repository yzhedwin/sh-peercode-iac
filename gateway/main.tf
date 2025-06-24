resource "kubernetes_deployment" "peercode_server" {
  metadata {
    name = "peercode-server"
    labels = {
      app = "peercode-server"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-server"
      }
    }

    template {
      metadata {
        labels = {
          app                          = "peercode-server"
          "io.kompose.network/network" = "true"
        }
      }

      spec {
        container {
          name              = "peercode-server"
          image             = "peercode_server:latest"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = var.server_port
          }
          env_from {
            config_map_ref {
              name = var.config_map #kubernetes_config_map.peercode_config.metadata[0].name
            }
          }
          env {
            name = "MONGO_PEERCODE_DATABASE_NAME"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "MONGO_PEERCODE_DATABASE_NAME"
              }
            }
          }
          env {
            name = "MONGO_PEERCODE_DATABASE_PASSWORD"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "MONGO_PEERCODE_DATABASE_PASSWORD"
              }
            }
          }
          env {
            name = "MONGO_PEERCODE_DATABASE_USER"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "MONGO_PEERCODE_DATABASE_USER"
              }
            }
          }
          env {
            name = "MONGO_PEERCODE_HOST_NAME"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "MONGO_PEERCODE_HOST_NAME"
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
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "peercode_server" {
  metadata {
    labels = {
      app = "peercode-server"
    }
    name      = "peercode-server"
    namespace = "dev"

  }

  spec {
    type = "LoadBalancer"
    port {
      port        = var.server_port
      target_port = var.server_port
    }
    selector = {
      app = "peercode-server"
    }
  }
}
