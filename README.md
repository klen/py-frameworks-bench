# Async Python Web Frameworks comparison

https://klen.github.io/py-frameworks-bench/
----------
#### Updated: 2021-10-21

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

----------

This is a simple benchmark for python async frameworks. Almost all of the
frameworks are ASGI-compatible (aiohttp and tornado are exceptions on the
moment).

The objective of the benchmark is not testing deployment (like uvicorn vs
hypercorn and etc) or database (ORM, drivers) but instead test the frameworks
itself. The benchmark checks request parsing (body, headers, formdata,
queries), routing, responses.

## Table of contents

* [The Methodic](#the-methodic)
* [The Results](#the-results-2021-10-21)
    * [Accept a request and return HTML response with a custom dynamic header](#html)
    * [Parse path params, query string, JSON body and return a json response](#api)
    * [Parse uploaded file, store it on disk and return a text response](#upload)
    * [Composite stats ](#composite)



<img src='https://quickchart.io/chart?width=800&height=400&c=%7Btype%3A%22bar%22%2Cdata%3A%7Blabels%3A%5B%22blacksheep%22%2C%22muffin%22%2C%22falcon%22%2C%22starlette%22%2C%22baize%22%2C%22emmett%22%2C%22sanic%22%2C%22fastapi%22%2C%22aiohttp%22%2C%22tornado%22%2C%22quart%22%2C%22django%22%5D%2Cdatasets%3A%5B%7Blabel%3A%22num%20of%20req%22%2Cdata%3A%5B508515%2C455565%2C418335%2C346860%2C333450%2C311055%2C294465%2C262440%2C204930%2C118785%2C103950%2C61500%5D%7D%5D%7D%7D' />

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

2. "API" test: Check headers, parse path params, query string, JSON body and return a json
   response. The test simulates an JSON REST API.

3. "Upload" test: accept an uploaded file and store it on disk. The test
   simulates multipart formdata processing and work with files.


## The Results (2021-10-21)

<h3 id="html"> Accept a request and return HTML response with a custom dynamic header</h3>
<details open>
<summary> The test simulates just a single HTML response. </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 18280 | 2.92 | 4.56 | 3.48
| [muffin](https://pypi.org/project/muffin/) `0.86.0` | 16016 | 3.35 | 5.17 | 3.97
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 14747 | 3.50 | 5.69 | 4.32
| [baize](https://pypi.org/project/baize/) `0.12` | 13481 | 3.83 | 6.20 | 4.72
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 12981 | 3.99 | 6.31 | 4.92
| [emmett](https://pypi.org/project/emmett/) `2.3.1` | 12580 | 4.10 | 6.63 | 5.06
| [fastapi](https://pypi.org/project/fastapi/) `0.70.0` | 9140 | 5.59 | 9.17 | 6.98
| [sanic](https://pypi.org/project/sanic/) `21.9.1` | 8547 | 6.00 | 9.67 | 7.52
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 7156 | 8.89 | 9.02 | 8.95
| [tornado](https://pypi.org/project/tornado/) `6.1` | 3217 | 19.76 | 20.06 | 19.90
| [quart](https://pypi.org/project/quart/) `0.15.1` | 3206 | 19.87 | 21.77 | 19.99
| [django](https://pypi.org/project/django/) `3.2.8` | 1744 | 34.93 | 40.11 | 36.88


</details>

<h3 id="api"> Parse path params, query string, JSON body and return a json response</h3>
<details open>
<summary> The test simulates a simple JSON REST API endpoint.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 10142 | 5.02 | 8.45 | 6.27
| [muffin](https://pypi.org/project/muffin/) `0.86.0` | 10083 | 5.09 | 8.41 | 6.32
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 9719 | 5.27 | 8.96 | 6.55
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 7781 | 6.54 | 11.12 | 8.19
| [sanic](https://pypi.org/project/sanic/) `21.9.1` | 7179 | 6.99 | 12.09 | 8.94
| [emmett](https://pypi.org/project/emmett/) `2.3.1` | 6803 | 7.33 | 12.42 | 9.59
| [baize](https://pypi.org/project/baize/) `0.12` | 6277 | 10.23 | 10.71 | 10.18
| [fastapi](https://pypi.org/project/fastapi/) `0.70.0` | 6229 | 8.00 | 13.90 | 10.25
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 4363 | 14.65 | 14.93 | 14.67
| [tornado](https://pypi.org/project/tornado/) `6.1` | 2668 | 23.78 | 23.96 | 24.01
| [quart](https://pypi.org/project/quart/) `0.15.1` | 2065 | 29.96 | 32.38 | 31.05
| [django](https://pypi.org/project/django/) `3.2.8` | 1422 | 43.04 | 49.50 | 44.96

</details>

<h3 id="upload"> Parse uploaded file, store it on disk and return a text response</h3>
<details open>
<summary> The test simulates multipart formdata processing and work with files.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 5479 | 9.63 | 15.56 | 11.67
| [muffin](https://pypi.org/project/muffin/) `0.86.0` | 4272 | 12.22 | 20.39 | 15.08
| [sanic](https://pypi.org/project/sanic/) `21.9.1` | 3905 | 13.39 | 21.69 | 16.46
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 3423 | 15.49 | 24.81 | 18.80
| [baize](https://pypi.org/project/baize/) `0.12` | 2472 | 24.99 | 28.25 | 25.88
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 2362 | 21.67 | 37.48 | 27.17
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 2143 | 29.58 | 29.76 | 29.87
| [fastapi](https://pypi.org/project/fastapi/) `0.70.0` | 2127 | 25.19 | 39.96 | 30.08
| [tornado](https://pypi.org/project/tornado/) `6.1` | 2034 | 31.36 | 31.61 | 31.46
| [quart](https://pypi.org/project/quart/) `0.15.1` | 1659 | 37.33 | 40.91 | 38.58
| [emmett](https://pypi.org/project/emmett/) `2.3.1` | 1354 | 44.27 | 49.71 | 47.31
| [django](https://pypi.org/project/django/) `3.2.8` | 934 | 66.96 | 75.72 | 68.45


</details>

<h3 id="composite"> Composite stats </h3>
<details open>
<summary> Combined benchmarks results</summary>

Sorted by completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 508515 | 5.86 | 9.52 | 7.14
| [muffin](https://pypi.org/project/muffin/) `0.86.0` | 455565 | 6.89 | 11.32 | 8.46
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 418335 | 8.09 | 13.15 | 9.89
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 346860 | 10.73 | 18.3 | 13.43
| [baize](https://pypi.org/project/baize/) `0.12` | 333450 | 13.02 | 15.05 | 13.59
| [emmett](https://pypi.org/project/emmett/) `2.3.1` | 311055 | 18.57 | 22.92 | 20.65
| [sanic](https://pypi.org/project/sanic/) `21.9.1` | 294465 | 8.79 | 14.48 | 10.97
| [fastapi](https://pypi.org/project/fastapi/) `0.70.0` | 262440 | 12.93 | 21.01 | 15.77
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 204930 | 17.71 | 17.9 | 17.83
| [tornado](https://pypi.org/project/tornado/) `6.1` | 118785 | 24.97 | 25.21 | 25.12
| [quart](https://pypi.org/project/quart/) `0.15.1` | 103950 | 29.05 | 31.69 | 29.87
| [django](https://pypi.org/project/django/) `3.2.8` | 61500 | 48.31 | 55.11 | 50.1

</details>

## Conclusion

Nothing here, just some measures for you.

## License

Licensed under a MIT license (See LICENSE file)