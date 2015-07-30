VIRTUAL_ENV = $(shell echo $${VIRTUAL_ENV:-.env})

.PHONY: provision
PTARGET  ?= vagrant
PINVENT  ?= $(CURDIR)/deploy/inventory.ini
PLAYBOOK ?= $(CURDIR)/deploy/setup.yml
provision: $(CURDIR)/.vagrant/machines/default/virtualbox/id
	@echo "[make] Run Ansible provision"
	@chmod 600 $(CURDIR)/deploy/vagrant
	ansible-playbook $(PLAYBOOK) -i $(PINVENT) -l $(PTARGET) -vv

$(VIRTUAL_ENV): $(CURDIR)/frameworks
	@[ -d $(VIRTUAL_ENV) ] || virtualenv $(VIRTUAL_ENV) --python=python3
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/aiohttp/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/bottle/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/falcon/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/flask/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/muffin/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/pyramid/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/tornado/requirements.txt
	@touch $(CURDIR)/frameworks
	@touch $(VIRTUAL_ENV)

$(VIRTUAL_ENV)/bin/py.test: $(VIRTUAL_ENV) $(CURDIR)/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/requirements.txt
	@touch $(CURDIR)/requirements.txt
	@touch $(VIRTUAL_ENV)/bin/py.test

$(CURDIR)/.vagrant/machines/default/virtualbox/id:
	@vagrant up

.PHONY: aws
aws:
	$(eval PTARGET := 'aws')
	$(eval PINVENT := 'aws.ini')

test: $(VIRTUAL_ENV)/bin/py.test
	$(VIRTUAL_ENV)/bin/py.test -xs tests.py


bench: $(VIRTUAL_ENV)
	# aiohttp
	@$(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    --pid=pid -k aiohttp.worker.GunicornWebWorker \
	    --workers=2 --bind=127.0.0.1:5000 --chdir=$(CURDIR)/frameworks/aiohttp
	@sleep 1
	@wrk -d10s -c100 -t10 http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 1
	# muffin
	@cd $(CURDIR)/frameworks/muffin && $(VIRTUAL_ENV)/bin/muffin app run --daemon \
	    --pid $(CURDIR)/pid --workers 2 --bind 127.0.0.1:5000
	@sleep 1
	@wrk -d10s -c100 -t10 --timeout 10s http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 1             

test2:
	# bottle
	@$(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    --chdir=$(CURDIR)/frameworks/bottle
	@sleep 1
	@wrk -d10s -c100 -t10 http://127.0.0.1:5000/json
	@kill `cat $(CURDIR)/pid`
	@sleep 1
	# django
	@$(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    --chdir=$(CURDIR)/frameworks/django
	@sleep 1
	@wrk -d10s -c100 -t10 http://127.0.0.1:5000/json
	@kill `cat $(CURDIR)/pid`
	@sleep 1
	# falcon
	@$(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    --chdir=$(CURDIR)/frameworks/falcon
	@sleep 1
	@wrk -d10s -c100 -t10 http://127.0.0.1:5000/json
	@kill `cat $(CURDIR)/pid`
	@sleep 1
	# flask
	@$(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    --chdir=$(CURDIR)/frameworks/flask
	@sleep 1
	@wrk -d10s -c100 -t10 --timeout 10s --latency http://127.0.0.1:5000/json
	@kill `cat $(CURDIR)/pid`
	@sleep 1      
	# muffin
	@cd $(CURDIR)/frameworks/muffin && $(VIRTUAL_ENV)/bin/muffin app run --daemon \
	    --pid $(CURDIR)/pid --workers 2 --bind 127.0.0.1:5000
	@sleep 1
	@wrk -d10s -c100 -t10 --timeout 10s --latency http://127.0.0.1:5000/json
	@kill `cat $(CURDIR)/pid`
	@sleep 1             
	# pyramid
	@$(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    --chdir=$(CURDIR)/frameworks/pyramid
	@sleep 1
	@wrk -d10s -c100 -t10 --timeout 10s --latency http://127.0.0.1:5000/json
	@kill `cat $(CURDIR)/pid`
	@sleep 1      
