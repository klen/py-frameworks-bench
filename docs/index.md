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

[![benchmarks](https://github.com/klen/muffin-benchmark/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/muffin-benchmark/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/muffin-benchmark/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/muffin-benchmark/actions/workflows/tests.yml)

* Read about the benchmark: [The Methodic](methodic.md)
* Check full tests for the benchmark here: [Results (2021-04-28)](_posts/2021-04-28-results.md)

Sorted by sum of completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 494115 | 5.81 | 9.59 | 7.24
| [muffin](https://pypi.org/project/muffin/) `0.69.5` | 426060 | 7.42 | 11.85 | 8.91
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 410025 | 8.76 | 13.03 | 10.0
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 378090 | 13.18 | 17.17 | 13.28
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 280320 | 9.0 | 15.01 | 11.3
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 275115 | 15.96 | 20.72 | 15.87
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 218700 | 17.15 | 17.34 | 17.19
| [quart](https://pypi.org/project/quart/) `0.14.1` | 102975 | 32.16 | 33.81 | 32.36
| [django](https://pypi.org/project/django/) `3.2` | 58095 | 52.78 | 58.93 | 53.0

