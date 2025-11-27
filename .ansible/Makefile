.PHONY: help install check requirements init base terminal desktop all

help:
	@echo "Arch Linux Ansible Setup - Available targets:"
	@echo ""
	@echo "  make requirements  - Install required Ansible collections"
	@echo "  make check        - Run playbook in check mode (dry-run)"
	@echo "  make install      - Run full installation"
	@echo "  make init         - System initialization (locale, hostname, bootloader)"
	@echo "  make base         - Install base system only"
	@echo "  make terminal     - Install terminal tools only"
	@echo "  make desktop      - Install desktop environment only"
	@echo "  make programming  - Install programming tools only"
	@echo "  make all          - Same as 'make install'"
	@echo ""
	@echo "Add VERBOSE=1 for verbose output"
	@echo "Example: make install VERBOSE=1"

requirements:
	ansible-galaxy collection install -r requirements.yml

check:
	ansible-playbook site.yml --check --ask-become-pass $(if $(VERBOSE),-vv)

install all:
	ansible-playbook site.yml --ask-become-pass $(if $(VERBOSE),-vv)

init:
	ansible-playbook site.yml --tags "init" --ask-become-pass $(if $(VERBOSE),-vv)

base:
	ansible-playbook site.yml --tags "base" --ask-become-pass $(if $(VERBOSE),-vv)

terminal:
	ansible-playbook site.yml --tags "terminal" --ask-become-pass $(if $(VERBOSE),-vv)

desktop:
	ansible-playbook site.yml --tags "desktop,xorg,themes,fonts" --ask-become-pass $(if $(VERBOSE),-vv)

programming:
	ansible-playbook site.yml --tags "programming,python" --ask-become-pass $(if $(VERBOSE),-vv)

custom-builds:
	ansible-playbook site.yml --tags "custom-builds" --ask-become-pass $(if $(VERBOSE),-vv)
