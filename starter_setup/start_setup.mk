# Target to setup initial project files
starter-setup:
	@echo "Setting up initial project files..."
	@mkdir -p scripts  # Create scripts directory if not exists
	@cp -R .env .env_development .env_staging .env_production build.yaml.template scripts/
	@cp -R android/ios/ googleservice.json README.md scripts/
	@echo "Setup complete. You can now proceed with your project."

# Target to setup initial project files
copy-env-files: ## Seting up starter files
	@echo "Setting up initial project files..."
	@cp starter_files/.env ../.env
	@cp starter_files/.env_development ../.env_development
	@cp starter_files/.env_staging ../.env_staging
	@cp starter_files/.env_production ../.env_production
	@cp starter_files/build.yaml.template ../build.yaml.template
	@cp -r starter_files/scripts ../scripts
	@echo "Setup complete. You can now proceed with your project."
