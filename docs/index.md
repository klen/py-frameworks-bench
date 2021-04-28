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

# The Latest Results (2021-04-28)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

* Read about the benchmark: [The Methodic](methodic.md)
* Check full tests for the benchmark here: [Results (2021-04-28)](_posts/2021-04-28-results.md)

Sorted by sum of completed requests

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

