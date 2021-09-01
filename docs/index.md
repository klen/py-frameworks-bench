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
* Check complete results for the latest benchmark here: [Results (2021-09-01)](_posts/2021-09-01-results.md)

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
                    data: ['526905','469605','447090','361845','333060','306615','272805','213840','124755','108585','66060',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 526905 | 5.78 | 8.89 | 6.8
| [muffin](https://pypi.org/project/muffin/) `0.84.5` | 469605 | 7.58 | 10.63 | 8.11
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 447090 | 9.32 | 11.75 | 9.13
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 361845 | 13.62 | 16.75 | 12.96
| [emmett](https://pypi.org/project/emmett/) `2.3.1` | 333060 | 17.36 | 22.08 | 18.97
| [sanic](https://pypi.org/project/sanic/) `21.6.2` | 306615 | 8.99 | 13.63 | 10.42
| [fastapi](https://pypi.org/project/fastapi/) `0.68.1` | 272805 | 15.66 | 19.56 | 15.19
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 213840 | 17.05 | 17.47 | 17.08
| [tornado](https://pypi.org/project/tornado/) `6.1` | 124755 | 23.59 | 24.26 | 23.7
| [quart](https://pypi.org/project/quart/) `0.15.1` | 108585 | 28.2 | 29.43 | 28.37
| [django](https://pypi.org/project/django/) `3.2.6` | 66060 | 46.99 | 51.67 | 46.76


More details: [Results (2021-09-01)](_posts/2021-09-01-results.md)