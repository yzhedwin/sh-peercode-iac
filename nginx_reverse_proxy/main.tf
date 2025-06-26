resource "kubernetes_config_map" "nginx_conf" {
  metadata {
    name      = "nginx-conf"
    namespace = "dev"
  }

  data = {
    "nginx.conf" = file("${path.module}/nginx.conf")
  }
}

resource "kubernetes_deployment" "peercode_nginx" {
  metadata {
    name      = "peercode-nginx"
    namespace = "dev"
    labels = {
      app = "peercode-nginx"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "peercode-nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "peercode-nginx"
        }
      }
      spec {
        container {
          name  = "peercode-nginx"
          image = "nginx:latest"

          volume_mount {
            name       = "nginx-conf"
            mount_path = "/etc/nginx/nginx.conf"
            sub_path   = "nginx.conf"
          }

          port {
            container_port = 80
          }
        }

        volume {
          name = "nginx-conf"
          config_map {
            name = kubernetes_config_map.nginx_conf.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "peercode_nginx" {
  metadata {
    name      = "peercode-nginx"
    namespace = "dev"
    labels = {
      app = "peercode-nginx"
    }
  }

  spec {
    type = "ClusterIP"
    selector = {
      app = "peercode-nginx"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}
