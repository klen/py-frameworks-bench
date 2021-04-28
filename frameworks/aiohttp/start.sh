#!/bin/sh

/usr/local/bin/gunicorn -k aiohttp.GunicornWebWorker -b 0.0.0.0:8080 app:app
