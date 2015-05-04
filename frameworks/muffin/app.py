import muffin
import os
import aiohttp
import peewee

app = muffin.Application(
    'web',

    PLUGINS=('muffin_peewee', 'muffin_jinja2'),

    JINJA2_TEMPLATE_FOLDERS=os.path.dirname(os.path.abspath(__file__)),

    PEEWEE_CONNECTION='postgres+pool://benchmark:benchmark@localhost:5432/benchmark',
    PEEWEE_CONNECTION_MANUAL=True,
    PEEWEE_CONNECTION_PARAMS={'encoding': 'utf-8', 'max_connections': 10},

)


@app.ps.peewee.register
class Message(peewee.Model):
    content = peewee.CharField(max_length=512)


@app.register('/json')
def json(request):
    return {
        'message': 'Hello, World!'
    }


@app.register('/remote')
def remote(request):
    response = yield from aiohttp.request('GET', 'http://test') # noqa
    return response.text()


@app.register('/complete')
def message(request):
    with app.ps.peewee.manage():
        messages = list(Message.select())
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    return app.ps.jinja2.render('template.html', messages=messages)
