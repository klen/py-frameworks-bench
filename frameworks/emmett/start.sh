#!/bin/sh

/usr/local/bin/gunicorn -k emmett.asgi.workers.EmmettWorker -b 0.0.0.0:8080 app:app
