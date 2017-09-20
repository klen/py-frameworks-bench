Python frameworks' benchmarks
=============================

This is a fork of https://github.com/klen/py-frameworks-bench, refactored a bit to enable different kinds of experiments.

## Setup

The tests themselves are orchestrated using Make. In order to run these demos, you will require the following tools (left as an excersize for the reader):

* wrk (https://github.com/wg/wrk)
* docker (https://www.docker.com/)

## Running a Benchmark

The benchmarks themselves are stored in makefiles under the benchmarks directory.

For example, running async-vs-threads would be:

    make -f benchmarks/async-vs-threaded.makefile main

The benchmark files themselves are very barebones, just running the main benchmark file with different configuration.

## Reading results

Results are written to results.csv, regardless of the benchmark.
You will have to clear this file in between benchmark runs.

## Contributors

* Amber Brown (https://github.com/hawkowl)
* Giovanni Barillari (https://github.com/gi0baro)
* Kirill Klenov (https://github.com/klen)
* Yusuke Tsutsumi (https://github.com/toumorokoshi)
