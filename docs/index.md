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
* Check complete results for the latest benchmark here: [Results (2021-05-17)](_posts/2021-05-17-results.md)

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
                    data: ['557115','490275','466005','386505','355890','329745','282915','222930','132060','116940','66675',],
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
| [blacksheep](https://pypi.org/project/blacksheep/) `1.0.5` | 557115 | 6.95 | 8.31 | 6.41
| [muffin](https://pypi.org/project/muffin/) `0.70.1` | 490275 | 8.31 | 10.12 | 7.77
| [falcon](https://pypi.org/project/falcon/) `3.0.1` | 466005 | 9.4 | 11.1 | 8.69
| [starlette](https://pypi.org/project/starlette/) `0.14.2` | 386505 | 13.65 | 15.33 | 12.11
| [emmett](https://pypi.org/project/emmett/) `2.2.1` | 355890 | 17.18 | 20.65 | 17.7
| [sanic](https://pypi.org/project/sanic/) `21.3.4` | 329745 | 10.69 | 12.27 | 9.59
| [fastapi](https://pypi.org/project/fastapi/) `0.65.1` | 282915 | 16.09 | 18.13 | 14.47
| [aiohttp](https://pypi.org/project/aiohttp/) `3.7.4.post0` | 222930 | 16.21 | 16.79 | 16.22
| [tornado](https://pypi.org/project/tornado/) `6.1` | 132060 | 22.43 | 23.3 | 22.56
| [quart](https://pypi.org/project/quart/) `0.15.0` | 116940 | 25.91 | 27.18 | 26.26
| [django](https://pypi.org/project/django/) `3.2.3` | 66675 | 46.14 | 51.11 | 46.03


More details: [Results (2021-05-17)](_posts/2021-05-17-results.md)