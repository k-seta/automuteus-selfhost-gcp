provider "google" {
  project = "adept-tangent-303710"
  region  = "us-east1"
  zone    = "us-east1-b"
}

terraform {
  backend "gcs" {
    bucket = "terraform-backend-268832"
  }
}

resource "google_compute_instance" "default" {
  name         = "amongmuteus"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
  }
  metadata_startup_script = "echo 'hello world' > /test.txt"
}