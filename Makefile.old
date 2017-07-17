DHOST			?= 127.0.0.1
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
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/sanic/requirements.txt
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

bench_aiohttp:
	@make aiohttp OPTS="-p pid -D -w 2"
	@sleep 2
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/json
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`

bench_flask_threads:
	@make flask_threads OPTS="-p pid -D -w 2" THREADS=200
	@sleep 2
	@TESTEE=flask_threads_$(THREADS) $(WRK) http://127.0.0.1:5000/json
	@TESTEE=flask_threads_$(THREADS) $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=flask_threads_$(THREADS) $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`


WRK = wrk -d20s -c1000 -t10 --timeout 10s -s scripts/cvs-report.lua
bench: $(VIRTUAL_ENV)
	@rm -f $(CURDIR)/results.csv
	# aiohttp
	@make aiohttp OPTS="-p pid -D -w 2"
	@sleep 2
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/json
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=aiohttp $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# sanic
	@make sanic OPTS="-p pid -D -w 2"
	@sleep 2
	# @TESTEE=sanic $(WRK) http://127.0.0.1:5000/json
	# @TESTEE=sanic $(WRK) http://127.0.0.1:5000/remote
	# @TESTEE=sanic $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
	@sleep 3
	# flask
	@make flask OPTS="-p pid -D -w 2"
	@sleep 2
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/json
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/remote
	@TESTEE=flask $(WRK) http://127.0.0.1:5000/complete
	@kill `cat $(CURDIR)/pid`
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

sanic: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
			-k sanic.worker.GunicornWorker --bind=127.0.0.1:5000 \
			--chdir=$(CURDIR)/frameworks/sanic

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

flask_threads: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
			--threads $(THREADS) --bind=127.0.0.1:5000 \
			--chdir=$(CURDIR)/frameworks/flask

flask_meinheld: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
			--bind=127.0.0.1:5000 \
			--chdir=$(CURDIR)/frameworks/flask \
			-k meinheld.gmeinheld.MeinheldWorker --bind=127.0.0.1:5000 \

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
