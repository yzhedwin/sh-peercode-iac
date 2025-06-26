resource "kubernetes_deployment" "peercode_question_service" {
  metadata {
    name = "peercode-question-service"
    labels = {
      app = "peercode-question-service"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-question-service"
      }
    }

    template {
      metadata {
        labels = {
          app                          = "peercode-question-service"
          "io.kompose.network/network" = "true"
        }
      }

      spec {
        container {
          name              = "peercode-question-service"
          image             = "peercode_question_service"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = var.question_service_port
          }
          env_from {
            config_map_ref {
              name = var.config_map
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

resource "kubernetes_service" "peercode_question_service" {
  metadata {
    labels = {
      app = "peercode-question-service"
    }
    name      = "peercode-question-service"
    namespace = "dev"

  }
  spec {
    type = "ClusterIP"
    port {
      port        = var.question_service_port
      target_port = var.question_service_port
    }
    selector = {
      app = "peercode-question-service"
    }
  }
}


