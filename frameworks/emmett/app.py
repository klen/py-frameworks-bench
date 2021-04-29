import time

from uuid import uuid4

from emmett import App, request, response
from emmett.tools import service

app = App(__name__)
app.config.handle_static = False


@app.route(methods=["get"], output="str")
async def html():
    """Return HTML content and a custom header."""
    response.headers["x-time"] = f"{time.time()}"
    response.content_type = "text/html"
    return "<b>HTML OK</b>"


@app.route(methods=["post"], output="str")
async def upload():
    """Load multipart data and store it as a file."""
    data = (await request.files).file
    if not data:
        response.status = 400
        return ""

    target = f"/tmp/{uuid4().hex}"
    await data.save(target)
    return target


@app.route("/api/users/<int:user>/records/<int:record>", methods=["put"])
@service.json
async def api(user, record):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if not request.headers.get("authorization"):
        response.status = 401
        return {}

    return {
        "params": {"user": user, "record": record},
        "query": request.query_params,
        "data": await request.body_params
    }
