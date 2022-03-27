import time
from typing import Any, Dict, List
from uuid import uuid4

from pydantic import BaseModel
from xpresso import (
    App,
    FromHeader,
    FromJson,
    FromMultipart,
    FromPath,
    FromQuery,
    Operation,
    Path,
    FromFormFile,
    UploadFile,
)
from xpresso.responses import HTMLResponse, PlainTextResponse


routes: List[Path] = []


# first add ten more routes to load routing system
# ------------------------------------------------
async def req_ok() -> HTMLResponse:
    return HTMLResponse("ok")


async def req_ok_dyn(part: FromPath[str]) -> HTMLResponse:
    return HTMLResponse("ok")


for n in range(5):
    routes.append(Path(f"/route-{n}", get=req_ok))
    routes.append(Path(f"/route-dyn-{n}", get=req_ok_dyn))


# then prepare endpoints for the benchmark
# ----------------------------------------
async def html() -> HTMLResponse:
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {"x-time": f"{time.time()}"}
    return HTMLResponse(content, headers=headers)


routes.append(Path("/html", get=Operation(html, response_media_type="text/html")))


class MultiPartForm(BaseModel):
    file: FromFormFile[UploadFile]


async def upload(form: FromMultipart[MultiPartForm]) -> PlainTextResponse:
    """Load multipart data and store it as a file."""
    with open(f"/tmp/{uuid4().hex}", "wb") as target:
        target.write(await form.file.read())

    return PlainTextResponse(target.name)


routes.append(Path("/upload", post=Operation(upload, response_media_type="text/plain")))


class Params(BaseModel):
    user: FromPath[int]
    record: FromPath[str]


class APIModel(BaseModel):
    params: Params
    query: FromQuery[Dict[str, Any]]
    data: FromJson[Dict[str, Any]]


async def api(
    authorization: FromHeader[str],
    data: APIModel,
) -> APIModel:
    """Check headers for authorization, load JSON/query data and return as JSON."""
    return data


routes.append(
    Path(
        "/api/users/{user}/records/{record}",
        put=api,
    )
)


app = App(routes=routes)
