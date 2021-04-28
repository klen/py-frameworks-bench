DATE = $(shell date +'%Y-%m-%d')

env: frameworks/*/requirements.txt
	find frameworks | grep requirements | xargs -n1 env/bin/pip install -r
	touch env

.PHONY:
benchmark-base:
	docker build $(CURDIR) -t horneds/py-async-benchmark
	docker push horneds/py-async-benchmark

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
render:
	python render/render.py


.PHONY: tests t
tests t: env
	env/bin/pip install pytest-aio
	env/bin/pytest frameworks

.PHONY: benchmark
benchmark: clean
	@make aiohttp
	@make blacksheep
	@make django
	@make falcon
	@make fastapi
	@make muffin
	@make quart
	@make sanic
	@make starlette
	mkdir -p $(CURDIR)/results/$(DATE)
	cp $(CURDIR)/results/html.csv $(CURDIR)/results/$(DATE)/html.csv
	cp $(CURDIR)/results/upload.csv $(CURDIR)/results/$(DATE)/upload.csv
	cp $(CURDIR)/results/api.csv $(CURDIR)/results/$(DATE)/api.csv

# Run benchmark
%:
	@echo "\nBenchmarking $@\n--------------------"
	@docker build -f $(CURDIR)/frameworks/Dockerfile -t benchmarks:$@ $(CURDIR)/frameworks/$@
	@docker run --rm -d --publish 8080:8080 --name benchmark benchmarks:$@
	@echo "\nRun HTML [$@]\n"
	@docker run --rm --network host \
	       -e FRAMEWORK=$@ -e FILENAME=/results/html.csv \
	       -v $(CURDIR)/results:/results \
	       -v $(CURDIR)/wrk:/scripts \
	       williamyeh/wrk http://host.docker.internal:8080/html -d15s -t4 -c64 -s /scripts/html.lua
	@echo "\nRun UPLOAD [$@]\n"
	@docker run --rm --network host \
	       -e FRAMEWORK=$@ -e FILENAME=/results/upload.csv \
	       -v $(CURDIR)/results:/results \
	       -v $(CURDIR)/wrk:/scripts \
	       williamyeh/wrk http://host.docker.internal:8080/upload -d15s -t4 -c64 -s /scripts/upload.lua
	@echo "\nRun API [$@]\n"
	@docker run --rm --network host \
	       -e FRAMEWORK=$@ -e FILENAME=/results/api.csv \
	       -v $(CURDIR)/results:/results \
	       -v $(CURDIR)/wrk:/scripts \
	       williamyeh/wrk http://host.docker.internal:8080/api/users/1/records/1?query=test -d15s -t4 -c64 -s /scripts/api.lua
	@echo "\nFinish [$@]\n"
	@docker stop benchmark
	sleep 1
