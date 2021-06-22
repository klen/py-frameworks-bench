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
* Check complete results for the latest benchmark here: [Results (2021-06-22)](_posts/2021-06-22-results.md)

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
                    data: ['467295','423960','393750','324615','292305','280365','242865','196455','105060','90660','59565',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.8` | 467295 | 6.46 | 10.45 | 7.88
| [muffin](https://pypi.org/project/muffin/) `0.80.0` | 423960 | 7.25 | 12.35 | 9.17
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 393750 | 8.6 | 13.96 | 10.57
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 324615 | 12.23 | 19.3 | 14.6
| [emmett](https://pypi.org/project/emmett/) `2.2.3` | 292305 | 20.74 | 26.08 | 22.61
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 280365 | 9.25 | 15.31 | 11.55
| [fastapi](https://pypi.org/project/fastapi/) `0.65.2` | 242865 | 17.75 | 22.79 | 17.38
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 196455 | 18.61 | 18.95 | 18.63
| [tornado](https://pypi.org/project/tornado/) `6.1` | 105060 | 27.9 | 28.61 | 28.19
| [quart](https://pypi.org/project/quart/) `0.15.1` | 90660 | 33.44 | 35.48 | 33.98
| [django](https://pypi.org/project/django/) `3.2.4` | 59565 | 51.51 | 57.03 | 51.56


More details: [Results (2021-06-22)](_posts/2021-06-22-results.md)