resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"

    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = var.backend_replicas

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name  = "backend"
          image = var.backend_image

          port {
            container_port = tonumber(var.app_port)
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.app_config.metadata[0].name
            }
          }

          env {
            name  = "DB_PASSWORD"
            value = var.postgres_password
          }

          env {
            name  = "DB_USER"
            value = var.postgres_user
          }

          env {
            name  = "DB_NAME"
            value = var.postgres_db
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }

            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = tonumber(var.app_port)
            }

            initial_delay_seconds = 15
            period_seconds        = 10
            timeout_seconds       = 2
            failure_threshold     = 2
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = tonumber(var.app_port)
            }

            initial_delay_seconds = 10
            period_seconds        = 5
            timeout_seconds       = 2
            failure_threshold     = 2
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = "backend"
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      port        = tonumber(var.app_port)
      target_port = tonumber(var.app_port)
    }

    type = "ClusterIP"
  }
}
