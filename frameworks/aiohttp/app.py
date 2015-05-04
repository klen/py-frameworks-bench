import asyncio
import os
import peewee
import aiohttp_jinja2
import jinja2
import peewee_async
import json as JSON
from aiohttp import web, request as arequest


database = peewee_async.PostgresqlDatabase('benchmark', user='benchmark', password='benchmark')


class Message(peewee.Model):
    content = peewee.CharField(max_length=512)

    class Meta:
        database = database


@asyncio.coroutine
def json(request):
    return web.Response(
        text=JSON.dumps({'message': 'Hello, World!'}), content_type='application/json')


@asyncio.coroutine
def remote(request):
    response = yield from arequest('GET', 'http://test') # noqa
    text = yield from response.text()
    return web.Response(text=text, content_type='text/html')


@asyncio.coroutine
def complete(request):
    messages = yield from peewee_async.execute(Message.select())
    messages = list(messages)
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    return aiohttp_jinja2.render_template('template.html', request, {
        'messages': messages
    })


app = web.Application()
app.router.add_route('GET', '/json', json)
app.router.add_route('GET', '/remote', remote)
app.router.add_route('GET', '/complete', complete)

aiohttp_jinja2.setup(
    app, loader=jinja2.FileSystemLoader(os.path.dirname(os.path.abspath(__file__))))
loop = asyncio.get_event_loop()
loop.run_until_complete(database.connect_async(loop=loop))
