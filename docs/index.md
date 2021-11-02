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
* Check complete results for the latest benchmark here: [Results (2021-11-02)](_posts/2021-11-02-results.md)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

## Combined results

<canvas id="chart" style="margin-bottom: 2em"></canvas>
<script>
    var ctx = document.getElementById('chart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['blacksheep','muffin','falcon','starlette','baize','emmett','sanic','fastapi','aiohttp','tornado','quart','django',],
            datasets: [
                {
                    label: '# of requests',
                    data: ['517515','466410','425130','359265','344040','320055','301485','267150','213045','124485','110340','66900',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.2.0` | 517515 | 5.51 | 9.33 | 6.94
| [muffin](https://pypi.org/project/muffin/) `0.86.0` | 466410 | 6.48 | 11.07 | 8.21
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 425130 | 9.5 | 12.17 | 9.8
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 359265 | 12.21 | 17.33 | 12.98
| [baize](https://pypi.org/project/baize/) `0.12.1` | 344040 | 12.24 | 13.96 | 12.72
| [emmett](https://pypi.org/project/emmett/) `2.3.2` | 320055 | 18.15 | 22.01 | 19.5
| [sanic](https://pypi.org/project/sanic/) `21.9.1` | 301485 | 8.22 | 14.13 | 10.71
| [fastapi](https://pypi.org/project/fastapi/) `0.70.0` | 267150 | 15.37 | 19.85 | 15.52
| [aiohttp](https://pypi.org/project/aiohttp/) `3.8.0` | 213045 | 16.76 | 17.0 | 17.0
| [tornado](https://pypi.org/project/tornado/) `6.1` | 124485 | 23.75 | 23.89 | 23.95
| [quart](https://pypi.org/project/quart/) `0.15.1` | 110340 | 27.95 | 28.58 | 28.16
| [django](https://pypi.org/project/django/) `3.2.9` | 66900 | 45.19 | 50.13 | 46.33


More details: [Results (2021-11-02)](_posts/2021-11-02-results.md)