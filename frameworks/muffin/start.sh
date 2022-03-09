#!/bin/sh

gunicorn -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8080 app:app
