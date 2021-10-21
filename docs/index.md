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
            labels: ['blacksheep','muffin','falcon','starlette','emmett','sanic','fastapi','aiohttp','tornado','quart','django',],
            datasets: [
                {
                    label: '# of requests',
                    data: ['515205','461415','424905','349920','317925','297930','269130','213735','123915','106980','63660',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.9` | 515205 | 5.57 | 9.43 | 7.04
| [muffin](https://pypi.org/project/muffin/) `0.86.0` | 461415 | 6.61 | 11.22 | 8.27
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 424905 | 8.4 | 13.29 | 10.01
| [starlette](https://pypi.org/project/starlette/) `0.16.0` | 349920 | 10.41 | 18.02 | 13.25
| [emmett](https://pypi.org/project/emmett/) `2.3.1` | 317925 | 17.63 | 22.32 | 19.82
| [sanic](https://pypi.org/project/sanic/) `21.9.1` | 297930 | 8.58 | 14.53 | 10.87
| [fastapi](https://pypi.org/project/fastapi/) `0.70.0` | 269130 | 12.45 | 21.3 | 15.6
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 213735 | 16.82 | 17.14 | 17.12
| [tornado](https://pypi.org/project/tornado/) `6.1` | 123915 | 23.81 | 24.12 | 24.14
| [quart](https://pypi.org/project/quart/) `0.15.1` | 106980 | 28.68 | 29.75 | 28.9
| [django](https://pypi.org/project/django/) `3.2.8` | 63660 | 47.72 | 52.51 | 48.64


More details: [Results (2021-10-21)](_posts/2021-10-21-results.md)