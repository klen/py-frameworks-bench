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
* Check complete results for the latest benchmark here: [Results (2021-12-27)](_posts/2021-12-27-results.md)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

## Combined results

<canvas id="chart" style="margin-bottom: 2em"></canvas>
<script>
    var ctx = document.getElementById('chart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['blacksheep','muffin','falcon','starlette','baize','emmett','fastapi','aiohttp','tornado','quart','sanic','django',],
            datasets: [
                {
                    label: '# of requests',
                    data: ['472935','420570','395925','323595','321450','299400','245640','184965','110085','98550','61860','34710',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.2.2` | 472935 | 6.14 | 10.4 | 7.71
| [muffin](https://pypi.org/project/muffin/) `0.86.3` | 420570 | 7.42 | 12.19 | 9.16
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 395925 | 8.61 | 14.14 | 10.59
| [starlette](https://pypi.org/project/starlette/) `0.17.1` | 323595 | 15.17 | 19.22 | 14.62
| [baize](https://pypi.org/project/baize/) `0.14.1` | 321450 | 13.69 | 15.75 | 14.11
| [emmett](https://pypi.org/project/emmett/) `2.3.2` | 299400 | 19.71 | 25.3 | 21.82
| [fastapi](https://pypi.org/project/fastapi/) `0.70.1` | 245640 | 17.62 | 22.8 | 17.33
| [aiohttp](https://pypi.org/project/aiohttp/) `3.8.1` | 184965 | 19.51 | 19.75 | 19.76
| [tornado](https://pypi.org/project/tornado/) `6.1` | 110085 | 27.03 | 27.34 | 27.02
| [quart](https://pypi.org/project/quart/) `0.16.2` | 98550 | 31.71 | 32.69 | 31.57
| [sanic](https://pypi.org/project/sanic/) `21.12.0` | 61860 | 36.23 | 66.5 | 46.98
| [django](https://pypi.org/project/django/) `4.0` | 34710 | 79.29 | 90.56 | 84.98


More details: [Results (2021-12-27)](_posts/2021-12-27-results.md)