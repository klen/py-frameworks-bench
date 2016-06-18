import asyncio
import json as JSON
import os

import aiohttp_jinja2
import aiohttp
import jinja2
import peewee
import peewee_async


HOST = os.environ.get('DHOST', '127.0.0.1')

database = peewee_async.PooledPostgresqlDatabase(
    'benchmark', max_connections=10, user='benchmark', password='benchmark', host=HOST)


class Message(peewee.Model):
    content = peewee.CharField(max_length=512)

    class Meta:
        database = database


@asyncio.coroutine
def json(request):
    return aiohttp.web.Response(
        text=JSON.dumps({'message': 'Hello, World!'}), content_type='application/json')


@asyncio.coroutine
def remote(request):
    response = yield from aiohttp.request('GET', 'http://%s' % HOST) # noqa
    text = yield from response.text()
    return aiohttp.web.Response(text=text, content_type='text/html')


@asyncio.coroutine
def complete(request):
    messages = yield from peewee_async.execute(
        Message.select().order_by(peewee.fn.Random()).limit(100))
    messages = list(messages)
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    return aiohttp_jinja2.render_template('template.html', request, {
        'messages': messages
    })


app = aiohttp.web.Application()
app.router.add_route('GET', '/json', json)
app.router.add_route('GET', '/remote', remote)
app.router.add_route('GET', '/complete', complete)

aiohttp_jinja2.setup(
    app, loader=jinja2.FileSystemLoader(os.path.dirname(os.path.abspath(__file__))))
loop = asyncio.get_event_loop()
loop.run_until_complete(database.connect_async(loop=loop))
