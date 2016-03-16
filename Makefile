VIRTUAL_ENV = $(shell echo $${VIRTUAL_ENV:-.env})

.PHONY: provision
PTARGET  ?= vagrant
PINVENT  ?= $(CURDIR)/deploy/inventory.ini
PLAYBOOK ?= $(CURDIR)/deploy/setup.yml
provision: $(CURDIR)/.vagrant/machines/default/virtualbox/id
	@echo "[make] Run Ansible provision"
	@chmod 600 $(CURDIR)/deploy/vagrant
	ansible-playbook $(PLAYBOOK) -i $(PINVENT) -l $(PTARGET) -vv

$(VIRTUAL_ENV): $(CURDIR)/frameworks/aiohttp/requirements.txt $(CURDIR)/frameworks/bottle/requirements.txt $(CURDIR)/frameworks/django/requirements.txt $(CURDIR)/frameworks/falcon/requirements.txt $(CURDIR)/frameworks/flask/requirements.txt $(CURDIR)/frameworks/muffin/requirements.txt $(CURDIR)/frameworks/pyramid/requirements.txt $(CURDIR)/frameworks/tornado/requirements.txt $(CURDIR)/frameworks/wheezy/requirements.txt $(CURDIR)/frameworks/weppy/requirements.txt
	@[ -d $(VIRTUAL_ENV) ] || virtualenv $(VIRTUAL_ENV) --python=python3
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/aiohttp/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/bottle/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/django/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/falcon/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/flask/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/muffin/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/pyramid/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/tornado/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/twisted/requirements.txt
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
	@rm -f $(CURDIR)/results.csv
	# aiohttp
	@make aiohttp OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/json
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# bottle
	@sleep 1
	@make bottle OPTS="-p pid -D -w 2"
	@TESTEE=bottle $(WRK) http://127.0.0.1:5000/json
	@TESTEE=bottle $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=bottle $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# django
	@make django OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=django $(WRK) http://127.0.0.1:5000/json
	@TESTEE=django $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=django $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# falcon
	@make falcon OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=falcon $(WRK) http://127.0.0.1:5000/json
	@TESTEE=falcon $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=falcon $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# flask
	@make flask OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/json
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# muffin
	@make muffin OPTS="--daemon --pid $(CURDIR)/pid --workers 2"
	@sleep 1
	@TESTEE=muffin $(WRK) http://127.0.0.1:5000/json
	@TESTEE=muffin $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=muffin $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# pyramid
	@make pyramid OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=pyramid $(WRK) http://127.0.0.1:5000/json
	@TESTEE=pyramid $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=pyramid $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# wheezy
	@make wheezy OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=wheezy $(WRK) http://127.0.0.1:5000/json
	@TESTEE=wheezy $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=wheezy $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# tornado
	@make tornado OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=tornado $(WRK) http://127.0.0.1:5000/json
	@TESTEE=tornado $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=tornado $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
	# twisted
	@make twisted OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=twisted $(WRK) http://127.0.0.1:5000/json
	@TESTEE=twisted $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=twisted $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2
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
	# wsgi
	@make wsgi OPTS="-p pid -D -w 2"
	@sleep 1
	@TESTEE=wsgi $(WRK) http://127.0.0.1:5000/json
	@TESTEE=wsgi $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=wsgi $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 2

OPTS = 
aiohttp: $(VIRTUAL_ENV)
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k aiohttp.worker.GunicornWebWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/aiohttp

bottle: $(VIRTUAL_ENV)
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/bottle

django: $(VIRTUAL_ENV)
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/django

falcon: $(VIRTUAL_ENV)
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/falcon

flask: $(VIRTUAL_ENV)
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/flask

muffin: $(VIRTUAL_ENV)
	@cd $(CURDIR)/frameworks/muffin && \
	    THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/muffin app run $(OPTS) --bind 127.0.0.1:5000

pyramid:
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/pyramid

tornado:
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    --worker-class=gunicorn.workers.gtornado.TornadoWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/tornado

twisted:
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/python $(CURDIR)/frameworks/twisted/app.py &

wheezy:
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/wheezy

weppy:
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/weppy

wsgi:
	@THOST=33.33.33.8 $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/wsgi
