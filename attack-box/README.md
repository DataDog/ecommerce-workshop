# Attack Box

This is an attack container for simulating an adversary attempting to hack our online store.

The attack script has 3 stages:
1) Malicious SSH configuration
2) Gobuster
3) Hydra

## Deployment

The attack box is configurable via environment variables in the `docker compose` command:
- **ATTACK_SSH**: Set to `1` to run the SSH attack script against the discounts container
- **ATTACK_GOBUSTER**: Set to `1` to run the Gobuster tool for crawling directories on the frontend container
- **ATTACK_HYDRA**: Set to `1` to run the Hydra tool for brute force login
- **ATTACK_SSH_INTERVAL**: Number of seconds between SSH attack invocations (if ommited, SSH attack will run once)
- **ATTACK_GOBUSTER_INTERVAL**: Number of seconds between GOBUSTER invocations (if ommited, GOBUSTER will run once)
- **ATTACK_HYDRA_INTERVAL**: Number of seconds between HYDRA invocations (if ommited, HYDRA will run once)

Here's an example of what a `docker compose` command would look like if we wanted to run Gobuster every 500 seconds and Hydra every 900 seconds:

```POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=[API KEY] ATTACK_GOBUSTER=1 ATTACK_GOBUSTER_INTERVAL=500 ATTACK_HYDRA=1 ATTACK_HYDRA_INTERVAL=900 docker compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml up```

## Local dev
Run the following commands locally (assuming you have `docker compose` already installed)
1. Clean local docker environment of all volumes / containers / images: `docker system prune -a --volumes` (Optional)
2. [Recreate the frontend code](https://github.com/DataDog/ecommerce-workshop/blob/main/development.md#recreating-the-code)
3. Start the app: `POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres DD_API_KEY=[API KEY] ATTACK_GOBUSTER=1 ATTACK_GOBUSTER_INTERVAL=500 ATTACK_HYDRA=1 ATTACK_HYDRA_INTERVAL=900 docker compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml up`