---
layout: home
list_title: Archive
description: Python frameworks benchmarks
---

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.2.1/dist/chart.min.js"></script>

This is a simple benchmark for python async frameworks. Almost all of the
frameworks are ASGI-compatible (aiohttp and tornado are exceptions on the
moment).

The objective of the benchmark is not testing deployment (like uvicorn vs
hypercorn and etc) or database (ORM, drivers) but instead test the frameworks
itself. The benchmark checks request parsing (body, headers, formdata,
queries), routing, responses.

* Read about the benchmark: [The Methodic](methodic.md)
* Check complete results for the latest benchmark here: [Results (2021-07-06)](_posts/2021-07-06-results.md)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

## Combined results

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
                    data: ['542520','521430','458235','397935','356820','320325','296850','222660','131160','112680','73620',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.8` | 542520 | 5.11 | 8.84 | 6.53
| [muffin](https://pypi.org/project/muffin/) `0.83.1` | 521430 | 6.31 | 10.21 | 7.62
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 458235 | 7.0 | 11.83 | 8.89
| [starlette](https://pypi.org/project/starlette/) `0.15.0` | 397935 | 10.04 | 16.7 | 12.28
| [emmett](https://pypi.org/project/emmett/) `2.2.3` | 356820 | 16.33 | 19.43 | 17.01
| [sanic](https://pypi.org/project/sanic/) `21.6.0` | 320325 | 7.64 | 13.46 | 9.98
| [fastapi](https://pypi.org/project/fastapi/) `0.66.0` | 296850 | 12.07 | 19.71 | 14.57
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 222660 | 16.17 | 16.59 | 16.26
| [tornado](https://pypi.org/project/tornado/) `6.1` | 131160 | 22.69 | 22.83 | 22.7
| [quart](https://pypi.org/project/quart/) `0.15.1` | 112680 | 27.58 | 28.28 | 27.51
| [django](https://pypi.org/project/django/) `3.2.5` | 73620 | 41.38 | 46.13 | 41.87


More details: [Results (2021-07-06)](_posts/2021-07-06-results.md)