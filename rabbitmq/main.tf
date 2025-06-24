resource "kubernetes_deployment" "peercode_rabbitmq" {
  metadata {
    name = "peercode-rabbitmq"
    labels = {
      app = "peercode-rabbitmq"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-rabbitmq"
      }
    }

    template {
      metadata {
        labels = {
          app                          = "peercode-rabbitmq"
          "io.kompose.network/network" = "true"
        }
      }

      spec {
        container {
          name              = "peercode-rabbitmq"
          image             = "bitnami/rabbitmq:3.8.27-debian-10-r21"
          image_pull_policy = "Always"
          port {
            container_port = var.amqp_broker_port
          }
          port {
            container_port = var.amqp_management_port
          }

          env {
            name = "RABBITMQ_USERNAME"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "RABBITMQ_DEFAULT_USER"
              }
            }
          }
          env {
            name = "RABBITMQ_PASSWORD"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "RABBITMQ_DEFAULT_PASS"
              }
            }
          }
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "peercode_rabbitmq" {
  metadata {
    labels = {
      app = "peercode-rabbitmq"
    }
    name      = "peercode-rabbitmq"
    namespace = "dev"

  }

  spec {
    type = "ClusterIP"
    port {
      name        = "amqp"
      port        = var.amqp_broker_port
      target_port = var.amqp_broker_port
    }
    port {
      name        = "management"
      port        = var.amqp_management_port
      target_port = var.amqp_management_port
    }
    selector = {
      app = "peercode-rabbitmq"
    }
  }
}

