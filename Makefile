# kubernetes-cue-schema makefile

.ONESHELL:
.SHELLFLAGS += -e

all: gen

gen: ## Generate schemas using the local kubectl version.
	@KVER=$(shell kubectl version --client -ojson | jq -r .clientVersion.gitVersion)
	@echo "Using k8s.io/api@$${KVER/v1/v0}"
	@./scripts/generate-schemas.sh $${KVER/v1/v0}

push: ## Publish schemas as OCI artifacts to GHCR.
	@./scripts/push-schemas.sh

.PHONY: help
help:  ## Display this help menu
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
