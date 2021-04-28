import time

import pytest


@pytest.fixture(scope='session')
def aiolib():
    return ('asyncio', {'use_uvloop': False})


@pytest.fixture
def ts():
    return time.time()


@pytest.fixture
async def client(asgi):
    from asgi_tools.tests import ASGITestClient

    client = ASGITestClient(asgi)
    async with client.lifespan():
        yield client
