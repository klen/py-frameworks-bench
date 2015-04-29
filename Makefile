.PHONY: provision
PTARGET ?= vagrant
PINVENT ?= $(CURDIR)/deploy/inventory.ini
provision:
	@echo "[make] Run Ansible provision"
	@chmod 600 $(CURDIR)/deploy/vagrant
	ansible-playbook deploy/playbook.yml -i $(PINVENT) -l $(PTARGET) -vv
