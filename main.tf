variable "namespace" {
  default = "aplicaciones-comunes"
  type    = string
}

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.21.1"
    }
  }
}

provider "kubernetes" {
}

provider "aws" {
}

////// PHP

resource "kubernetes_deployment" "php-mysql-deployment" {
  metadata {
    name      = "php-mysql"
    namespace = var.namespace
  }
  spec {
    selector {
      match_labels = {
        app  = "php"
        tier = "frontend"
      }
    }
    replicas = 1
    template {
      metadata {
        labels = {
          app  = "php"
          tier = "frontend"
        }
      }
      spec {
        container {
          name  = "php"
          image = "kevinorellana/mysql:php"
          port {
            container_port = 80
            name           = "php"
          }
          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "php-mysql-service" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/php-service.tpl.yaml",
    {
      "namespace" = var.namespace
    }
  ))
}

resource "kubernetes_manifest" "php-mysql-ingress" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/php-ingress.tpl.yaml",
    {
      "namespace" = var.namespace
    }
  ))
}

/////// MySQL

resource "kubernetes_stateful_set" "mysql-statefulset" {
  metadata {
    name      = "mysql"
    namespace = var.namespace
  }
  spec {
    selector {
      match_labels = {
        app  = "mysql"
        tier = "mysql"
      }
    }
    replicas     = 1
    service_name = "mysql"
    template {
      metadata {
        labels = {
          app  = "mysql"
          tier = "mysql"
        }
      }
      spec {
        container {
          name    = "mysql"
          image   = "mysql:latest"
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "root"
          }
          port {
            protocol       = "TCP"
            container_port = 3306
            name           = "mysql"
          }
          volume_mount {
            name       = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
          volume_mount {
            name       = "data"
            mount_path = "/mysql"
          }
        }
        volume {
          name = "mysql-persistent-storage"
          persistent_volume_claim {
            claim_name = "mysql-pv-claim"
          }
        }
        volume {
          name = "data"
          host_path {
            path = "/docker-entrypoint-initdb.d"
          }
        }
      }
    }
    volume_claim_template {
      metadata {
        name      = "mysql-persistent-storage"
        namespace = var.namespace
      }
      spec {
        storage_class_name = "gp3"
        access_modes       = ["ReadWriteOnce"]
        resources {
          requests = {
            storage = "1Gi"
          }
        }
      }
    }
  }
}

resource "kubernetes_manifest" "mysql-service" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/mysql-service.tpl.yaml",
    {
      "namespace" = var.namespace
    }
  ))
}
