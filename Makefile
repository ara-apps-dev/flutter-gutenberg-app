# Include the starter project setup from the starter_setup directory
include starter_setup/start_setup.mk
# Include the setup script from the script directory
include scripts/setup.mk
# Include the build script from the scripts directory
include scripts/build.mk

# Declare the setupenv target as a phony target
.PHONY: help starter-setup setupenv generate-dev generate-stg generate-prod test run clean

# Define aliases for running the setupenv target
setup: setupenv
envsetup: setupenv

# Define the help target
help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "}; /^[a-zA-Z_-]+:.*?## / { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)