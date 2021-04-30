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

# The Latest Results (2021-04-30)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

* Read about the benchmark: [The Methodic](methodic.md)
* Check complete results for the latest benchmark here: [Results (2021-04-30)](_posts/2021-04-30-results.md)

Sorted by sum of completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 381960 | 7.52 | 13.28 | 9.75
| [muffin](https://pypi.org/project/muffin/) `0.70` | 343635 | 8.98 | 15.82 | 11.34
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 322110 | 9.98 | 17.15 | 12.57
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 272250 | 13.12 | 23.29 | 16.73
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 243825 | 21.56 | 28.38 | 23.96
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 221715 | 11.25 | 19.63 | 14.32
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 201915 | 15.32 | 27.45 | 19.65
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 151620 | 22.57 | 23.16 | 22.73
| [quart](https://pypi.org/project/quart/) `0.14.1` | 84495 | 39.04 | 41.88 | 39.21
| [django](https://pypi.org/project/django/) `3.2` | 49350 | 60.02 | 69.34 | 61.61

