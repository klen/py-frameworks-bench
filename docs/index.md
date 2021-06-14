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
* Check complete results for the latest benchmark here: [Results (2021-06-14)](_posts/2021-06-14-results.md)

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
                    data: ['538695','486690','452850','372375','346680','324330','281490','227865','130545','114555','72525',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.7` | 538695 | 5.14 | 8.78 | 6.57
| [muffin](https://pypi.org/project/muffin/) `0.79.1` | 486690 | 6.08 | 10.49 | 7.8
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 452850 | 7.21 | 11.8 | 8.96
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 372375 | 10.14 | 16.37 | 12.32
| [emmett](https://pypi.org/project/emmett/) `2.2.2` | 346680 | 15.53 | 20.71 | 17.48
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 324330 | 7.54 | 13.03 | 9.81
| [fastapi](https://pypi.org/project/fastapi/) `0.65.2` | 281490 | 15.18 | 19.46 | 14.66
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 227865 | 15.7 | 15.85 | 15.74
| [tornado](https://pypi.org/project/tornado/) `6.1` | 130545 | 22.7 | 22.82 | 22.7
| [quart](https://pypi.org/project/quart/) `0.15.1` | 114555 | 27.01 | 27.59 | 26.9
| [django](https://pypi.org/project/django/) `3.2.4` | 72525 | 43.07 | 47.07 | 42.49


More details: [Results (2021-06-14)](_posts/2021-06-14-results.md)