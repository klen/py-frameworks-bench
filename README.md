# Async Python Web Frameworks comparison

https://klen.github.io/py-frameworks-bench/
----------
#### Updated: 2021-04-29

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

----------

This is a simple benchmark for python async frameworks. Almost all of the
frameworks are ASGI-compatible (aiohttp is an exception).

The objective of the benchmark is not testing deployment (like uvicorn vs
hypercorn and etc) or database (ORM, drivers) but instead test the frameworks
itself. The benchmark checks request parsing (body, headers, formdata,
queries), routing, responses.

## Table of contents

* [The Methodic](#the-methodic)
* [The Results](#the-results-2021-04-29)
    * [Accept a request and return HTML response with a custom dynamic header](#html)
    * [Parse uploaded file, store it on disk and return a text response](#upload)
    * [Parse path params, query string, JSON body and return a json response](#api)
    * [Composite stats ](#composite)

## The Methodic

The benchmark runs as a [Github Action](https://github.com/features/actions).
According to the [github
documentation](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
the hardware specification for the runs is:

* 2-core vCPU (Intel® Xeon® Platinum 8272CL (Cascade Lake), Intel® Xeon® 8171M 2.1GHz (Skylake))
* 7 GB of RAM memory
* 14 GB of SSD disk space
* OS Ubuntu 20.04

[ASGI](https://asgi.readthedocs.io/en/latest/) apps are running from docker using the gunicorn/uvicorn command:

    gunicorn -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8080 app:app

Applications' source code can be found
[here](https://github.com/klen/py-frameworks-bench/tree/develop/frameworks).

Results received with WRK utility using the params:

    wrk -d15s -t4 -c64 [URL]

The benchmark has a three kind of tests:

1. "Simple" test: accept a request and return HTML response with custom dynamic
   header. The test simulates just a single HTML response.

2. "Upload" test: accept an uploaded file and store it on disk. The test
   simulates multipart formdata processing and work with files.

3. "API" test: Check headers, parse path params, query string, JSON body and return a json
   response. The test simulates an JSON REST API.


## The Results (2021-04-29)

<h3 id="html"> Accept a request and return HTML response with a custom dynamic header</h3>
<details open>
<summary> The test simulates just a single HTML response. </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 17400 | 3.10 | 4.72 | 3.64
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 15159 | 3.52 | 5.43 | 4.18
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 14430 | 3.83 | 5.70 | 4.39
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 14151 | 3.84 | 5.81 | 4.48
| [emmett](https://pypi.org/project/emmett/) `` | 12456 | 4.28 | 6.63 | 5.10
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 9722 | 5.17 | 8.72 | 6.54
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 8051 | 6.62 | 10.29 | 7.95
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 7446 | 8.59 | 8.70 | 8.60
| [quart](https://pypi.org/project/quart/) `0.14.1` | 3343 | 19.83 | 20.58 | 19.13
| [django](https://pypi.org/project/django/) `3.2` | 1644 | 39.53 | 42.87 | 38.92


</details>

<h3 id="upload"> Parse uploaded file, store it on disk and return a text response</h3>
<details open>
<summary> The test simulates multipart formdata processing and work with files.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 5443 | 9.12 | 15.69 | 11.72
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 4062 | 12.18 | 21.27 | 15.72
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 3810 | 13.20 | 22.19 | 16.83
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 3324 | 16.31 | 25.10 | 19.31
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 2258 | 33.49 | 36.73 | 28.29
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 2150 | 29.78 | 30.00 | 29.76
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 2019 | 38.18 | 40.22 | 31.64
| [emmett](https://pypi.org/project/emmett/) `` | 1359 | 43.71 | 53.16 | 47.03
| [quart](https://pypi.org/project/quart/) `0.14.1` | 1265 | 50.83 | 51.81 | 50.54
| [django](https://pypi.org/project/django/) `3.2` | 884 | 71.67 | 80.45 | 72.29


</details>

<h3 id="api"> Parse path params, query string, JSON body and return a json response</h3>
<details open>
<summary> The test simulates a simple JSON REST API endpoint.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 9630 | 5.22 | 8.76 | 6.61
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 9190 | 5.51 | 9.19 | 6.93
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 8718 | 5.74 | 9.74 | 7.30
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 7688 | 6.46 | 11.16 | 8.29
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 6726 | 7.35 | 12.57 | 9.51
| [emmett](https://pypi.org/project/emmett/) `` | 6488 | 7.59 | 12.94 | 9.93
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 5982 | 8.21 | 14.41 | 10.66
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 4501 | 14.19 | 14.34 | 14.22
| [quart](https://pypi.org/project/quart/) `0.14.1` | 2133 | 29.85 | 30.60 | 30.00
| [django](https://pypi.org/project/django/) `3.2` | 1373 | 47.82 | 51.42 | 46.56

</details>

<h3 id="composite"> Composite stats </h3>
<details open>
<summary> Combined benchmarks results</summary>

Sorted by completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 487095 | 5.81 | 9.72 | 7.32
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 419085 | 7.15 | 12.15 | 9.07
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 399975 | 8.55 | 13.37 | 10.24
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 365640 | 14.59 | 17.86 | 13.66
| [emmett](https://pypi.org/project/emmett/) `` | 304545 | 18.53 | 24.24 | 20.69
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 278805 | 9.06 | 15.02 | 11.43
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 265845 | 17.19 | 21.12 | 16.28
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 211455 | 17.52 | 17.68 | 17.53
| [quart](https://pypi.org/project/quart/) `0.14.1` | 101115 | 33.5 | 34.33 | 33.22
| [django](https://pypi.org/project/django/) `3.2` | 58515 | 53.01 | 58.25 | 52.59

</details>

## Conclusion

Nothing here, just some measures for you.

## License

Licensed under a MIT license (See LICENSE file)