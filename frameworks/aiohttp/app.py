import time
from uuid import uuid4

from aiohttp.web import (
    RouteTableDef, Application, Response, json_response, HTTPBadRequest, HTTPUnauthorized)


routes = RouteTableDef()


@routes.get('/html')
async def html(request):
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return Response(text=content, content_type="text/html", headers=headers)


@routes.post('/upload')
async def upload(request):
    """Load multipart data and store it as a file."""
    reader = await request.multipart()
    data = await reader.next()
    if data.name != 'file':
        raise HTTPBadRequest()

    with open(f"/tmp/{uuid4().hex}", 'wb') as target:
        target.write(await data.read())

    return Response(text=target.name, content_type="text/plain")


@routes.put('/api/users/{user:\d+}/records/{record:\d+}')
async def api(request):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if not request.headers.get('authorization'):
        raise HTTPUnauthorized()

    return json_response({
        'params': {
            'user': int(request.match_info['user']),
            'record': int(request.match_info['record']),
        },
        'query': dict(request.query),
        'data': await request.json(),
    })


app = Application()
app.add_routes(routes)
