import pathlib
import random
from importlib import import_module

import pytest
from aiohttp.test_utils import TestClient, TestServer


@pytest.fixture(scope='module')
def app():
    return import_module('.aiohttp.app', package='frameworks').app


@pytest.fixture(scope='module')
async def aiohttp_client(app):
    server = TestServer(app)
    client = TestClient(server)
    await client.start_server()
    yield client
    await client.close()


async def test_html(aiohttp_client, ts):
    res = await aiohttp_client.get('/html')
    assert res.status == 200
    assert res.headers.get('content-type').startswith('text/html')
    header = res.headers.get('x-time')
    assert header
    assert float(header) >= ts
    text = await res.text()
    assert text == '<b>HTML OK</b>'


async def test_upload(aiohttp_client):
    res = await aiohttp_client.get("/upload")
    assert res.status == 405

    res = await aiohttp_client.post("/upload")
    assert res.status == 400

    res = await aiohttp_client.post("/upload", data={'file': open(__file__)})
    assert res.status == 200
    assert res.content_type.startswith('text/plain')
    text = await res.text()
    assert pathlib.Path(text).read_text('utf-8').startswith('import pathlib')


async def test_api(aiohttp_client):
    rand = random.randint(10, 99)

    url = f"/api/users/{rand}/records/{rand}?query=test"
    res = await aiohttp_client.get(url)
    assert res.status == 405

    res = await aiohttp_client.put(url, json={'foo': 'bar'})
    assert res.status == 401

    res = await aiohttp_client.put(url, headers={'authorization': '1'}, json={'foo': 'bar'})
    assert res.status == 200
    assert res.headers.get('content-type') == 'application/json; charset=utf-8'
    json = await res.json()
    assert json['data']
    assert json['data'] == {'foo': 'bar'}

    assert json['query']
    assert json['query']['query'] == 'test'

    assert json['params'] == {'user': rand, 'record': rand}


async def test_routing(aiohttp_client):
    rand = random.randint(10, 99)
    for n in range(5):
        res = await aiohttp_client.get(f"/route-{n}")
        assert res.status == 200

        res = await aiohttp_client.get(f"/route-dyn-{n}/{rand}")
        assert res.status == 200
