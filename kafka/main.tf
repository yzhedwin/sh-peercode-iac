resource "kubernetes_deployment" "peercode_kafka" {
  metadata {
    name = "peercode-kafka"
    labels = {
      app = "peercode-kafka"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-kafka"
      }
    }

    template {
      metadata {
        labels = {
          app = "peercode-kafka"
        }
      }

      spec {
        container {
          name              = "peercode-kafka"
          image             = "confluentinc/cp-kafka:7.0.0"
          image_pull_policy = "Always"
          port {
            container_port = var.kafka_port
          }
          port {
            container_port = var.kafka_port_2
          }
          env_from {
            config_map_ref {
              name = var.config_map
            }
          }
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_deployment" "peercode_zookeeper" {
  metadata {
    name = "peercode-zookeeper"
    labels = {
      app = "peercode-zookeeper"
    }
    namespace = "dev"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {

        app = "peercode-zookeeper"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.network/network" = "true"
          app                          = "peercode-zookeeper"
        }
      }

      spec {
        container {
          name              = "peercode-zookeeper"
          image             = "confluentinc/cp-zookeeper:7.0.0"
          image_pull_policy = "Always"
          port {
            container_port = var.zookeeper_port
          }
          env_from {
            config_map_ref {
              name = var.config_map
            }
          }
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "peercode_kafka" {
  metadata {
    labels = {
      app = "peercode-kafka"
    }
    name      = "peercode-kafka"
    namespace = "dev"

  }

  spec {
    type = "NodePort"
    port {
      name        = "kafka"
      port        = var.kafka_port
      target_port = var.kafka_port
    }
    port {
      name        = "internal"
      port        = var.kafka_port_2
      target_port = var.kafka_port_2
    }
    selector = {
      app = "peercode-kafka"
    }
  }
}

resource "kubernetes_service" "peercode_zookeeper" {
  metadata {
    labels = {
      app = "peercode-zookeeper"
    }
    name      = "peercode-zookeeper"
    namespace = "dev"

  }

  spec {
    type = "NodePort"
    port {
      port        = var.zookeeper_port
      target_port = var.zookeeper_port
    }
    selector = {
      app = "peercode-zookeeper"
    }
  }
}

