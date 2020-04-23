resource "google_compute_firewall" "ecommerce" {
  count   = var.enable_firewall_rule ? 1 : 0
  name    = "allow-ecommerce"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }
}

resource "google_compute_address" "ecommerce" {
  name = var.name
}