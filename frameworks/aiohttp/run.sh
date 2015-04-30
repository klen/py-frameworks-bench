#!/bin/sh

$VIRTUAL_ENV/bin/gunicorn app:app -k aiohttp.worker.GunicornWebWorker --workers=2 --bind=0.0.0.0:5000 --pid=pid
