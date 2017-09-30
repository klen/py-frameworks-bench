import asyncio
import json as JSON
import os

import aiohttp
from aiohttp import web
from ..lib.async import get_event_loop
from ..lib.http import get_http_session_async
from ..lib.db import get_pg_pool_async, perform_query_async
from ..lib.serializers import json
from ..lib.constants import HOST


async def json_req(request):
    return web.Response(
        text=JSON.dumps({'message': 'Hello, World!'}), content_type='application/json')


async def remote(request):
    response = await request.app["session"].request('GET', 'http://%s' % HOST) # noqa
    text = await response.text()
    return web.Response(text=text, content_type='text/html')


async def complete(request):
    resp = await perform_query_async(request.app["db"])
    return web.Response(
        text=JSON.dumps(resp)
    )

async def on_startup(app):
    app["session"] = get_http_session_async()
    app["db"] = await get_pg_pool_async()

app = web.Application()
app.router.add_route('GET', '/json', json_req)
app.router.add_route('GET', '/remote', remote)
app.router.add_route('GET', '/complete', complete)
app.on_startup.append(on_startup)

loop = get_event_loop()
