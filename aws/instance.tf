resource "aws_ecs_cluster" "ecommerce-microservices" {
    name = "ecommerce-microservices"
}

resource "aws_ecs_task_definition" "ecommerce" {
      family = "ecommerce"

      container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "environment": [{
      "name": "SECRET",
      "value": "KEY"
    }],
    "essential": true,
    "image": "arapulido/ecommerce-spree-discounts:latest",
    "memory": 512,
    "memoryReservation": 256,
    "name": "ecommerce-frontend"
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