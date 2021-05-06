---
layout: page
title: The Methodic
description: Python frameworks benchmark's methodic
permalink: /about/
---

## Hardware

The benchmark runs as a [Github Action](https://github.com/features/actions).
According to the [github
documentation](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
the hardware specification for the runs is:

* 2-core vCPU (Intel® Xeon® Platinum 8272CL (Cascade Lake), Intel® Xeon® 8171M 2.1GHz (Skylake))
* 7 GB of RAM memory
* 14 GB of SSD disk space
* OS Ubuntu 20.04

## Software

[ASGI](https://asgi.readthedocs.io/en/latest/) apps are running from docker using the gunicorn/uvicorn command:

    gunicorn -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8080 app:app

Results received with WRK utility using the params:

    wrk -d15s -t4 -c64 [URL]

The benchmark has a three kind of tests:

## Scenarios

1. "Simple" test: accept a request and return HTML response with custom dynamic
   header. The test simulates just a single HTML response.

2. "Upload" test: accept an uploaded file and store it on disk. The test
   simulates multipart formdata processing and work with files.

3. "API" test: Check headers, parse path params, query string, JSON body and return a json
   response. The test simulates an JSON REST API.

## Source code

* The benchmark's source code is parked on [Github](https://github.com/klen/py-frameworks-bench)
* Applications' source code can be found
  [here](https://github.com/klen/py-frameworks-bench/tree/develop/frameworks).

## Frameworks

* [AIOHTTP](https://github.com/aio-libs/aiohttp) -- Async http client/server
  framework
* [Blacksheep](https://github.com/Neoteroi/BlackSheep) -- is an asynchronous
  web framework to build event based web applications with Python
* [Django](https://www.djangoproject.com) -- is a high-level Python Web
  framework that encourages rapid development and clean, pragmatic design.
* [Emmet](https://emmett.sh/) -- is a full-stack Python web framework designed
  with simplicity in mind.
* [Falcon](https://falconframework.org/) -- is a blazing fast, minimalist
  Python web API framework for building robust app backends and microservices. 
* [FastAPI](https://github.com/tiangolo/fastapi) -- is a modern, fast
  (high-performance), web framework for building APIs with Python 3.6+ based on
  standard Python type hints.
* [Muffin](https://github.com/klen/muffin) -- is a fast, lightweight and
  asyncronous ASGI web-framework for Python 3.
* [Quart](https://gitlab.com/pgjones/quart/) --  is an async Python web
  microframework
* [Sanic](https://pypi.org/project/sanic/) -- is a Python 3.7+ web server and
  web framework that’s written to go fast
* [Starlette](https://github.com/encode/starlette) -- is a lightweight ASGI
  framework/toolkit, which is ideal for building high performance asyncio
  services.
* [Tornado](https://www.tornadoweb.org/en/stable/) -- is a Python web framework
  and asynchronous networking library, originally developed at FriendFeed
