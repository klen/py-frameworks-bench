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

# The Latest Results (2021-04-29)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

* Read about the benchmark: [The Methodic](methodic.md)
* Check complete results for the latest benchmark here: [Results (2021-04-29)](_posts/2021-04-29-results.md)

Sorted by sum of completed requests

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

