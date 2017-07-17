import asyncio
import json as JSON
import os

import aiohttp
from aiohttp import web
from ..lib.async_utils import get_event_loop
from ..lib.async_http import get_async_http_session
from ..lib.db import get_async_pg_pool, perform_query
from ..lib.constants import HOST


async def json(request):
    return web.Response(
        text=JSON.dumps({'message': 'Hello, World!'}), content_type='application/json')


async def remote(request):
    response = await request.app["session"].request('GET', 'http://%s' % HOST) # noqa
    text = await response.text()
    return web.Response(text=text, content_type='text/html')


async def complete(request):
    resp = await perform_query(request.app["db"])
    return web.Response(
        text=JSON.dumps(resp)
    )

async def on_startup(app):
    app["session"] = get_async_http_session()
    app["db"] = await get_async_pg_pool()

app = web.Application()
app.router.add_route('GET', '/json', json)
app.router.add_route('GET', '/remote', remote)
app.router.add_route('GET', '/complete', complete)
app.on_startup.append(on_startup)

loop = get_event_loop()
