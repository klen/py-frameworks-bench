# this makefile illustrates that core architectual choices and
# application code have the largest impact on the performance of an
# application, and a framework choice has a minor impact

main:
	rm /tmp/benchmark.log || true
	@make bench NAME=aiohttp TESTEE=aiohttp
	@make bench NAME=sanic TESTEE=sanic
