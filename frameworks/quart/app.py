import time
from uuid import uuid4

from quart import Quart, Response, request


app = Quart(__name__)


# first add ten more routes to load routing system
# ------------------------------------------------
async def req_ok(*args, **kwargs):
    return Response('OK')


for n in range(5):
    app.route(f"/route-{n}")(req_ok)
    app.route(f"/route-dyn-{n}/<part>")(req_ok)


# then prepare endpoints for the benchmark
# ----------------------------------------
@app.route('/html')
async def hello():
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return Response(content, content_type="text/html", headers=headers)


@app.route('/upload', methods=['POST'])
async def upload():
    """Load multipart data and store it as a file."""
    formdata = await request.files
    if 'file' not in formdata:
        return Response('ERROR', status=400)

    with open(f"/tmp/{uuid4().hex}", 'wb') as target:
        target.write(formdata['file'].read())

    return Response(target.name, content_type='text/plain')


@app.route('/api/users/<int:user>/records/<int:record>', methods=['PUT'])
async def api(user, record):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    authorization = request.headers.get('authorization')
    if authorization is None:
        return Response('ERROR', status=401)

    return {
        'params': {'user': user, 'record': record},
        'query': dict(request.args),
        'data': await request.json
    }
