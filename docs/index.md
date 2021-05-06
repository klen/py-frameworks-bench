---
layout: home
list_title: Archive
description: Python frameworks benchmarks
---

This is a simple benchmark for python async frameworks. Almost all of the
frameworks are ASGI-compatible (aiohttp is an exception).

The objective of the benchmark is not testing deployment (like uvicorn vs
hypercorn and etc) or database (ORM, drivers) but instead test the frameworks
itself. The benchmark checks request parsing (body, headers, formdata,
queries), routing, responses.

# The Latest Results (2021-05-06)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

* Read about the benchmark: [The Methodic](methodic.md)
* Check complete results for the latest benchmark here: [Results (2021-05-06)](_posts/2021-05-06-results.md)

Sorted by sum of completed requests

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

