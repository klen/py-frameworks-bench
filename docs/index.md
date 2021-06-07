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
* Check complete results for the latest benchmark here: [Results (2021-06-07)](_posts/2021-06-07-results.md)

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
                    data: ['553080','488055','458100','375720','343395','321480','282780','226065','130800','112875','70065',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.6` | 553080 | 5.01 | 8.68 | 6.42
| [muffin](https://pypi.org/project/muffin/) `0.79.1` | 488055 | 6.06 | 10.54 | 7.75
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 458100 | 6.92 | 11.85 | 8.89
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 375720 | 9.54 | 16.75 | 12.35
| [emmett](https://pypi.org/project/emmett/) `2.2.2` | 343395 | 15.8 | 21.07 | 17.91
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 321480 | 7.55 | 13.21 | 9.91
| [fastapi](https://pypi.org/project/fastapi/) `0.65.1` | 282780 | 11.12 | 19.72 | 14.55
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 226065 | 15.83 | 15.98 | 15.87
| [tornado](https://pypi.org/project/tornado/) `6.1` | 130800 | 22.62 | 22.8 | 22.68
| [quart](https://pypi.org/project/quart/) `0.15.1` | 112875 | 27.33 | 28.13 | 27.32
| [django](https://pypi.org/project/django/) `3.2.4` | 70065 | 43.75 | 48.61 | 44.05


More details: [Results (2021-06-07)](_posts/2021-06-07-results.md)