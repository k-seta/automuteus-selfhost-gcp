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
    ports    = ["80", "27015"]
    protocol = "tcp"
  }
  target_tags = ["allow-http"]
  priority    = 1000
}

resource "google_compute_firewall" "allow_udp" {
  name    = "allow-udp-rule"
  network = "default"
  allow {
    ports    = ["34197"]
    protocol = "udp"
  }
  target_tags = ["allow-udp"]
  priority    = 1000
}

resource "google_compute_instance" "default" {
  name         = "automuteus"
  machine_type = "f1-micro"

  tags = ["allow-http", "allow-udp"]

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
    factorio-user = var.FACTORIO_USER
    factorio-token = var.FACTORIO_TOKEN
  }

  metadata_startup_script = file("startup.sh")
}