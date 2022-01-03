ROOT_DIR	  			:= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
COMMIT_HASH				:= $(shell git rev-parse --short HEAD)
DOCKER_CONTAINERS 		:= ads-service ads-service-fixed ads-service-errors \
discounts-service discounts-service-fixed attackbox nginx
STOREFRONT_CONTAINERS 	:= \
store-frontend-broken-no-instrumentation \
store-frontend-broken-instrumented \
store-frontend-instrumented-fixed
RUN_ATTACKS=1
VERSION=2.1.0

# Note that this Makefile is a work in progress and may duplicate some code in github actions

all:
	@echo 'Available make targets:'
	@grep '^[^#[:space:]^\.PHONY.*].*:' Makefile

.PHONY: build-storefront
build-storefront:
	for container in $(STOREFRONT_CONTAINERS); do \
		echo "Building storefront-container $$container against local source." \
		&& cd store-frontend/ && \
		docker build . -f storefront-versions/$$container/Dockerfile -t ddtraining/$$container:latest && \
		cd $(ROOT_DIR); \
	done


.PHONY: build
build: build-storefront
	for container in $(DOCKER_CONTAINERS); do \
		echo "Building $$container against local source." \
		&& cd $$container && \
		docker build . -t ddtraining/$$container:latest && \
		cd $(ROOT_DIR); \
	done
	@echo 'All containers have been built locally including the storefront.'

tag-storefront:
	@echo 'Tagging local storefront containers with version: $(VERSION)'
	for container in $(STOREFRONT_CONTAINERS); do \
		echo "Tagging $$container with $(VERSION)." && \
		docker tag ddtraining/$$container:latest ddtraining/$$container:$(VERSION) ;\
	done

.PHONY: tag-local-containers
tag-local-containers: tag-storefront
	@echo 'Tagging local containers with version: $(VERSION)'
	for container in $(DOCKER_CONTAINERS); do \
		echo "Tagging $$container with $(VERSION)." && \
		docker tag ddtraining/$$container:latest ddtraining/$$container:$(VERSION) ;\
	done
	@echo 'Tagging complete all storefront and other containers with: $(VERSION)'


.PHONY: clean
clean:
	docker system prune -a --volumes


.PHONY: recreate-frontend-code
recreate-frontend-code:
	cd store-frontend/src/ && \
	cp -R store-frontend-initial-state store-frontend-broken-instrumented && \
	cd store-frontend-broken-instrumented && \
	patch -t -p1 < ../broken-instrumented.patch && \
	cd .. && \
	cp -R store-frontend-initial-state store-frontend-instrumented-fixed && \
	cd store-frontend-instrumented-fixed && \
	patch -t -p1 < ../instrumented-fixed.patch


create-frontend-fixed-diff:
	cd store-frontend/src/ && \
	rm instrumented-fixed.patch && \
	diff -urN store-frontend-initial-state store-frontend-instrumented-fixed | tee instrumented-fixed.patch


create-broken-instrumented-diff:
	cd store-frontend/src/ && \
	rm broken-instrumented.patch && \
	diff -urN store-frontend-initial-state store-frontend-broken-instrumented | tee broken-instrumented.patch


.PHONY: create-frontend-diffs
create-frontend-diffs: create-frontend-fixed-diff create-broken-instrumented-diff
	@echo 'Patches for the frontend have been created.  Do remember to commit them to git.'


.PHONY: local-attack-scenario-start
.SILENT:
local-attack-scenario-start:
	POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres \
	DD_API_KEY=${DD_API_KEY} \
	ATTACK_GOBUSTER=$(RUN_ATTACKS) \
	ATTACK_GOBUSTER_INTERVAL=500 \
	ATTACK_HYDRA=$(RUN_ATTACKS) \
	ATTACK_HYDRA_INTERVAL=900 \
	ATTACK_SSH=$(RUN_ATTACKS) \
	ATTACK_SSH_INTERVAL=90 \
	ATTACK_URL=http://nginx \
	docker-compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml up --force-recreate -d
	@echo 'The local attack scenario has been started.  To live tail the logs run the target for local-attack-scenario-logs.'


.PHONY: local-attack-scenario
local-attack-scenario-logs:
	docker-compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml logs -f


.PHONY: local-attack-scenario-stop
local-attack-scenario-stop:
	docker-compose -f deploy/docker-compose/docker-compose-fixed-instrumented-attack.yml stop
