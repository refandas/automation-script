BASH_SCRIPT := ./clean_images.sh
POWERSHELL_SCRIPT := ./clean_images.ps1

.PHONY: clean_images_bash
clean_images_bash:
	@echo "Starting Bash script to clean up containers and images..."
	@bash $(BASH_SCRIPT)
	@echo "Bash cleanup process completed."

.PHONY: clean_images_powershell
clean_images_powershell:
	@echo "Starting PowerShell script to clean up containers and images..."
	@powershell -File $(POWERSHELL_SCRIPT)
	@echo "PowerShell cleanup process completed."

