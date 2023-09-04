import sys
import time
from uuid import uuid4

from panther import Panther
from panther.app import API
from panther.exceptions import MethodNotAllowed
from panther.request import Request
from panther.response import HTMLResponse, Response, PlainTextResponse


URLs = 'main.url_routing'

# First add ten routes to load routing system
# ------------------------------------------------
async def req_ok():
    return HTMLResponse('ok')


async def req_ok_dyn(part):
    return HTMLResponse('ok')


first_url_routing = dict()
for n in range(5):
    first_url_routing[f'/route-{n}'] = req_ok
    first_url_routing[f'/route-dyn-{n}/<part>'] = req_ok_dyn


# Then prepare endpoints for the benchmark
# ----------------------------------------
@API()
async def html():
    """Return HTML content and a custom header."""
    content = '<b>HTML OK</b>'
    headers = {'x-time': f'{time.time()}'}
    return HTMLResponse(content, headers=headers)


@API()
async def upload(request: Request):
    """Load multipart data and store it as a file."""
    if request.method != 'POST':
        return MethodNotAllowed

    if 'file' not in request.pure_data:
        return Response('ERROR', status_code=400)

    with open(f'/tmp/{uuid4().hex}', 'wb') as target:
        target.write(request.pure_data['file'].file)

    return PlainTextResponse(target.name)


@API()
async def api(request: Request, user: int, record: int):
    if request.method != 'PUT':
        raise MethodNotAllowed

    """Check headers for authorization, load JSON/query data and return as JSON."""
    if request.headers.authorization is None:
        return Response('ERROR', status_code=401)

    return Response({
        'params': {'user': user, 'record': record},
        'query': request.query_params,
        'data': request.pure_data,
    })


second_url_routing = {
    'html': html,
    'upload': upload,
    'api/users/<user>/records/<record>': api,
}

url_routing = first_url_routing | second_url_routing


app = Panther(__name__, configs=sys.modules[__name__])
