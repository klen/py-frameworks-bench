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
* Check complete results for the latest benchmark here: [Results (2021-05-10)](_posts/2021-05-10-results.md)

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
                    data: ['547320','477660','446820','374085','341130','319260','277860','224640','129690','113715','64935',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.4` | 547320 | 5.13 | 8.71 | 6.47
| [muffin](https://pypi.org/project/muffin/) `0.70.1` | 477660 | 6.19 | 10.7 | 7.92
| [falcon](https://pypi.org/project/falcon/) `3.0.0` | 446820 | 7.24 | 12.17 | 9.15
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 374085 | 9.73 | 16.86 | 12.44
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 341130 | 16.21 | 21.45 | 18.33
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 319260 | 7.72 | 13.22 | 9.99
| [fastapi](https://pypi.org/project/fastapi/) `0.65.0` | 277860 | 11.54 | 20.28 | 14.91
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 224640 | 16.22 | 16.48 | 16.24
| [tornado](https://pypi.org/project/tornado/) `6.1` | 129690 | 22.81 | 23.11 | 22.87
| [quart](https://pypi.org/project/quart/) `0.14.1` | 113715 | 29.54 | 30.68 | 29.56
| [django](https://pypi.org/project/django/) `3.2.2` | 64935 | 45.8 | 52.48 | 47.29


More details: [Results (2021-05-10)](_posts/2021-05-10-results.md)