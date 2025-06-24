resource "kubernetes_persistent_volume_claim" "peercode_mongodb_pvc" {
  metadata {
    name      = "peercode-mongodb-pvc"
    namespace = "dev" # ← optional: recommend scoping if using namespaces
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}


resource "kubernetes_deployment" "peercode_mongodb" {
  metadata {
    name = "peercode-mongodb"
    labels = {
      app = "peercode-mongodb"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app                          = "peercode-mongodb"
          "io.kompose.network/network" = "true"
        }
      }

      spec {
        container {
          name              = "peercode-mongodb"
          image             = "mongo:4.4"
          image_pull_policy = "Always"
          port {
            container_port = var.mongodb_port
          }
          env {
            name = "MONGO_INITDB_ROOT_USERNAME"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "MONGO_INITDB_ROOT_USERNAME"
              }
            }
          }
          env {
            name = "MONGO_INITDB_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = "peercode-secret"
                key  = "MONGO_INITDB_ROOT_PASSWORD"
              }
            }
          }
          volume_mount {
            name       = "peercode-mongo-storage"
            mount_path = "/data/db"
          }
        }
        volume {
          name = "peercode-mongo-storage"
          persistent_volume_claim {
            claim_name = "peercode-mongodb-pvc"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "peercode_mongodb" {
  metadata {
    labels = {
      app = "peercode-mongodb"
    }
    name      = "peercode-mongodb"
    namespace = "dev"

  }

  spec {
    type = "ClusterIP"
    port {
      protocol    = "TCP"
      port        = var.mongodb_port
      target_port = var.mongodb_port
    }
    selector = {
      app = "peercode-mongodb"
    }
  }
}
