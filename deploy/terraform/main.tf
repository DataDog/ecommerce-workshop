# Pin Terraform to at least latest
terraform {
  required_version = "~>0.13"
}

# DigitalOcean API Token. This can also be set via the
# TF_VAR_do_token environment variable
variable "do_token" {}

variable "dd_chart_version" {
  default = "2.4.25"
}

variable "dd_api_key" {
  type        = string
  description = "The Datadog API Key to configure for the agent"
}

variable "dd_app_key" {
  type        = string
  description = "The Datadog Application Key required for the Cluster Agent"
}

variable "do_region" {
  default = "nyc1"
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "stable" {
  version_prefix = "1.18."
}

resource "digitalocean_kubernetes_cluster" "ecommerce" {
  name         = "ecommerce"
  region       = var.do_region
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.stable.latest_version
  tags         = ["development"]

  node_pool {
    name       = "worker"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.ecommerce.endpoint
  token = digitalocean_kubernetes_cluster.ecommerce.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.ecommerce.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = digitalocean_kubernetes_cluster.ecommerce.endpoint
    token = digitalocean_kubernetes_cluster.ecommerce.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.ecommerce.kube_config[0].cluster_ca_certificate
    )
  }
}

resource "helm_release" "datadog" {
  repository       = "https://helm.datadoghq.com"
  name             = "datadog"
  chart            = "datadog"
  version          = var.dd_chart_version
  namespace        = "datadog-agent"
  create_namespace = true

  depends_on = [local_file.kube_config_server_yaml]

  set {
    name  = "agents.image.repository"
    value = "datadog/agent"
  }

  set {
    name  = "agents.image.tag"
    value = "latest"
  }

  set {
    name  = "agents.image.pullPolicy"
    value = "Always"
  }

  set {
    name  = "clusterAgent.enabled"
    value = "true"
  }

  set {
    name  = "clusterAgent.image.repository"
    value = "datadog/cluster-agent"
  }

  set {
    name  = "clusterAgent.image.tag"
    value = "latest"
  }

  set {
    name  = "clusterAgent.image.pullPolicy"
    value = "Always"
  }

  set {
    name  = "clusterAgent.metricsProvider.enabled"
    value = "true"
  }

  set_sensitive {
    name  = "datadog.apiKey"
    value = var.dd_api_key
  }

  set_sensitive {
    name  = "datadog.appKey"
    value = var.dd_app_key
  }

  set {
    name  = "datadog.clusterName"
    value = digitalocean_kubernetes_cluster.ecommerce.name
  }

  set {
    name  = "datadog.logs.enabled"
    value = "true"
  }

  set {
    name  = "datadog.logs.containerCollectAll"
    value = "true"
  }

  set {
    name  = "datadog.orchestratorExplorer.enabled"
    value = "true"
  }

  set {
    name  = "datadog.processAgent.enabled"
    value = "true"
  }

  set {
    name  = "datadog.processAgent.processCollection"
    value = "true"
  }

  set {
    name  = "datadog.systemProbe.enabled"
    value = "true"
  }
}
