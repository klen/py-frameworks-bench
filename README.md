# Async Python Web Frameworks comparison

https://klen.github.io/py-frameworks-bench/
----------
#### Updated: 2021-05-06

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
* [The Results](#the-results-2021-05-06)
    * [Accept a request and return HTML response with a custom dynamic header](#html)
    * [Parse uploaded file, store it on disk and return a text response](#upload)
    * [Parse path params, query string, JSON body and return a json response](#api)
    * [Composite stats ](#composite)



<img src='https://quickchart.io/chart?width=800&height=400&c=%7Btype%3A%22bar%22%2Cdata%3A%7Blabels%3A%5B%22blacksheep%22%2C%22muffin%22%2C%22falcon%22%2C%22starlette%22%2C%22emmett%22%2C%22sanic%22%2C%22fastapi%22%2C%22aiohttp%22%2C%22tornado%22%2C%22quart%22%2C%22django%22%5D%2Cdatasets%3A%5B%7Blabel%3A%22num%20of%20req%22%2Cdata%3A%5B415485%2C370305%2C346290%2C295530%2C265140%2C244395%2C221745%2C167010%2C95730%2C91740%2C52965%5D%7D%5D%7D%7D' />

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


## The Results (2021-05-06)

<h3 id="html"> Accept a request and return HTML response with a custom dynamic header</h3>
<details open>
<summary> The test simulates just a single HTML response. </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 15097 | 3.43 | 5.78 | 4.22
| [muffin](https://pypi.org/project/muffin/) `0.70.1` | 13454 | 3.82 | 6.46 | 4.73
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 12411 | 4.15 | 6.91 | 5.13
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 11167 | 4.62 | 7.85 | 5.71
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 10721 | 4.76 | 8.26 | 5.95
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 7984 | 6.39 | 11.12 | 7.99
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 6897 | 7.33 | 12.63 | 9.28
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 5649 | 11.20 | 11.76 | 11.33
| [quart](https://pypi.org/project/quart/) `0.14.1` | 3027 | 20.91 | 23.65 | 21.12
| [tornado](https://pypi.org/project/tornado/) `6.1` | 2492 | 25.39 | 26.50 | 25.69
| [django](https://pypi.org/project/django/) `3.2.2` | 1467 | 43.32 | 48.94 | 43.58


</details>

<h3 id="upload"> Parse uploaded file, store it on disk and return a text response</h3>
<details open>
<summary> The test simulates multipart formdata processing and work with files.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 4579 | 11.16 | 19.74 | 13.95
| [muffin](https://pypi.org/project/muffin/) `0.70.1` | 3543 | 14.18 | 25.06 | 18.07
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 3475 | 14.35 | 25.35 | 18.40
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 3005 | 16.83 | 29.30 | 21.34
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 2196 | 22.87 | 41.03 | 29.10
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 2000 | 25.21 | 45.34 | 31.96
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 1979 | 32.26 | 33.40 | 32.32
| [tornado](https://pypi.org/project/tornado/) `6.1` | 1758 | 36.04 | 37.42 | 36.40
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 1320 | 45.61 | 53.97 | 48.43
| [quart](https://pypi.org/project/quart/) `0.14.1` | 1180 | 54.38 | 57.14 | 54.19
| [django](https://pypi.org/project/django/) `3.2.2` | 825 | 76.77 | 87.27 | 77.41


</details>

<h3 id="api"> Parse path params, query string, JSON body and return a json response</h3>
<details open>
<summary> The test simulates a simple JSON REST API endpoint.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 8023 | 6.39 | 11.12 | 7.95
| [muffin](https://pypi.org/project/muffin/) `0.70.1` | 7690 | 6.57 | 11.37 | 8.30
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 7670 | 6.64 | 11.52 | 8.32
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 6339 | 8.01 | 14.07 | 10.07
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 5921 | 8.52 | 14.79 | 10.80
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 5635 | 8.91 | 15.72 | 11.38
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 4799 | 10.58 | 18.76 | 13.31
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 3506 | 17.98 | 18.89 | 18.26
| [tornado](https://pypi.org/project/tornado/) `6.1` | 2132 | 29.69 | 30.88 | 30.01
| [quart](https://pypi.org/project/quart/) `0.14.1` | 1909 | 33.16 | 35.32 | 33.51
| [django](https://pypi.org/project/django/) `3.2.2` | 1239 | 50.43 | 58.24 | 51.59

</details>

<h3 id="composite"> Composite stats </h3>
<details open>
<summary> Combined benchmarks results</summary>

Sorted by completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 415485 | 6.99 | 12.21 | 8.71
| [muffin](https://pypi.org/project/muffin/) `0.70.1` | 370305 | 8.19 | 14.3 | 10.37
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 346290 | 9.21 | 15.91 | 11.6
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 295530 | 11.83 | 20.98 | 14.96
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 265140 | 19.76 | 25.98 | 21.92
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 244395 | 10.07 | 17.59 | 12.83
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 221745 | 14.06 | 25.07 | 17.75
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 167010 | 20.48 | 21.35 | 20.64
| [tornado](https://pypi.org/project/tornado/) `6.1` | 95730 | 30.37 | 31.6 | 30.7
| [quart](https://pypi.org/project/quart/) `0.14.1` | 91740 | 36.15 | 38.7 | 36.27
| [django](https://pypi.org/project/django/) `3.2.2` | 52965 | 56.84 | 64.82 | 57.53

</details>

## Conclusion

Nothing here, just some measures for you.

## License

Licensed under a MIT license (See LICENSE file)