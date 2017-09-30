# this makefile illustrates that, for workloads that depend on
# remote network calls, async has far better performance for
# high connection counts. This is the case regardless of the
# number of threads.

main:
	rm /tmp/benchmark.log || true
	@make bench NAME=aiohttp TESTEE=aiohttp
	@make bench NAME=flask TESTEE=flask WORKER=gevent NAME=flask:gevent
	@make bench NAME=flask TESTEE=flask WORKER=meinheld.gmeinheld.MeinheldWorker NAME=flask:meinheld
	@make bench NAME=flask TESTEE=flask THREADS=10 WORKER=sync NAME=flask:10
	@make bench NAME=flask TESTEE=flask THREADS=20 WORKER=sync NAME=flask:20
	@make bench NAME=flask TESTEE=flask THREADS=50 WORKER=sync NAME=flask:50
	@make bench NAME=flask TESTEE=flask THREADS=100 WORKER=sync NAME=flask:100
	@make bench NAME=flask TESTEE=flask THREADS=200 WORKER=sync NAME=flask:200
	@make bench NAME=flask TESTEE=flask THREADS=400 WORKER=sync NAME=flask:400
	# after this point, there's not much of a point in having
	# more threads, as the wrk bench connects 400 at a time.
	@make bench NAME=flask TESTEE=flask THREADS=800 WORKER=sync NAME=flask:800
	@make bench NAME=flask TESTEE=flask THREADS=1000 WORKER=sync NAME=flask:1000
