DHOST			?= 127.0.0.1
VIRTUAL_ENV ?= .env
WRK = wrk -d20s -c400 -t10 --timeout 10s -s scripts/cvs-report.lua
OPTS="-p pid -D -w 1 --log-file=/tmp/benchmark.log"
# type represents the type of call to perform
# two types are support:
# complete: performs a database request and retrieves 1000 rows
# remote: requesting a static file from an nginx server
TYPE=complete
# if applicable, use threads
THREADS=1
# specifies the worker type. This is typically chosen by the
# framework itself
WORKER=sync

$(VIRTUAL_ENV): $(CURDIR)/requirements.txt
	@[ -d $(VIRTUAL_ENV) ] || virtualenv $(VIRTUAL_ENV) --python=python3.6
	@$(VIRTUAL_ENV)/bin/pip install -r $(CURDIR)/requirements.txt
	@touch $(CURDIR)/frameworks
	@touch $(VIRTUAL_ENV)

.PHONY: lab
lab:
	@echo Start docker container
	@docker stop pybenchmark || echo ""
	@docker rm pybenchmark || echo ""
	@docker run -p 80:80 -p 5432:5432 --name pybenchmark -d horneds/pybenchmark && sleep 3
	# give the container time to start up
	@sleep 5
	@make -C $(CURDIR) db

.PHONY: db
db: $(VIRTUAL_ENV)
	@echo Fill DATABASE
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/python db.py

.PHONY: docker
docker:
	docker build -t horneds/pybenchmark $(CURDIR)

RUN ?=
.PHONY: docker-run
docker-run:
	docker run --net=host --name=benchmark -d horneds/pybenchmark $(RUN)

bench:
	NAME="$(TESTEE):$(WORKER):$(THREADS)"
	@echo $(TESTEE) $(THREADS)
	@make $(TESTEE) OPTS=$(OPTS) THREADS=$(THREADS)
	@sleep 10
	$(WRK) http://127.0.0.1:5000/$(TYPE)
	@kill `cat $(CURDIR)/pid` | true
	@sleep 5

aiohttp: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn pyfb.frameworks.aiohttp_app:app $(OPTS) \
			-k aiohttp.worker.GunicornWebWorker --bind=127.0.0.1:5000

sanic: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn pyfb.frameworks.sanic_app:app $(OPTS) \
			-k sanic.worker.GunicornWorker --bind=127.0.0.1:5000


flask: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn pyfb.frameworks.flask_app:app $(OPTS) \
			--threads $(THREADS) --bind=127.0.0.1:5000 \
      -k $(WORKER)

falcon: $(VIRTUAL_ENV)
	@DHOST=$(DHOST) $(VIRTUAL_ENV)/bin/gunicorn pyfb.frameworks.falcon_app:app $(OPTS) \
			--threads $(THREADS) --bind=127.0.0.1:5000 \
      -k $(WORKER)
