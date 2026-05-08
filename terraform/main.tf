terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_config_map" "app_config" {
  metadata {
    name = "app-config"
  }

  data = {
    APP_PORT    = var.app_port
    DB_HOST     = var.db_host
    DB_PORT     = var.db_port
    POSTGRES_DB = var.postgres_db
    POSTGRES_USER = var.postgres_user
  }
}
