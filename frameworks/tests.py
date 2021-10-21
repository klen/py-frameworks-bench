import pathlib
import random
from importlib import import_module

import pytest


@pytest.fixture(scope='session', params=[
    'quart',  # has to be first
    #  'aiohttp',  # doesnt support ASGI
    'baize',
    'blacksheep',
    'django',
    'emmett',
    'falcon',
    'fastapi',
    'muffin',
    'sanic',
    'starlette',
])
def asgi(request):
    mod = import_module(f".{request.param}.app", package=__package__)
    return mod.app


async def test_html(client, ts):
    res = await client.get('/html')
    assert res.status_code == 200
    assert res.headers.get('content-type').startswith('text/html')
    header = res.headers.get('x-time')
    assert header
    assert float(header) >= ts

    text = await res.text()
    assert text == '<b>HTML OK</b>'


async def test_upload(client):
    res = await client.get("/upload")
    assert res.status_code in {404, 405}  # blacksheep returns 404 for "method not allowed"

    res = await client.post("/upload")
    assert res.status_code in {400, 415}  # baize returns 415 for empty content-type

    res = await client.post("/upload", data={'file': open(__file__)})
    assert res.status_code == 200
    assert res.content_type.startswith('text/plain')
    text = await res.text()
    assert pathlib.Path(text).read_text('utf-8').startswith('import pathlib')


async def test_api(client):
    rand = random.randint(10, 99)

    url = f"/api/users/{rand}/records/{rand}"
    res = await client.get(url)
    assert res.status_code in {404, 405}  # blacksheep returns 404 for "method not allowed"

    res = await client.put(url, query={'query': 'test'}, json={'foo': 'bar'})
    assert res.status_code == 401

    res = await client.put(
            url, query={'query': 'test'}, headers={'authorization': '1'}, json={'foo': 'bar'})
    assert res.status_code == 200
    assert res.headers.get('content-type') == 'application/json'
    json = await res.json()
    assert json['data']
    assert json['data'] == {'foo': 'bar'}

    assert json['query']
    assert get_single(json['query']['query']) == 'test'

    assert json['params'] == {'user': rand, 'record': rand}


async def test_routing(client):
    rand = random.randint(10, 99)
    for n in range(5):
        res = await client.get(f"/route-{n}")
        assert res.status_code == 200

        res = await client.get(f"/route-dyn-{n}/{rand}")
        assert res.status_code == 200


# Utils
# -----

def get_single(value):
    if isinstance(value, list):
        value, = value

    return value
