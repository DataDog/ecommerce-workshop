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

provider "digitalocean" {
  token = var.do_token
}

module "k8s_cluster" {
  source = "./modules/k8s/digitalocean"

  cluster_name = "ecommerce"
  region       = "nyc1"
}

provider "kubernetes" {
  host                   = module.k8s_cluster.host
  token                  = module.k8s_cluster.token
  cluster_ca_certificate = module.k8s_cluster.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = module.k8s_cluster.host
    token                  = module.k8s_cluster.token
    cluster_ca_certificate = module.k8s_cluster.cluster_ca_certificate
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
    value = module.k8s_cluster.cluster_name
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
