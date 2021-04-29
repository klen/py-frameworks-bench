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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 14770 | 3.44 | 5.94 | 4.31
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 12502 | 4.07 | 7.01 | 5.10
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 12262 | 4.16 | 7.21 | 5.20
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 11885 | 4.25 | 7.45 | 5.36
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 10323 | 4.93 | 8.59 | 6.18
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 8223 | 6.13 | 10.72 | 7.76
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 6733 | 7.41 | 12.96 | 9.51
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 5754 | 11.05 | 11.43 | 11.12
| [quart](https://pypi.org/project/quart/) `0.14.1` | 2927 | 20.15 | 24.56 | 21.85
| [django](https://pypi.org/project/django/) `3.2` | 1455 | 41.74 | 49.44 | 43.96


</details>

<h3 id="upload"> Parse uploaded file, store it on disk and return a text response</h3>
<details open>
<summary> The test simulates multipart formdata processing and work with files.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 4391 | 11.33 | 20.30 | 14.61
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 3379 | 14.84 | 27.14 | 18.91
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 3366 | 14.61 | 26.24 | 18.98
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 2957 | 16.87 | 30.01 | 21.68
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 2109 | 23.30 | 43.02 | 30.32
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 2029 | 31.21 | 32.66 | 31.53
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 1923 | 25.53 | 46.67 | 33.25
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 1273 | 47.13 | 55.75 | 50.24
| [quart](https://pypi.org/project/quart/) `0.14.1` | 1180 | 55.15 | 57.09 | 54.19
| [django](https://pypi.org/project/django/) `3.2` | 822 | 75.13 | 87.49 | 77.68


</details>

<h3 id="api"> Parse path params, query string, JSON body and return a json response</h3>
<details open>
<summary> The test simulates a simple JSON REST API endpoint.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 7801 | 6.50 | 11.44 | 8.18
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 7555 | 6.68 | 11.91 | 8.45
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 7216 | 7.04 | 12.45 | 8.85
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 6309 | 8.04 | 14.48 | 10.12
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 5620 | 8.86 | 15.85 | 11.38
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 5320 | 9.31 | 16.83 | 12.05
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 4799 | 10.32 | 18.73 | 13.31
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 3528 | 17.97 | 18.73 | 18.15
| [quart](https://pypi.org/project/quart/) `0.14.1` | 1862 | 34.54 | 35.88 | 34.35
| [django](https://pypi.org/project/django/) `3.2` | 1248 | 49.22 | 57.56 | 51.25

</details>

<h3 id="composite"> Composite stats </h3>
<details open>
<summary> Combined benchmarks results</summary>

Sorted by completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 404430 | 7.09 | 12.56 | 9.03
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 346455 | 8.65 | 15.53 | 10.95
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 335955 | 9.27 | 16.46 | 11.83
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 310200 | 11.83 | 21.57 | 15.21
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 253740 | 20.46 | 27.06 | 22.82
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 235785 | 10.29 | 18.35 | 13.29
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 224175 | 13.99 | 25.37 | 18.11
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 169665 | 20.08 | 20.94 | 20.27
| [quart](https://pypi.org/project/quart/) `0.14.1` | 89535 | 36.61 | 39.18 | 36.8
| [django](https://pypi.org/project/django/) `3.2` | 52875 | 55.36 | 64.83 | 57.63

</details>

## Conclusion

Nothing here, just some measures for you.

## License

Licensed under a MIT license (See LICENSE file)