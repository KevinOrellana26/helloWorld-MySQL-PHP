variable "namespace" {
  default = "aplicaciones-comunes"
  type = string
}

terraform {
  required_providers {
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = ">=2.21.1"
    }
  }
}

provider "kubernetes" {
}

provider "aws" {
}

////// PHP

resource "kubernetes_manifest" "php-deployment" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/php-deployment.tpl.yaml",
    {
        "namespace" = var.namespace
    }
  ))
}

resource "kubernetes_manifest" "php-service" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/php-service.tpl.yaml",
    {
        "namespace" = var.namespace
    }
  ))
}

resource "kubernetes_manifest" "php-ingress" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/php-ingress.tpl.yaml",
    {
        "namespace" = var.namespace
    }
  ))
}

/////// MySQL

resource "kubernetes_manifest" "mysql-statefulset" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/mysql-statefulset.tpl.yaml",
    {
        "namespace" = var.namespace
    }
  ))
}

resource "kubernetes_manifest" "mysql-service" {
  manifest = yamldecode(templatefile(
    "${path.module}/manifests/mysql-service.tpl.yaml",
    {
        "namespace" = var.namespace
    }
  ))
}
