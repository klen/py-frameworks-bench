DHOST	    ?= 192.168.99.100
VIRTUAL_ENV ?= .env

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

.PHONY: lab
lab:
	@echo Start docker container
	@docker run -p 80:80 -p 5432:5432 --name pybenchmark -d horneds/pybenchmark && sleep 3
	@make -C $(CURDIR) db

.PHONY: db
db: $(VIRTUAL_ENV)/bin/py.test
	@echo Fill DATABASE
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/python db.py

.PHONY: docker
docker: 
	docker build -t horneds/pybenchmark $(CURDIR)

RUN ?= 
.PHONY: docker-run
docker-run: 
	docker run --net=host --name=benchmark -d horneds/pybenchmark $(RUN)

test: $(VIRTUAL_ENV)/bin/py.test
	$(VIRTUAL_ENV)/bin/py.test -xs tests.py


WRK = wrk -d20s -c200 -t10 --timeout 10s -s scripts/cvs-report.lua
bench: $(VIRTUAL_ENV)
	@rm -f $(CURDIR)/results.csv
	# aiohttp
	@make aiohttp OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=aiohttp
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# bottle
	@make bottle OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=bottle
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# django
	@make django OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=django
	@kill `cat $(CURDIR)/pid`
	@sleep 4
	# falcon
	@make falcon OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=falcon
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# flask
	@make flask OPTS="-p pid -D -w 2"
	@sleep 2
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/json
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# muffin
	@make muffin OPTS="--daemon --pid $(CURDIR)/pid --workers 2"
	@sleep 2
	@make wrk TESTEE=muffin
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# pyramid
	@make pyramid OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=pyramid
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# wheezy
	@make wheezy OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=wheezy
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# tornado
	@make tornado OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=tornado
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# weppy
	@make weppy OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=weppy
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# wsgi
	@make wsgi OPTS="-p pid -D -w 2"
	@sleep 2
	@make wrk TESTEE=wsgi
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# twisted
	# @make twisted OPTS="-pid &"
	# @sleep 1
	# @TESTEE=twisted $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=twisted $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=twisted $(WRK) http://127.0.0.1:5000/complete
	# @kill `cat $(CURDIR)/pid`
	# @sleep 2

TESTEE = ""
wrk:
	TESTEE=$(TESTEE) $(WRK) http://127.0.0.1:5000/json
	TESTEE=$(TESTEE) $(WRK) http://127.0.0.1:5000/remote
	TESTEE=$(TESTEE) $(WRK) http://127.0.0.1:5000/complete

OPTS = 
aiohttp: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k aiohttp.worker.GunicornWebWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/aiohttp

bottle: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/bottle

django: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/django

falcon: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/falcon

flask: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/flask

muffin: $(VIRTUAL_ENV)
	@cd $(CURDIR)/frameworks/muffin && \
	    DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/muffin app run $(OPTS) --bind 127.0.0.1:5000

pyramid:
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/pyramid

tornado:
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    --worker-class=gunicorn.workers.gtornado.TornadoWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/tornado

twisted:
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/python $(CURDIR)/frameworks/twisted/app.py

wheezy:
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/wheezy

weppy:
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/weppy

wsgi:
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
	    -k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \
	    --chdir=$(CURDIR)/frameworks/wsgi
