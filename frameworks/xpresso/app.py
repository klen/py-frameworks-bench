import time
from typing import List
from uuid import uuid4
from pydantic import BaseModel
from xpresso import App, FromHeader, FromMultipart, FromPath, Request, Path, FromFormFile, UploadFile, Depends
from starlette.routing import BaseRoute
from starlette.responses import HTMLResponse, JSONResponse, PlainTextResponse, Response


routes: List[BaseRoute] = []


# first add ten more routes to load routing system
# ------------------------------------------------
async def req_ok() -> HTMLResponse:
    return HTMLResponse('ok')


async def req_ok_dyn(part: FromPath[str]) -> HTMLResponse:
    return HTMLResponse('ok')


for n in range(5):
    routes.append(Path(f"/route-{n}", get=req_ok))
    routes.append(Path(f"/route-dyn-{n}", get=req_ok_dyn))


# then prepare endpoints for the benchmark
# ----------------------------------------
async def html() -> HTMLResponse:
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return HTMLResponse(content, headers=headers)


routes.append(Path("/html", get=html))


class MultiPartForm(BaseModel):
    file: FromFormFile[UploadFile]


async def upload(form: FromMultipart[MultiPartForm]) -> Response:
    """Load multipart data and store it as a file."""
    with open(f"/tmp/{uuid4().hex}", 'wb') as target:
        target.write(await form.file.read())

    return PlainTextResponse(target.name)


routes.append(Path("/upload", post=upload))


def check_auth_header(authorization: FromHeader[str]) -> None:
    ...


async def api(request: Request, user: FromPath[int], record: FromPath[str]):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if request.headers.get('authorization') is None:
        return Response('ERROR', status_code=401)

    return JSONResponse({
        'params': {'user': user, 'record': record},
        'query': dict(request.query_params),
        'data': await request.json(),
    })


routes.append(Path("/api/users/{user}/records/{record}", put=api, dependencies=[Depends(check_auth_header)]))


app = App(routes=routes)
