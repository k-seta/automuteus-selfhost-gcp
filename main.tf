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

resource "google_compute_instance" "default" {
  name         = "automuteus"
  machine_type = "e2-micro"

  tags = ["allow-http"]

  boot_disk {
    initialize_params {
      image = "projects/cos-cloud/global/images/family/cos-stable"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    discord-bot-token = var.DISCORD_BOT_TOKEN
  }

  metadata_startup_script = file("startup.sh")
}