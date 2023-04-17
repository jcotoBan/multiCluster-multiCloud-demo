terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}

//Karmada manager cluster

resource "linode_lke_cluster" "manager_cluster" {
    k8s_version = var.region_manager_lke_cluster[0].k8s_version
    label = var.region_manager_lke_cluster[0].label
    region = var.region_manager_lke_cluster[0].region

    dynamic "pool" {
        for_each = var.region_manager_lke_cluster[0].pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
}

//US zone cluster

resource "linode_lke_cluster" "us_lke_cluster" {
    k8s_version = var.us_lke_cluster[0].k8s_version
    label = var.us_lke_cluster[0].label
    region = var.us_lke_cluster[0].region

    dynamic "pool" {
        for_each = var.us_lke_cluster[0].pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
}

//EU zone cluster

resource "linode_lke_cluster" "eu_lke_cluster" {
    k8s_version = var.eu_lke_cluster[0].k8s_version
    label = var.eu_lke_cluster[0].label
    region = var.eu_lke_cluster[0].region

    dynamic "pool" {
        for_each = var.eu_lke_cluster[0].pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
}

//AP zone cluster

resource "linode_lke_cluster" "ap_lke_cluster" {
    k8s_version = var.ap_lke_cluster[0].k8s_version
    label = var.ap_lke_cluster[0].label
    region = var.ap_lke_cluster[0].region

    dynamic "pool" {
        for_each = var.ap_lke_cluster[0].pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
}

//Export this cluster's attributes

output "kubeconfig_cluster_manager" {
   value = linode_lke_cluster.manager_cluster.kubeconfig
   sensitive = true
}

output "kubeconfig_us" {
   value = linode_lke_cluster.us_lke_cluster.kubeconfig
   sensitive = true
}

output "kubeconfig_eu" {
   value = linode_lke_cluster.eu_lke_cluster.kubeconfig
   sensitive = true
}

output "kubeconfig_ap" {
   value = linode_lke_cluster.ap_lke_cluster.kubeconfig
   sensitive = true
}

variable "region_manager_lke_cluster"{}
variable "us_lke_cluster"{}
variable "eu_lke_cluster"{}
variable "ap_lke_cluster"{}