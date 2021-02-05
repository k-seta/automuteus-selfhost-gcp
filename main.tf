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

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-rule"
  network = "default"
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  target_tags = ["allow-http"]
  priority    = 1000
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https-rule"
  network = "default"
  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
  target_tags = ["allow-https"]
  priority    = 1000
}

resource "google_compute_instance" "default" {
  name         = "amongmuteus"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "projects/cos-cloud/global/images/family/cos-stable"
    }
  }

  network_interface {
    network = "default"
  }



  metadata_startup_script = "echo 'hello world' > /test.txt"
}