# kubernetes-cue-schema makefile

.ONESHELL:
.SHELLFLAGS += -e

# Repository root based on Git metadata
REPOSITORY_ROOT := $(shell git rev-parse --show-toplevel)
BIN_DIR := $(REPOSITORY_ROOT)/bin
DEV_VERSION?=0.0.0-$(shell git rev-parse --short HEAD).$(shell date +%s)

# API gen tool
CONTROLLER_GEN_VERSION ?= v0.13.0

all: gen

gen: ## Generate schemas using the local kubectl version.
	@KVER=$(shell kubectl version --client -ojson | jq -r .clientVersion.gitVersion)
	@echo "Using k8s.io/api@$${KVER/v1/v0}"
	@./scripts/schema-generator.sh $${KVER/v1/v0}

tidy: ## Tidy Go modules.
	rm -f go.sum; go mod tidy -compat=1.21

fmt: ## Format Go code.
	go fmt ./...

vet: ## Vet Go code.
	go vet ./...

CONTROLLER_GEN=$(BIN_DIR)/controller-gen
.PHONY: controller-gen
controller-gen:
	$(call go-install-tool,$(CONTROLLER_GEN),sigs.k8s.io/controller-tools/cmd/controller-gen@$(CONTROLLER_GEN_VERSION))

# go-install-tool will 'go install' any package $2 and install it to $1.
PROJECT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
define go-install-tool
@[ -f $(1) ] || { \
set -e ;\
TMP_DIR=$$(mktemp -d) ;\
cd $$TMP_DIR ;\
go mod init tmp ;\
echo "Downloading $(2)" ;\
GOBIN=$(PROJECT_DIR)/bin go install $(2) ;\
rm -rf $$TMP_DIR ;\
}
endef

.PHONY: help
help:  ## Display this help menu
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
