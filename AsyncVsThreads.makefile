DHOST			?= 127.0.0.1
VIRTUAL_ENV ?= .env
WRK = wrk -d20s -c1000 -t10 --timeout 10s -s scripts/cvs-report.lua
OPTS="-p pid -D -w 2 --log-file=/tmp/benchmark.log"
TYPE=complete

main:
	rm /tmp/benchmark.log
	@make -f AsyncVsThreads.makefile bench NAME=aiohttp TESTEE=aiohttp
	@make -f AsyncVsThreads.makefile bench NAME=flask_meinheld TESTEE=flask_meinheld
	@make -f AsyncVsThreads.makefile bench NAME=flask_10 TESTEE=flask_threads THREADS=10
	@make -f AsyncVsThreads.makefile bench NAME=flask_50 TESTEE=flask_threads THREADS=50
	@make -f AsyncVsThreads.makefile bench NAME=flask_100 TESTEE=flask_threads THREADS=100
	@make -f AsyncVsThreads.makefile bench NAME=flask_200 TESTEE=flask_threads THREADS=200
	@make -f AsyncVsThreads.makefile bench NAME=flask_400 TESTEE=flask_threads THREADS=400
	@make -f AsyncVsThreads.makefile bench NAME=flask_500 TESTEE=flask_threads THREADS=500
	@make -f AsyncVsThreads.makefile bench NAME=flask_1000 TESTEE=flask_threads THREADS=1000
	@make -f AsyncVsThreads.makefile bench NAME=flask_2000 TESTEE=flask_threads THREADS=2000
	@make -f AsyncVsThreads.makefile bench NAME=flask_5000 TESTEE=flask_threads THREADS=5000
	@make -f AsyncVsThreads.makefile bench NAME=flask_10000 TESTEE=flask_threads THREADS=10000

bench:
	@make -f AsyncVsThreads.makefile $(TESTEE) OPTS=$(OPTS) THREADS=$(THREADS)
	@sleep 10
	$(WRK) http://127.0.0.1:5000/$(TYPE)
	@kill `cat $(CURDIR)/pid` | true
	@sleep 5

aiohttp: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
			-k aiohttp.worker.GunicornWebWorker --bind=127.0.0.1:5000 \
			--chdir=$(CURDIR)/frameworks/aiohttp

flask_threads: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
			--threads $(THREADS) --bind=127.0.0.1:5000 \
			--chdir=$(CURDIR)/frameworks/flask

flask_meinheld: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
			--bind=127.0.0.1:5000 \
			--chdir=$(CURDIR)/frameworks/flask \
			-k meinheld.gmeinheld.MeinheldWorker

flask_gevent: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn app:app $(OPTS) \
			--bind=127.0.0.1:5000 \
			--chdir=$(CURDIR)/frameworks/flask \

.PHONY: $(VIRTUAL_ENV)
$(VIRTUAL_ENV): $(CURDIR)/frameworks/aiohttp/requirements.txt $(CURDIR)/frameworks/bottle/requirements.txt $(CURDIR)/frameworks/django/requirements.txt $(CURDIR)/frameworks/falcon/requirements.txt $(CURDIR)/frameworks/flask/requirements.txt $(CURDIR)/frameworks/muffin/requirements.txt $(CURDIR)/frameworks/pyramid/requirements.txt $(CURDIR)/frameworks/tornado/requirements.txt $(CURDIR)/frameworks/wheezy/requirements.txt $(CURDIR)/frameworks/weppy/requirements.txt
	@[ -d $(VIRTUAL_ENV) ] || virtualenv $(VIRTUAL_ENV) --python=python3
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/aiohttp/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/bottle/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/django/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/falcon/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/flask/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/pyramid/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/tornado/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/twisted/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/wheezy/requirements.txt
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/frameworks/weppy/requirements.txt
	@touch $(CURDIR)/frameworks
	@touch $(VIRTUAL_ENV)
