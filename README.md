# Async Python Web Frameworks comparison

https://klen.github.io/py-frameworks-bench/
----------
#### Updated: 2021-04-28

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
* [The Results](#the-results-2021-04-28)
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


## The Results (2021-04-28)

<h3 id="html"> Accept a request and return HTML response with a custom dynamic header</h3>
<details open>
<summary> The test simulates just a single HTML response. </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 16808 | 3.42 | 4.83 | 3.77
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 14586 | 3.84 | 5.60 | 4.36
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 13966 | 4.13 | 5.87 | 4.55
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 13413 | 4.15 | 6.12 | 4.73
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 9068 | 6.30 | 9.09 | 7.03
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 7733 | 7.12 | 10.72 | 8.28
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 7226 | 8.67 | 8.88 | 8.86
| [quart](https://pypi.org/project/quart/) `0.14.1` | 3168 | 20.55 | 21.70 | 20.20
| [django](https://pypi.org/project/django/) `3.2` | 1526 | 41.41 | 46.36 | 41.92


</details>

<h3 id="upload"> Parse uploaded file, store it on disk and return a text response</h3>
<details open>
<summary> The test simulates multipart formdata processing and work with files.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 5240 | 9.83 | 16.21 | 12.28
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 3842 | 13.32 | 22.21 | 16.65
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 3663 | 14.10 | 23.16 | 17.45
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 3106 | 17.85 | 26.85 | 20.67
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 2164 | 32.20 | 38.58 | 29.53
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 2078 | 30.36 | 30.82 | 30.78
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 1910 | 38.48 | 42.72 | 33.44
| [quart](https://pypi.org/project/quart/) `0.14.1` | 1206 | 53.37 | 55.29 | 53.04
| [django](https://pypi.org/project/django/) `3.2` | 828 | 76.00 | 87.62 | 77.17


</details>

<h3 id="api"> Parse path params, query string, JSON body and return a json response</h3>
<details open>
<summary> The test simulates a simple JSON REST API endpoint.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 9032 | 6.36 | 9.12 | 7.05
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 8800 | 5.86 | 9.61 | 7.24
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 8326 | 6.26 | 10.11 | 7.65
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 7416 | 7.00 | 11.35 | 8.60
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 6401 | 8.18 | 13.06 | 10.01
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 5709 | 8.87 | 14.92 | 11.17
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 4313 | 14.64 | 14.94 | 14.84
| [quart](https://pypi.org/project/quart/) `0.14.1` | 2045 | 30.88 | 31.96 | 31.28
| [django](https://pypi.org/project/django/) `3.2` | 1287 | 49.51 | 55.12 | 49.66

</details>

<h3 id="composite"> Composite stats </h3>
<details open>
<summary> Combined benchmarks results</summary>

Sorted by completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 466200 | 6.54 | 10.05 | 7.7
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 401310 | 7.81 | 12.64 | 9.55
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 379785 | 9.29 | 14.19 | 10.88
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 353190 | 14.44 | 18.6 | 14.23
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 266955 | 9.8 | 15.65 | 11.91
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 250305 | 17.88 | 22.24 | 17.21
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 204255 | 17.89 | 18.21 | 18.16
| [quart](https://pypi.org/project/quart/) `0.14.1` | 96285 | 34.93 | 36.32 | 34.84
| [django](https://pypi.org/project/django/) `3.2` | 54615 | 55.64 | 63.03 | 56.25

</details>

## Conclusion

Nothing here, just some measures for you.

## License

Licensed under a MIT license (See LICENSE file)
