import asyncio
import json as JSON
import os

import aiohttp
import uvloop
from ..lib.async_utils import get_event_loop
from ..lib.async_http import get_async_http_session
from ..lib.db import get_async_pg_pool, perform_query
from ..lib.constants import HOST

loop = get_event_loop()
from sanic import Sanic, response
from sanic.response import json

app = Sanic()

@app.route("/json")
async def json_request(request):
    return json({"message": "Hello, World!"})

@app.route("/remote")
async def remote(request):
    response = await app.session.request('GET', 'http://%s' % HOST) # noqa
    text = await response.text()
    return response.text(text)

@app.route("/complete")
async def complete(request):
    resp = await perform_query(app.db)
    return json(resp)

app.session = get_async_http_session()

async def setup():
    app.db = await get_async_pg_pool()

app.add_task(setup)
