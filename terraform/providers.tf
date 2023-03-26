terraform {
    required_version = ">= 1.0"
    required_providers {
        kubernetes = {
            source = "hashicorp/kubernetes"
        }
        google = {
            source = "hashicorp/google"
        }
    }
}

provider "google" {
  project     = local.project_id
  region      = local.region
  zone        = "${var.region}-b"
}

provider "kubernetes" {
  config_path  = "~/.kube/config"
}