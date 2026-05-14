resource "kubernetes_network_policy" "deny_all" {
  metadata {
    name = "deny-all"
  }
  spec {
    pod_selector {}
    policy_types = ["Ingress", "Egress"]
  }
}

resource "kubernetes_network_policy" "allow_nginx_to_backend" {
  metadata {
    name = "allow-nginx-to-backend"
  }
  spec {
    pod_selector {
      match_labels = {
        app = "backend"
      }
    }
    policy_types = ["Ingress"]
    ingress {
      from {
        pod_selector {
          match_labels = {
            app = "nginx"
          }
        }
      }
      ports {
        port     = "8000"
        protocol = "TCP"
      }
    }
  }
}

resource "kubernetes_network_policy" "allow_backend_to_db" {
  metadata {
    name = "allow-backend-to-db"
  }
  spec {
    pod_selector {
      match_labels = {
        app = "db"
      }
    }
    policy_types = ["Ingress"]
    ingress {
      from {
        pod_selector {
          match_labels = {
            app = "backend"
          }
        }
      }
      ports {
        port     = "5432"
        protocol = "TCP"
      }
    }
  }
}
