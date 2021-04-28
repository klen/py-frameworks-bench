---
layout: post
title: Results ({{ now.strftime('%Y-%m-%d') }})
date:   ({{ now.strftime('%Y-%m-%d') }})
categories: results
---

# Table of contents

* [Accept a request and return HTML response with a custom dynamic header](#html)
* [Parse uploaded file, store it on disk and return a text response](#upload)
* [Parse path params, query string, JSON body and return a json response](#api)
* [Composite stats ](#composite)

##  Accept a request and return HTML response with a custom dynamic header {{'{#html}'}}

The test simulates just a single HTML response. 

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
{% for res in results_html -%}
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

## Parse path params, query string, JSON body and return a json response  {{'{#api}'}}
The test simulates a simple JSON REST API endpoint.  

Sorted by max req/s

| Framework | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | ---------------: | ---------------: | ---------------: |
{% for res in results_api -%}
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
