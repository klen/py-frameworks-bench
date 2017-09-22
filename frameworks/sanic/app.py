import aiohttp
import jinja2
import os
import peewee
import peewee_async
from sanic import Sanic
from sanic.response import text, json, html
from sanic_jinja2 import SanicJinja2

app = Sanic()
jinja = SanicJinja2(app, loader=jinja2.FileSystemLoader(
    os.path.dirname(os.path.abspath(__file__))))


HOST = os.environ.get('DHOST', '127.0.0.1')

database = peewee_async.PooledPostgresqlDatabase(
    'benchmark', host=HOST, max_connections=10,
    user='benchmark', password='benchmark')


class Message(peewee.Model):
    content = peewee.CharField(max_length=512)

    class Meta:
        database = database


@app.route("/json")
async def json_endpoint(request):
    return json({'message': 'Hello, World!'})


async def get_url(session, url):
    async with session.get(url) as response:
        return await response.text()


@app.route("/remote")
async def remote(request):
    async with aiohttp.ClientSession() as session:
        response_text = await get_url(session, 'http://%s' % HOST)
        return html(response_text)


@app.route("/complete")
async def complete(request):
    messages = await peewee_async.execute(
        Message.select().order_by(peewee.fn.Random()).limit(100))
    messages = list(messages)
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    return jinja.render('template.html', request, messages=messages)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=False)
