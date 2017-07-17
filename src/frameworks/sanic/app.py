import asyncio
import json as JSON
import os

import aiohttp
import uvloop
from jinja2 import Template
import peewee
import peewee_async

loop = uvloop.new_event_loop()
asyncio.set_event_loop(loop)

HOST = os.environ.get('DHOST', '127.0.0.1')

database = peewee_async.PooledPostgresqlDatabase(
  'benchmark', max_connections=1000, user='benchmark', password='benchmark', host=HOST)


objects = peewee_async.Manager(database)

class Message(peewee.Model):
    content = peewee.CharField(max_length=512)

    class Meta:
        database = database

from sanic import Sanic, response
from sanic.response import json

app = Sanic()

@app.route("/json")
async def json_request(request):
    return json({"message": "Hello, World!"})

@app.route("/remote")
async def remote(request):
    resp = await aiohttp.request('GET', 'http://%s' % HOST) # noqa
    text = await resp.text()
    return response.text(text)

with open(os.path.join(os.path.dirname(__file__), "template.html")) as fh:
    template = Template(fh.read())

@app.route("/complete")
async def complete(request):
    messages = await objects.execute(Message.select().order_by(peewee.fn.Random()).limit(100))
    messages = list(messages)
    messages.append(Message(content='Hello, World!'))
    content = [{"id": m.id, "content": m.content} for m in messages]
    return json(content)


loop.run_until_complete(database.connect_async(loop=loop))
