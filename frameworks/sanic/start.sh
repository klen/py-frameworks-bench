#!/bin/sh

# the fastest way
sanic --host 0.0.0.0 --port=8080 --workers=1 app:app

# /usr/local/bin/gunicorn -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8080 app:app
# /usr/local/bin/gunicorn -k sanic.worker.GunicornWorker -b 0.0.0.0:8080 app:app
