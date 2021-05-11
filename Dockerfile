from python:3.9-slim

RUN apt-get update && \
    apt-get -y install --no-install-recommends build-essential

RUN /usr/local/bin/pip install --no-cache-dir \
    wheel \
    gunicorn \
    orjson \
    ujson \
    uvicorn[standard]

ONBUILD COPY requirements.txt /app/requirements.txt
ONBUILD RUN /usr/local/bin/pip install --no-cache-dir -r requirements.txt
ONBUILD COPY . /app

EXPOSE 8080
WORKDIR /app
