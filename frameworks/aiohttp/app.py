import asyncio
import json as JSON
from aiohttp import web, request as arequest


@asyncio.coroutine
def hello(request):
    return web.Response(text="Hello, World!")


@asyncio.coroutine
def json(request):
    return web.Response(text=JSON.dumps({"message": "Hello, World!"}), content_type="application/json")


@asyncio.coroutine
def remote(request):
    response = yield from arequest("GET", "http://test")
    text = yield from response.text()
    return web.Response(text=text, content_type="text/html")


app = web.Application()
app.router.add_route('GET', '/hello', hello)
app.router.add_route('GET', '/json', json)
app.router.add_route('GET', '/remote', remote)
