import asyncio
import os
import aiohttp
import uvloop
from ..lib.async import get_event_loop
from ..lib.http import get_http_session_async
from ..lib.db import get_pg_pool_async, perform_query_async
from ..lib.constants import HOST
from sanic import Sanic, response
from sanic.response import json

loop = get_event_loop()
app = Sanic()


@app.route("/json")
async def json_request(request):
    return json({"message": "Hello, World!"})


@app.route("/remote")
async def remote(request):
    response = await app.session.request('GET', 'http://%s' % HOST)
    text = await response.text()
    return response.text(text)


@app.route("/complete")
async def complete(request):
    resp = await perform_query_async(app.db)
    return json(resp)


async def setup():
    app.db = await get_pg_pool_async()
    app.session = get_http_session_async()

app.add_task(setup)
