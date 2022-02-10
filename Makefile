DATE = $(shell date +'%Y-%m-%d')
VIRTUAL_ENV ?= env

ifeq ($(shell uname -s), Linux)
	HOSTNAME := localhost
else
	HOSTNAME := host.docker.internal
endif

$(VIRTUAL_ENV): frameworks/*/requirements.txt
	@[ -d $(VIRTUAL_ENV) ] || python3 -m venv $(VIRTUAL_ENV)
	find frameworks | grep requirements | xargs -n1 $(VIRTUAL_ENV)/bin/pip install -r
	touch $(VIRTUAL_ENV)

.PHONY:
benchmark-base:
	docker build $(CURDIR) -t horneds/py-async-benchmark
	docker push horneds/py-async-benchmark

.PHONY:
release:
	git checkout develop
	git pull
	git checkout master
	git pull
	git merge develop
	git checkout develop
	git push origin develop master

APP ?= aiohttp

.PHONY: run
run:
	docker build -f $(CURDIR)/frameworks/Dockerfile -t benchmarks:$(APP) $(CURDIR)/frameworks/$(APP)
	docker run --rm -it --publish 8080:8080 --name benchmark benchmarks:$(APP)

.PHONY: clean
clean:
	find $(CURDIR) -name "*.py[co]" -delete
	find $(CURDIR)/$(MODULE) -name "__pycache__" | xargs rm -rf
	rm -rf $(CURDIR)/results/*.csv

.PHONY: render
render: $(VIRTUAL_ENV)
	$(VIRTUAL_ENV)/bin/python3 render/render.py
	mkdir -p $(CURDIR)/results/$(DATE)
	cp $(CURDIR)/results/*.csv $(CURDIR)/results/$(DATE)/.


.PHONY: tests t
tests t: $(VIRTUAL_ENV)
	$(VIRTUAL_ENV)/bin/pip install pytest pytest-aio
	$(VIRTUAL_ENV)/bin/pytest frameworks

.PHONY: benchmark
benchmark: clean
	@make aiohttp
	@make blacksheep
	@make django
	@make emmett
	@make falcon
	@make fastapi
	@make muffin
	@make quart
	@make sanic
	@make starlette
	@make tornado
	@make render

# Run benchmark
%:
	@echo "\nBenchmarking $@\n--------------------"
	@docker build -f $(CURDIR)/frameworks/Dockerfile -t benchmarks:$@ $(CURDIR)/frameworks/$@
	@docker run --rm -d --publish 8080:8080 --name $@-benchmark benchmarks:$@
	@echo "\nRun HTML [$@]\n"
	@docker run --rm --network host \
	       -e FRAMEWORK=$@ -e FILENAME=/results/html.csv \
	       -v $(CURDIR)/results:/results \
	       -v $(CURDIR)/wrk:/scripts \
	       williamyeh/wrk http://${HOSTNAME}:8080/html -d15s -t4 -c64 -s /scripts/html.lua
	@echo "\nRun UPLOAD [$@]\n"
	@docker run --rm --network host \
	       -e FRAMEWORK=$@ -e FILENAME=/results/upload.csv \
	       -v $(CURDIR)/results:/results \
	       -v $(CURDIR)/wrk:/scripts \
	       williamyeh/wrk http://${HOSTNAME}:8080/upload -d15s -t4 -c64 -s /scripts/upload.lua
	@echo "\nRun API [$@]\n"
	@docker run --rm --network host \
	       -e FRAMEWORK=$@ -e FILENAME=/results/api.csv \
	       -v $(CURDIR)/results:/results \
	       -v $(CURDIR)/wrk:/scripts \
	       williamyeh/wrk http://${HOSTNAME}:8080/api/users/1/records/1?query=test -d15s -t4 -c64 -s /scripts/api.lua
	@echo "\nFinish [$@]\n"
	@docker kill $@-benchmark
	sleep 1
