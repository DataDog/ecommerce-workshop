resource "aws_ecs_cluster" "ecommerce-microservices" {
    name = "ecommerce-microservices"
}

resource "aws_ecs_task_definition" "ecommerce" {
      family = "ecommerce"

      container_definitions = <<DEFINITION
[
 {
  "ipcMode": null,
  "executionRoleArn": null,
  "containerDefinitions": [
    {
      "dnsSearchDomains": null,
      "logConfiguration": null,
      "entryPoint": null,
      "portMappings": [
        {
          "hostPort": 3000,
          "protocol": "tcp",
          "containerPort": 3000
        }
      ],
      "command": [
        "sh",
        "docker-entrypoint.sh"
      ],
      "linuxParameters": null,
      "cpu": 0,
      "environment": [
        {
          "name": "DB_PASSWORD",
          "value": "${var.postgres_password}"
        },
        {
          "name": "DB_USERNAME",
          "value": "${var.postgres_username}"
        },
        {
          "name": "DD_AGENT_HOST",
          "value": "agent"
        },
        {
          "name": "DD_ANALYTICS_ENABLED",
          "value": "true"
        },
        {
          "name": "DD_LOGS_INJECTION",
          "value": "true"
        }
      ],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [],
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": null,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "arapulido/ecommerce-storefront-instrumented:new-images",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": [
        "db",
        "discounts",
        "advertisements",
        "agent"
      ],
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "frontend"
    },
    {
      "dnsSearchDomains": null,
      "logConfiguration": null,
      "entryPoint": null,
      "portMappings": [
        {
          "hostPort": 5001,
          "protocol": "tcp",
          "containerPort": 5001
        }
      ],
      "command": [
        "ddtrace-run",
        "flask",
        "run",
        "--port=5001",
        "--host=0.0.0.0"
      ],
      "linuxParameters": null,
      "cpu": 0,
      "environment": [
        {
          "name": "DATADOG_SERVICE_NAME",
          "value": "discounts-service"
        },
        {
          "name": "DD_AGENT_HOST",
          "value": "agent"
        },
        {
          "name": "DD_ANALYTICS_ENABLED",
          "value": "true"
        },
        {
          "name": "DD_LOGS_INJECTION",
          "value": "true"
        },
        {
          "name": "FLASK_APP",
          "value": "discounts.py"
        },
        {
          "name": "POSTGRES_PASSWORD",
          "value": "${var.postgres_password}"
        },
        {
          "name": "POSTGRES_USER",
          "value": "${var.postgres_username}"
        }
      ],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [],
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": null,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "arapulido/ecommerce-spree-discounts:latest",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": [
        "db",
        "agent"
      ],
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "discounts"
    },
    {
      "dnsSearchDomains": null,
      "logConfiguration": null,
      "entryPoint": null,
      "portMappings": [],
      "command": null,
      "linuxParameters": null,
      "cpu": 0,
      "environment": [
        {
          "name": "POSTGRES_PASSWORD",
          "value": "${var.postgres_password}"
        },
        {
          "name": "POSTGRES_USER",
          "value": "${var.postgres_username}"
        }
      ],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [],
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": null,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "postgres:11-alpine",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": null,
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "db"
    },
    {
      "dnsSearchDomains": null,
      "logConfiguration": null,
      "entryPoint": null,
      "portMappings": [
        {
          "hostPort": 5002,
          "protocol": "tcp",
          "containerPort": 5002
        }
      ],
      "command": [
        "ddtrace-run",
        "flask",
        "run",
        "--port=5002",
        "--host=0.0.0.0"
      ],
      "linuxParameters": null,
      "cpu": 0,
      "environment": [
        {
          "name": "DATADOG_SERVICE_NAME",
          "value": "advertisements-service"
        },
        {
          "name": "DD_AGENT_HOST",
          "value": "agent"
        },
        {
          "name": "DD_ANALYTICS_ENABLED",
          "value": "true"
        },
        {
          "name": "DD_LOGS_INJECTION",
          "value": "true"
        },
        {
          "name": "FLASK_APP",
          "value": "ads.py"
        },
        {
          "name": "POSTGRES_PASSWORD",
          "value": "${var.postgres_password}"
        },
        {
          "name": "POSTGRES_USER",
          "value": "${var.postgres_username}"
        }
      ],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [],
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": null,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "arapulido/ecommerce-spree-ads:latest",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": [
        "agent",
        "db"
      ],
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "advertisements"
    },
    {
      "dnsSearchDomains": null,
      "logConfiguration": null,
      "entryPoint": null,
      "portMappings": [
        {
          "hostPort": 8126,
          "protocol": "tcp",
          "containerPort": 8126
        }
      ],
      "command": null,
      "linuxParameters": null,
      "cpu": 0,
      "environment": [
        {
          "name": "DD_LOGS_ENABLED",
          "value": "true"
        },
        {
          "name": "DD_TAGS",
          "value": "env:ruby-shop"
        }
      ],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [],
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": null,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "datadog/agent:7.17.0",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": null,
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "agent"
    }
  ],
  "placementConstraints": [],
  "memory": "1024",
  "taskRoleArn": null,
  "compatibilities": [
    "EC2"
  ],
  "taskDefinitionArn": "arn:aws:ecs:us-east-1:020926890840:task-definition/first-ecommerce-shop:1",
  "family": "first-ecommerce-shop",
  "requiresAttributes": [],
  "pidMode": null,
  "requiresCompatibilities": [
    "EC2"
  ],
  "networkMode": null,
  "cpu": "128",
  "revision": 1,
  "status": "ACTIVE",
  "inferenceAccelerators": null,
  "proxyConfiguration": null,
  "volumes": []
}
]
DEFINITION
}

resource "aws_ecs_service" "ecommerce" {
  name          = "ecommerce"
  cluster       = "aws_ecs_cluster.ecommerce-microservices.id"
  desired_count = 2

  # Track the latest ACTIVE revision
  task_definition = "aws_ecs_task_definition.ecommerce.family"
}