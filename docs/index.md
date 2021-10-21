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
* Check complete results for the latest benchmark here: [Results (2021-10-21)](_posts/2021-10-21-results.md)

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
                    data: ['508515','455565','418335','346860','333450','311055','294465','262440','204930','118785','103950','61500',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 508515 | 5.86 | 9.52 | 7.14
| [muffin](https://pypi.org/project/muffin/) `0.86.0` | 455565 | 6.89 | 11.32 | 8.46
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 418335 | 8.09 | 13.15 | 9.89
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 346860 | 10.73 | 18.3 | 13.43
| [baize](https://pypi.org/project/baize/) `0.12` | 333450 | 13.02 | 15.05 | 13.59
| [emmett](https://pypi.org/project/emmett/) `2.3.1` | 311055 | 18.57 | 22.92 | 20.65
| [sanic](https://pypi.org/project/sanic/) `21.9.1` | 294465 | 8.79 | 14.48 | 10.97
| [fastapi](https://pypi.org/project/fastapi/) `0.70.0` | 262440 | 12.93 | 21.01 | 15.77
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 204930 | 17.71 | 17.9 | 17.83
| [tornado](https://pypi.org/project/tornado/) `6.1` | 118785 | 24.97 | 25.21 | 25.12
| [quart](https://pypi.org/project/quart/) `0.15.1` | 103950 | 29.05 | 31.69 | 29.87
| [django](https://pypi.org/project/django/) `3.2.8` | 61500 | 48.31 | 55.11 | 50.1


More details: [Results (2021-10-21)](_posts/2021-10-21-results.md)