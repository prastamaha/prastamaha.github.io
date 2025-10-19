# Hugo Static Site Makefile
# Author: Prasta Maha

.PHONY: help dev build serve clean install update deploy

# Default target
help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Initialize and update git submodules (themes)
	@echo "📦 Installing dependencies..."
	git submodule init
	git submodule update --recursive
	@echo "✅ Dependencies installed successfully!"

update: ## Update git submodules to latest version
	@echo "🔄 Updating submodules..."
	git submodule update --remote --recursive
	@echo "✅ Submodules updated successfully!"

dev: install ## Setup development environment and start Hugo server
	@echo "🚀 Starting development server..."
	hugo server --buildDrafts --buildFuture --disableFastRender --watch

build: install ## Build the static site for production
	@echo "🏗️  Building site for production..."
	hugo --minify --gc
	@echo "✅ Site built successfully in ./public/"

serve: build ## Build and serve the site locally (production mode)
	@echo "🌐 Serving production build locally..."
	hugo server --renderToDisk --disableLiveReload

clean: ## Clean build artifacts and cache
	@echo "🧹 Cleaning build artifacts..."
	rm -rf public/
	rm -rf resources/
	hugo mod clean --all
	@echo "✅ Clean completed!"

deploy: build ## Build and prepare for deployment
	@echo "🚀 Site ready for deployment!"
	@echo "📁 Built files are in ./public/ directory"
	@echo "🌐 You can now deploy the contents of ./public/ to your web server"

# Development shortcuts
start: dev ## Alias for dev command

# Production shortcuts  
prod: build ## Alias for build command