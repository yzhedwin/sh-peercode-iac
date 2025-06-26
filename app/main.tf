resource "kubernetes_deployment" "peercode_react" {
  metadata {
    name = "peercode-react"
    labels = {
      app = "peercode-react"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-react"
      }
    }

    template {
      metadata {
        labels = {
          app                          = "peercode-react"
          "io.kompose.network/network" = "true"
        }
      }

      spec {
        container {
          name              = "peercode-react"
          image             = "peercode_react:latest"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = var.http_port
          }
          env_from {
            config_map_ref {
              name = var.config_map
            }
          }
          env {
            name = "REACT_APP_FIREBASE_API_KEY"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "REACT_APP_FIREBASE_API_KEY"
              }
            }
          }
          env {
            name = "REACT_APP_FIREBASE_AUTH_DOMAIN"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "REACT_APP_FIREBASE_AUTH_DOMAIN"
              }
            }
          }
          env {
            name = "REACT_APP_FIREBASE_PROJECT_ID"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "REACT_APP_FIREBASE_PROJECT_ID"
              }
            }
          }
          env {
            name = "REACT_APP_FIREBASE_STORAGE_BUCKET"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "REACT_APP_FIREBASE_STORAGE_BUCKET"
              }
            }
          }
          env {
            name = "REACT_APP_FIREBASE_MESSAGING_SENDER_ID"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "REACT_APP_FIREBASE_MESSAGING_SENDER_ID"
              }
            }
          }
          env {
            name = "REACT_APP_FIREBASE_APP_ID"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "REACT_APP_FIREBASE_APP_ID"
              }
            }
          }
          env {
            name = "REACT_APP_FIREBASE_MEASUREMENT_ID"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "REACT_APP_FIREBASE_MEASUREMENT_ID"
              }
            }
          }
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "peercode_react" {
  metadata {
    labels = {
      app = "peercode-react"
    }
    name      = "peercode-react"
    namespace = "dev"
  }

  spec {
    type = "ClusterIP"
    port {
      name        = "http"
      port        = var.http_port
      target_port = var.http_port
      protocol    = "TCP"
    }
    port {
      name        = "https"
      port        = var.https_port
      target_port = var.https_port
      protocol    = "TCP"
    }
    selector = {
      app = "peercode-react"
    }
  }
}
