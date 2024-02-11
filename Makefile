# Variables
DOCKER_COMPOSE = docker-compose
DOCKER_BUILD = docker build
DOCKER_RUN = docker run

# Targets
.PHONY: help
help: ## Display this help message
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build Docker image
	$(DOCKER_BUILD) -t lightning-node .

.PHONY: run
run: ## Run Lightning Network node container
	$(DOCKER_RUN) -d -p 9735:9735 -p 10009:10009 --name lightning lightning-node

.PHONY: up
up: ## Run Docker Compose (if using)
	$(DOCKER_COMPOSE) up -d

.PHONY: down
down: ## Stop and remove containers
	$(DOCKER_COMPOSE) down

.PHONY: clean
clean: down ## Remove Docker images and volumes
	$(DOCKER_BUILD) --no-cache -t lightning-node .
	$(DOCKER_RUN) -d -p 9735:9735 -p 10009:10009 --name lightning lightning-node

.PHONY: shell
shell: ## Access shell of the lightning container
	$(DOCKER_RUN) -it lightning bash
