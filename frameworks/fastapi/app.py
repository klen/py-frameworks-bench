import time
from uuid import uuid4
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, JSONResponse, PlainTextResponse, Response


app = FastAPI()


# first add ten more routes to load routing system
# ------------------------------------------------
async def req_ok():
    return HTMLResponse('ok')


async def req_ok_dyn(part):
    return HTMLResponse('ok')


for n in range(5):
    app.get(f"/route-{n}")(req_ok)
    app.get(f"/route-dyn-{n}/{{part}}")(req_ok_dyn)


# then prepare endpoints for the benchmark
# ----------------------------------------
@app.get('/html')
async def html():
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return HTMLResponse(content, headers=headers)


@app.post('/upload')
async def upload(request: Request):
    """Load multipart data and store it as a file."""
    formdata = await request.form()
    if 'file' not in formdata:
        return Response('ERROR', status_code=400)

    with open(f"/tmp/{uuid4().hex}", 'wb') as target:
        target.write(await formdata['file'].read())

    return PlainTextResponse(target.name)


@app.put('/api/users/{user}/records/{record}')
async def api(request: Request, user: int, record: int):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if request.headers.get('authorization') is None:
        return Response('ERROR', status_code=401)

    return JSONResponse({
        'params': {'user': user, 'record': record},
        'query': dict(request.query_params),
        'data': await request.json(),
    })
