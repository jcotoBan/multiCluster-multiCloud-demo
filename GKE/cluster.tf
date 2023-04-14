provider "google" {
  project = "playground-s-11-09fc4ba7"
  region  = "us-central1"
  credentials = file("creds/playground-s-11-09fc4ba7-4e741c50c583.json")
}

resource "google_container_cluster" "demo_cluster" {
  name               = "demo-gke-cluster"
  location           = "us-central1"
  initial_node_count = 1
  node_config {
    machine_type = "n1-standard-2"
  }
}


