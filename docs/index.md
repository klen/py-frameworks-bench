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
* Check complete results for the latest benchmark here: [Results (2022-03-14)](_posts/2022-03-14-results.md)

[![benchmarks](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/benchmarks.yml)
[![tests](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml/badge.svg)](https://github.com/klen/py-frameworks-bench/actions/workflows/tests.yml)

## Combined results

<canvas id="chart" style="margin-bottom: 2em"></canvas>
<script>
    var ctx = document.getElementById('chart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['blacksheep','sanic','muffin','falcon','starlette','baize','emmett','fastapi','aiohttp','tornado','quart','django',],
            datasets: [
                {
                    label: '# of requests',
                    data: ['519825','470400','469725','436800','365490','349425','328275','255615','209310','121185','109755','38610',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.2.5` | 519825 | 5.46 | 9.49 | 6.96
| [sanic](https://pypi.org/project/sanic/) `21.12.1` | 470400 | 7.37 | 9.88 | 7.57
| [muffin](https://pypi.org/project/muffin/) `0.87.0` | 469725 | 6.34 | 11.19 | 8.14
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 436800 | 7.58 | 13.19 | 9.7
| [starlette](https://pypi.org/project/starlette/) `0.17.1` | 365490 | 9.94 | 17.77 | 12.9
| [baize](https://pypi.org/project/baize/) `0.15.0` | 349425 | 11.85 | 13.64 | 12.29
| [emmett](https://pypi.org/project/emmett/) `2.4.5` | 328275 | 18.18 | 22.85 | 19.69
| [fastapi](https://pypi.org/project/fastapi/) `0.75.0` | 255615 | 12.48 | 22.29 | 16.11
| [aiohttp](https://pypi.org/project/aiohttp/) `3.8.1` | 209310 | 17.23 | 17.47 | 17.31
| [tornado](https://pypi.org/project/tornado/) `6.1` | 121185 | 24.53 | 24.73 | 24.59
| [quart](https://pypi.org/project/quart/) `0.16.3` | 109755 | 28.36 | 29.24 | 28.37
| [django](https://pypi.org/project/django/) `4.0.3` | 38610 | 71.15 | 75.81 | 76.2


More details: [Results (2022-03-14)](_posts/2022-03-14-results.md)