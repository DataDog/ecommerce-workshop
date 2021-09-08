# Attack Box

This is an attack container for simulating an adversary attempting to hack our online store.

The attack script has 3 stages:
1) Malicious SSH configuration
2) Gobuster
3) Hydra

Stage 1 will begin as soon as the attack-box container starts and it will add a malicious SSH key to the `discounts` container.

Stages 2 and 3 are optional and are invoked via the docker compose command. More info is below.

## Deployment

The attack-box is configurable via environment variables in the `docker compose` command. The available variables are as follows:
- **ATTACK_GOBUSTER**: Set to `1` to run the Gobuster tool for crawling directories on the frontend container
- **ATTACK_HYDRA**: Set to `1` to run the Hydra tool for brute force login against the frontend container
- **ATTACK_GOBUSTER_INTERVAL**: Number of seconds between GOBUSTER invocations (if ommited, GOBUSTER will run once)
- **ATTACK_HYDRA_INTERVAL**: Number of seconds between HYDRA invocations (if ommited, HYDRA will run once)

Here's an example of what a `docker compose` command would look like if we wanted to run Gobuster every 500 seconds and Hydra every 900 seconds:

```POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=[API KEY] ATTACK_GOBUSTER=1 ATTACK_GOBUSTER_INTERVAL=500 ATTACK_HYDRA=1 ATTACK_HYDRA_INTERVAL=900 docker compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml up```

Note that we used `docker-compose-fixed-instrumented-attack.yml` as the target for docker compose. This is the only compose file where attack-box is used.

## Local dev
Run the following commands locally (assuming you have `docker compose` already installed)
1. Build all containers: `docker compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml build`
2. Start the app: `POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=[API KEY] ATTACK_GOBUSTER=1 ATTACK_GOBUSTER_INTERVAL=500 ATTACK_HYDRA=1 ATTACK_HYDRA_INTERVAL=900 docker compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml up`

You should see a large influx of logs on the frontend container once Gobuster and Hydra start running. These should also be available in Datadog in the account tied to the provided API Key