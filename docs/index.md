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
* Check complete results for the latest benchmark here: [Results (2021-05-31)](_posts/2021-05-31-results.md)

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
                    data: ['553635','490470','450315','373035','346905','322590','280140','226770','130230','115125','66840',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.6` | 553635 | 5.06 | 8.51 | 6.41
| [muffin](https://pypi.org/project/muffin/) `0.78.0` | 490470 | 5.98 | 10.26 | 7.66
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 450315 | 7.19 | 11.97 | 9.04
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 373035 | 13.14 | 16.1 | 12.21
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 346905 | 15.73 | 20.84 | 17.7
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 322590 | 7.55 | 13.08 | 9.81
| [fastapi](https://pypi.org/project/fastapi/) `0.65.1` | 280140 | 11.33 | 19.98 | 14.63
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 226770 | 15.87 | 15.96 | 15.87
| [tornado](https://pypi.org/project/tornado/) `6.1` | 130230 | 22.66 | 22.78 | 22.69
| [quart](https://pypi.org/project/quart/) `0.15.1` | 115125 | 26.74 | 27.31 | 26.79
| [django](https://pypi.org/project/django/) `3.2.3` | 66840 | 45.93 | 50.83 | 45.85


More details: [Results (2021-05-31)](_posts/2021-05-31-results.md)