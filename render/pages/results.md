---
layout: post
title: Results ({{ now.strftime('%Y-%m-%d') }})
description: Python Frameworks Benchmark Results ({{ now.strftime('%Y-%m-%d') }})
date:   ({{ now.strftime('%Y-%m-%d') }})
categories: results
---

<script src="https://cdn.jsdelivr.net/npm/chart.js@3.2.1/dist/chart.min.js"></script>

> This is a simple benchmark for python async frameworks. Almost all of the
> frameworks are ASGI-compatible (aiohttp and tornado are exceptions on the
> moment). 
> 
> The objective of the benchmark is not testing deployment (like uvicorn vs
> hypercorn and etc) or database (ORM, drivers) but instead test the frameworks
> itself. The benchmark checks request parsing (body, headers, formdata,
> queries), routing, responses.

Read more about the benchmark: [The Methodic](/py-frameworks-bench/about/)

# Table of contents

* [Accept a request and return HTML response with a custom dynamic header](#html)
* [Parse path params, query string, JSON body and return a json response](#api)
* [Parse uploaded file, store it on disk and return a text response](#upload)
* [Composite stats ](#composite)

<canvas id="chart" style="margin-bottom: 2em"></canvas>
<script>
    var ctx = document.getElementById('chart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [{% for res in results %}'{{res.name}}',{% endfor %}],
            datasets: [
                {
                    label: 'Single HTML response (req/s)',
                    data: [{% for res in results_html %}'{{res.req}}',{% endfor %}],
                    backgroundColor: [
                        '#b9ddf1', '#afd6ed', '#a5cfe9', '#9bc7e4', '#92c0df', '#89b8da', '#80b0d5', '#79aacf', '#72a3c9', '#6a9bc3', '#6394be', '#5b8cb8', '#5485b2', '#4e7fac', '#4878a6', '#437a9f', '#3d6a98', '#376491', '#305d8a', '#2a5783',
                    ].reverse()
                },
                {
                    label: 'Work with JSON (req/s)',
                    data: [{% for res in results_api %}'{{res.req}}',{% endfor %}],
                    backgroundColor: [
                        '#b3e0a6', '#a5db96', '#98d687', '#8ed07f', '#85ca77', '#7dc370', '#75bc69', '#6eb663', '#67af5c', '#61a956', '#59a253', '#519c51', '#49964f', '#428f4d', '#398949', '#308344', '#2b7c40', '#27763d', '#256f3d', '#24693d',
                    ].reverse()
                },
                {
                    label: 'Upload file (req/s)',
                    data: [{% for res in results_upload %}'{{res.req}}',{% endfor %}],
                    backgroundColor: [
                        '#ffc685', '#fcbe75', '#f9b665', '#f7ae54', '#f5a645', '#f59c3c', '#f49234', '#f2882d', '#f07e27', '#ee7422', '#e96b20', '#e36420', '#db5e20', '#d25921', '#ca5422', '#c14f22', '#b84b23', '#af4623', '#a64122', '#9e3d22',
                    ].reverse()
                },
            ]
        }
    });
</script>

##  Accept a request and return HTML response with a custom dynamic header {{'{#html}'}}

The test simulates just a single HTML response. 

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
{% for res in results_html -%}
| [{{ res.name }}](https://pypi.org/project/{{ res.name }}/) `{{ versions[res.name] }}` | {{ res.req }} | {{ res.lt50 }} | {{ res.lt75 }} | {{ res.lt_avg }}
{% endfor %}

## Parse path params, query string, JSON body and return a json response  {{'{#api}'}}
The test simulates a simple JSON REST API endpoint.  

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
{% for res in results_api -%}
| [{{ res.name }}](https://pypi.org/project/{{ res.name }}/) `{{ versions[res.name] }}` | {{ res.req }} | {{ res.lt50 }} | {{ res.lt75 }} | {{ res.lt_avg }}
{% endfor %}

## Parse uploaded file, store it on disk and return a text response  {{'{#upload}'}}
The test simulates multipart formdata processing and work with files.  

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
{% for res in results_upload -%}
| [{{ res.name }}](https://pypi.org/project/{{ res.name }}/) `{{ versions[res.name] }}` | {{ res.req }} | {{ res.lt50 }} | {{ res.lt75 }} | {{ res.lt_avg }}
{% endfor %}

## Composite stats {{'{#composite}'}}
Combined benchmarks results

Sorted by completed requests

| Framework | Requests completed | Avg Latency 50% (ms) | Avg Latency 75% (ms) | Avg Latency (ms) |
| --------- | -----------------: | -------------------: | -------------------: | ---------------: |
{% for res in results -%}
| [{{ res.name }}](https://pypi.org/project/{{ res.name }}/) `{{ versions[res.name] }}` | {{ res.req }} | {{ res.lt50|round(2) }} | {{ res.lt75|round(2) }} | {{ res.lt_avg|round(2) }}
{% endfor %}
