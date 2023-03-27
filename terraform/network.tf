resource "google_compute_global_address" "external_ip_devops_challenge" {
  name         = "external-ip-devops-challenge"
  address_type = "EXTERNAL"
  project = local.project_id
  description = "IP external para balanceador de carga externo"
}