import time
from uuid import uuid4

from falcon.asgi import App
from json import dumps


class html:
    """Return HTML content and a custom header."""

    async def on_get(self, request, response):
        response.text = "<b>HTML OK</b>"
        response.set_header('x-time', f"{time.time()}")
        response.content_type = 'text/html'


class upload:
    """Load multipart data and store it as a file."""

    async def on_post(self, request, response):
        formdata = await request.get_media()
        async for part in formdata:
            if part.name == 'file':
                with open(f"/tmp/{uuid4().hex}", 'wb') as target:
                    target.write(await part.get_data())

                response.text = target.name
                response.content_type = 'text/plain'
                break
        else:
            response.status = 400


class api:
    """Check headers for authorization, load JSON/query data and return as JSON."""

    async def on_put(self, request, response, user, record):
        if request.headers.get('authorization') is None:
            response.status = 401

        else:
            response.text = dumps({
                'params': {'user': user, 'record': record},
                'query': request.params,
                'data': await request.get_media(),
            }, ensure_ascii=False, separators=(',', ':'))


app = App()
app.add_route('/html', html())
app.add_route('/upload', upload())
app.add_route('/api/users/{user:int}/records/{record:int}', api())
