import time
from uuid import uuid4

from hius import Hius
from hius.responses import HTMLResponse, JSONResponse, PlainTextResponse, Response


app = Hius()


# first add ten more routes to load routing system
# ------------------------------------------------
for n in range(5):
    app.add_route(f"/route-{n}", lambda r: HTMLResponse('ok'))
    app.add_route(f"/route-dyn-{n}/{{part}}", lambda r: HTMLResponse('ok'))


# then prepare endpoints for the benchmark
# ----------------------------------------
@app.route("/html")
async def html(request):
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return HTMLResponse(content, headers=headers)


@app.route("/upload", methods=['POST'])
async def upload(request):
    """Load multipart data and store it as a file."""
    formdata = await request.form()
    if 'file' not in formdata:
        return Response('ERROR', status_code=400)

    with open(f"/tmp/{uuid4().hex}", 'wb') as target:
        target.write(await formdata['file'].read())

    return PlainTextResponse(target.name)


@app.route('/api/users/{user:int}/records/{record:int}', methods=['PUT'])
async def api(request):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if request.headers.get('authorization') is None:
        return Response('ERROR', status_code=401)

    return JSONResponse({
        'params': request.path_params,
        'query': dict(request.query_params),
        'data': await request.json(),
    })
