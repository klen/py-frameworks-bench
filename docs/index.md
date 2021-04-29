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

