---
layout: home
list_title: Archive
description: Python frameworks benchmarks
---

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.2.1/dist/chart.min.js"></script>

This is a simple benchmark for python async frameworks. Almost all of the
frameworks are ASGI-compatible (aiohttp is an exception).

The objective of the benchmark is not testing deployment (like uvicorn vs
hypercorn and etc) or database (ORM, drivers) but instead test the frameworks
itself. The benchmark checks request parsing (body, headers, formdata,
queries), routing, responses.

# The Latest Results (2021-05-06)

* Read about the benchmark: [The Methodic](methodic.md)
* Check complete results for the latest benchmark here: [Results (2021-05-06)](_posts/2021-05-06-results.md)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

<canvas id="chart" style="margin-bottom: 2em"></canvas>
<script>
    var ctx = document.getElementById('chart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['blacksheep','muffin','falcon','starlette','emmett','sanic','fastapi','aiohttp','tornado','quart','django',],
            datasets: [
                {
                    label: '# of requests',
                    data: ['426270','370725','347790','293430','263610','244320','218640','163320','95475','92010','53445',],
                    backgroundColor: [
                        '#4E79A7', '#A0CBE8', '#F28E2B', '#FFBE7D', '#59A14F', '#8CD17D', '#B6992D', '#F1CE63', '#499894', '#86BCB6', '#E15759', '#FF9D9A', '#79706E', '#BAB0AC', '#D37295', '#FABFD2', '#B07AA1', '#D4A6C8', '#9D7660', '#D7B5A6',
                    ]
                },
            ]
        }
    });
</script>

Sorted by sum of completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.3` | 426270 | 6.69 | 12.03 | 8.57
| [muffin](https://pypi.org/project/muffin/) `0.70.1` | 370725 | 8.21 | 14.74 | 10.55
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 347790 | 8.9 | 15.92 | 11.44
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 293430 | 11.9 | 21.92 | 15.37
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 263610 | 19.64 | 26.13 | 21.94
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 244320 | 9.95 | 18.23 | 12.81
| [fastapi](https://pypi.org/project/fastapi/) `0.63.0` | 218640 | 13.87 | 25.68 | 18.11
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 163320 | 20.34 | 21.19 | 20.67
| [tornado](https://pypi.org/project/tornado/) `6.1` | 95475 | 30.36 | 31.34 | 30.78
| [quart](https://pypi.org/project/quart/) `0.14.1` | 92010 | 36.25 | 38.11 | 35.98
| [django](https://pypi.org/project/django/) `3.2.2` | 53445 | 54.75 | 63.47 | 56.52

