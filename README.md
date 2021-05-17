# Async Python Web Frameworks comparison

https://klen.github.io/py-frameworks-bench/
----------
#### Updated: 2021-05-17

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
* [The Results](#the-results-2021-05-17)
    * [Accept a request and return HTML response with a custom dynamic header](#html)
    * [Parse uploaded file, store it on disk and return a text response](#upload)
    * [Parse path params, query string, JSON body and return a json response](#api)
    * [Composite stats ](#composite)



<img src='https://quickchart.io/chart?width=800&height=400&c=%7Btype%3A%22bar%22%2Cdata%3A%7Blabels%3A%5B%22blacksheep%22%2C%22muffin%22%2C%22falcon%22%2C%22starlette%22%2C%22emmett%22%2C%22sanic%22%2C%22fastapi%22%2C%22aiohttp%22%2C%22tornado%22%2C%22quart%22%2C%22django%22%5D%2Cdatasets%3A%5B%7Blabel%3A%22num%20of%20req%22%2Cdata%3A%5B360585%2C325890%2C306270%2C254370%2C228795%2C209325%2C187995%2C145140%2C83595%2C77655%2C45810%5D%7D%5D%7D%7D' />

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


## The Results (2021-05-17)

<h3 id="html"> Accept a request and return HTML response with a custom dynamic header</h3>
<details open>
<summary> The test simulates just a single HTML response. </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.5` | 13008 | 3.94 | 6.56 | 4.92
| [muffin](https://pypi.org/project/muffin/) `0.74.1` | 11680 | 4.38 | 7.37 | 5.48
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 11015 | 4.63 | 7.85 | 5.81
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 9732 | 5.21 | 8.97 | 6.57
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 9380 | 5.45 | 9.37 | 6.81
| [fastapi](https://pypi.org/project/fastapi/) `0.65.1` | 6714 | 7.48 | 13.05 | 9.54
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 5993 | 8.44 | 14.41 | 10.69
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 4855 | 12.73 | 13.39 | 13.19
| [quart](https://pypi.org/project/quart/) `0.15.0` | 2340 | 25.83 | 30.46 | 27.39
| [tornado](https://pypi.org/project/tornado/) `6.1` | 2179 | 28.96 | 29.92 | 29.38
| [django](https://pypi.org/project/django/) `3.2.3` | 1240 | 48.83 | 57.88 | 51.57


</details>

<h3 id="upload"> Parse uploaded file, store it on disk and return a text response</h3>
<details open>
<summary> The test simulates multipart formdata processing and work with files.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.5` | 3945 | 12.93 | 22.34 | 16.34
| [muffin](https://pypi.org/project/muffin/) `0.74.1` | 3146 | 16.18 | 28.65 | 20.33
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 2950 | 17.28 | 30.23 | 21.69
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 2617 | 19.50 | 33.34 | 24.52
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 1871 | 27.05 | 48.48 | 34.16
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 1744 | 36.21 | 37.27 | 36.70
| [fastapi](https://pypi.org/project/fastapi/) `0.65.1` | 1692 | 30.11 | 53.22 | 37.82
| [tornado](https://pypi.org/project/tornado/) `6.1` | 1535 | 41.23 | 42.43 | 41.67
| [quart](https://pypi.org/project/quart/) `0.15.0` | 1315 | 48.47 | 51.20 | 48.65
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 1138 | 52.66 | 62.41 | 56.24
| [django](https://pypi.org/project/django/) `3.2.3` | 732 | 83.53 | 98.69 | 87.35


</details>

<h3 id="api"> Parse path params, query string, JSON body and return a json response</h3>
<details open>
<summary> The test simulates a simple JSON REST API endpoint.  </summary>

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.5` | 7086 | 7.05 | 12.51 | 9.02
| [muffin](https://pypi.org/project/muffin/) `0.74.1` | 6900 | 7.41 | 12.70 | 9.29
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 6786 | 7.52 | 12.89 | 9.43
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 5355 | 9.60 | 16.43 | 11.93
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 5012 | 9.99 | 17.45 | 12.79
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 4735 | 10.69 | 18.68 | 13.58
| [fastapi](https://pypi.org/project/fastapi/) `0.65.1` | 4127 | 12.28 | 21.67 | 15.50
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 3077 | 20.38 | 21.15 | 20.81
| [tornado](https://pypi.org/project/tornado/) `6.1` | 1859 | 33.91 | 35.00 | 34.43
| [quart](https://pypi.org/project/quart/) `0.15.0` | 1522 | 41.85 | 43.98 | 42.02
| [django](https://pypi.org/project/django/) `3.2.3` | 1082 | 55.07 | 66.95 | 59.08

</details>

<h3 id="composite"> Composite stats </h3>
<details open>
<summary> Combined benchmarks results</summary>

Sorted by completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.5` | 360585 | 7.97 | 13.8 | 10.09
| [muffin](https://pypi.org/project/muffin/) `0.74.1` | 325890 | 9.32 | 16.24 | 11.7
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 306270 | 10.55 | 18.03 | 13.25
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 254370 | 13.95 | 24.63 | 17.55
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 228795 | 22.93 | 30.15 | 25.54
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 209325 | 11.9 | 20.7 | 15.06
| [fastapi](https://pypi.org/project/fastapi/) `0.65.1` | 187995 | 16.62 | 29.31 | 20.95
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 145140 | 23.11 | 23.94 | 23.57
| [tornado](https://pypi.org/project/tornado/) `6.1` | 83595 | 34.7 | 35.78 | 35.16
| [quart](https://pypi.org/project/quart/) `0.15.0` | 77655 | 38.72 | 41.88 | 39.35
| [django](https://pypi.org/project/django/) `3.2.3` | 45810 | 62.48 | 74.51 | 66.0

</details>

## Conclusion

Nothing here, just some measures for you.

## License

Licensed under a MIT license (See LICENSE file)