---
layout: home
list_title: Archive
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
* Check full tests for the benchmark here: [Results (2021-04-29)](_posts/2021-04-29-results.md)

Sorted by sum of completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 463485 | 6.61 | 9.99 | 7.68
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 413475 | 7.75 | 12.06 | 9.16
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 375930 | 9.15 | 13.82 | 10.62
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 361110 | 11.76 | 18.16 | 13.79
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 301950 | 20.2 | 25.41 | 22.13
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 268515 | 10.21 | 15.5 | 11.93
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 258540 | 15.45 | 21.8 | 16.67
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 205950 | 17.66 | 18.02 | 17.95
| [quart](https://pypi.org/project/quart/) `0.14.1` | 99060 | 34.35 | 35.66 | 34.22
| [django](https://pypi.org/project/django/) `3.2` | 52950 | 56.69 | 64.64 | 57.68

