Python frameworks' benchmarks
=============================

This is a fork of https://github.com/klen/py-frameworks-bench, refactored a bit to enable different kinds of experiments.

## Setup

The tests themselves are orchestrated using Make. In order to run these demos,
you will require the following tools (left as an excersize for the reader):

* wrk (https://github.com/wg/wrk)
* docker (https://www.docker.com/)
* virtualenv
* python3.6 (the benchmarks should be run with this version of Python)

### On an ununtu 17.04 one or more of the following can be used to install the tools:

    sudo apt-get install python3.6 python3.6-dev python3-virtualenv virtualenv build-essential docker.io wrk

## The experiment

The execution is wrk benchmarking an application, sending 400 concurrent
requests over 10 threads. The type of work depends on the type parameter passed
to make, but is typically some remote call: see the Makefile for more
information.

## Running a Benchmark

The benchmarks themselves are stored in makefiles under the benchmarks
directory.

First, start by making your lab, if you haven't already. This starts up the
docker container to execute remote calls against.

    make lab

For example, running async-vs-threads would be:

    make -f benchmarks/async-vs-threaded.makefile main

The benchmark files themselves are very barebones, just running the main benchmark file with different configuration.

## Reading results

Results are written to results.csv, regardless of the benchmark.
You will have to clear this file in between benchmark runs.

The columns are declared in scripts/cvs-report.lua

## Contributors

* Amber Brown (https://github.com/hawkowl)
* Giovanni Barillari (https://github.com/gi0baro)
* Kirill Klenov (https://github.com/klen)
* Yusuke Tsutsumi (https://github.com/toumorokoshi)
