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
* Check complete results for the latest benchmark here: [Results (2021-08-02)](_posts/2021-08-02-results.md)

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
                    data: ['545790','486870','455655','373365','344445','323880','279675','227055','128880','113910','70200',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 545790 | 5.13 | 8.77 | 6.53
| [muffin](https://pypi.org/project/muffin/) `0.84.1` | 486870 | 6.16 | 10.59 | 7.82
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 455655 | 7.1 | 11.91 | 9.01
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 373365 | 9.56 | 16.48 | 12.29
| [emmett](https://pypi.org/project/emmett/) `2.2.3` | 344445 | 15.55 | 21.07 | 17.73
| [sanic](https://pypi.org/project/sanic/) `21.6.0` | 323880 | 7.56 | 13.0 | 9.83
| [fastapi](https://pypi.org/project/fastapi/) `0.67.0` | 279675 | 11.61 | 19.84 | 14.8
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 227055 | 15.83 | 15.95 | 15.85
| [tornado](https://pypi.org/project/tornado/) `6.1` | 128880 | 23.01 | 23.12 | 23.02
| [quart](https://pypi.org/project/quart/) `0.15.1` | 113910 | 27.2 | 27.84 | 27.14
| [django](https://pypi.org/project/django/) `3.2.5` | 70200 | 44.21 | 48.76 | 43.99


More details: [Results (2021-08-02)](_posts/2021-08-02-results.md)