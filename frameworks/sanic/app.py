import time
from uuid import uuid4

from sanic import Sanic
from sanic.response import html, json, text
from sanic.exceptions import Unauthorized, InvalidUsage


app = Sanic("benchmark")


@app.route('/html')
async def view_html(request):
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return html(content, headers=headers)


@app.route('/upload', methods=['POST'])
async def upload(request):
    """Load multipart data and store it as a file."""
    if 'file' not in request.files:
        raise InvalidUsage('ERROR')

    with open(f"/tmp/{uuid4().hex}", 'wb') as target:
        target.write(request.files['file'][0].body)
    return text(target.name)


@app.route('/api/users/<user:int>/records/<record:int>', methods=['PUT'])
async def api(request, user, record):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if request.headers.get('authorization') is None:
        raise Unauthorized('ERROR')
    return json({
        'params': {'user': user, 'record': record},
        'query': dict(request.query_args),
        'data': request.json
    })
