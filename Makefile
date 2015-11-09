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
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/wheezy/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/weppy/requirements.txt
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


WRK = wrk -d20s -c200 -t10 --timeout 10s -s scripts/cvs-report.lua
bench: $(VIRTUAL_ENV)
	# @rm -f $(CURDIR)/results.csv
	# # aiohttp
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    # --pid=pid -k aiohttp.worker.GunicornWebWorker \
	    # --workers=2 --bind=127.0.0.1:5000 --chdir=$(CURDIR)/frameworks/aiohttp
	# @sleep 1
	# @TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # bottle
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    # --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    # --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    # --chdir=$(CURDIR)/frameworks/bottle
	# @sleep 1
	# @TESTEE=bottle $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=bottle $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=bottle $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # django
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    # --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    # --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    # --chdir=$(CURDIR)/frameworks/django
	# @sleep 1
	# @TESTEE=django $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=django $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=django $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # falcon
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    # --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    # --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    # --chdir=$(CURDIR)/frameworks/falcon
	# @sleep 1
	# @TESTEE=falcon $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=falcon $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=falcon $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # flask
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    # --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    # --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    # --chdir=$(CURDIR)/frameworks/flask
	# @sleep 1
	# @TESTEE=flask $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=flask $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=flask $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # muffin
	# @cd $(CURDIR)/frameworks/muffin && THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/muffin app run --daemon \
	    # --pid $(CURDIR)/pid --workers 2 --bind 127.0.0.1:5000
	# @sleep 1
	# @TESTEE=muffin $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=muffin $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=muffin $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # pyramid
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    # --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    # --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    # --chdir=$(CURDIR)/frameworks/pyramid
	# @sleep 1
	# @TESTEE=pyramid $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=pyramid $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=pyramid $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # wheezy
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    # --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    # --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    # --chdir=$(CURDIR)/frameworks/wheezy
	# @sleep 1
	# @TESTEE=wheezy $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=wheezy $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=wheezy $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# # tornado
	# @THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app  -D \
	    # --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    # --worker-class=gunicorn.workers.gtornado.TornadoWorker \
	    # --chdir=$(CURDIR)/frameworks/tornado
	# @sleep 1
	# @TESTEE=tornado $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=tornado $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=tornado $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2
	# weppy
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app -D \
	    --pid=pid --workers=2 --bind=127.0.0.1:5000 \
	    --worker-class=meinheld.gmeinheld.MeinheldWorker \
	    --chdir=$(CURDIR)/frameworks/weppy
	@sleep 1
	@TESTEE=weppy $(WRK) http://127.0.0.1:5000/json
	@TESTEE=weppy $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=weppy $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
