.PHONY: provision
PTARGET  ?= vagrant
PINVENT  ?= $(CURDIR)/deploy/inventory.ini
PLAYBOOK ?= $(CURDIR)/deploy/setup.yml
provision:
	@echo "[make] Run Ansible provision"
	@chmod 600 $(CURDIR)/deploy/vagrant
	ansible-playbook $(PLAYBOOK) -i $(PINVENT) -l $(PTARGET) -vv

.PHONY: test
PTARGET ?= vagrant
PINVENT ?= $(CURDIR)/deploy/inventory.ini
test:
	$(eval PLAYBOOK := '$(CURDIR)/deploy/test.yml')
