# Target to setup initial project files
starter-setup: ## Seting up starter files
	@echo "Setting up initial project files..."
	@cp starter_setup/starter_files/.env .env
	@cp starter_setup/starter_files/.env_development .env_development
	@cp starter_setup/starter_files/.env_staging .env_staging
	@cp starter_setup/starter_files/.env_production .env_production
	@cp starter_setup/starter_files/build.yaml.template build.yaml.template
	@cp -rf starter_setup/starter_files/scripts/build.mk scripts/build.mk
	@cp -rf starter_setup/starter_files/scripts/setup.mk scripts/setup.mk
	@echo "Setup complete. You can now proceed with your project."