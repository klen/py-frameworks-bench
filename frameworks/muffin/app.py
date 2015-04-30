import muffin
import aiohttp

app = muffin.Application('web')


@app.register('/hello')
def home(request):
    return 'Hello, World!'


@app.register('/json')
def json(request):
    return {
        'message': 'Hello, World!'
    }


@app.register('/remote')
def remote(request):
    response = yield from aiohttp.request('GET', 'http://test')
    return response.text()
