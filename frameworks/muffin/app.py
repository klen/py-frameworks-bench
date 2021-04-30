import time
from pathlib import Path
from uuid import uuid4

from muffin import Application, ResponseHTML, ResponseText, ResponseError


upload_dir = Path(__file__).parent.parent
app = Application(debug=True)


# first add ten more routes to load routing system
# ------------------------------------------------
async def req_ok(request):
    return 'ok'


for n in range(5):
    app.route(f"/route-{n}", f"/route-dyn-{n}/{{part}}")(req_ok)


# then prepare endpoints for the benchmark
# ----------------------------------------
@app.route('/html')
async def html(request):
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return ResponseHTML(content, headers=headers)


@app.route('/upload', methods=['POST'])
async def upload(request):
    """Load multipart data and store it as a file."""
    formdata = await request.form(upload_to=lambda f: f"/tmp/{uuid4().hex}")
    if 'file' not in formdata:
        raise ResponseError.BAD_REQUEST()

    return ResponseText(formdata['file'].name)


@app.route('/api/users/{user:int}/records/{record:int}', methods=['PUT'])
async def api(request):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if not request.headers.get('authorization'):
        raise ResponseError.UNAUTHORIZED()

    return {
        'params': request.path_params,
        'query': dict(request.url.query),
        'data': await request.json(),
    }
