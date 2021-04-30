import time
from uuid import uuid4

from blacksheep import Application
from blacksheep.server.responses import html, json, bad_request, text, unauthorized


app = Application()


# first add ten more routes to load routing system
# ------------------------------------------------
def req_ok(request):
    return html('ok')


for n in range(5):
    app.route(f"/route-{n}")(req_ok)
    app.route(f"/route-dyn-{n}/<part>")(req_ok)


# then prepare endpoints for the benchmark
# ----------------------------------------
@app.route('/html')
async def view_html(request):
    """Return HTML content and a custom header."""
    response = html("<b>HTML OK</b>")
    response.add_header(b'x-time', f"{time.time()}".encode())
    return response


@app.route('/upload', methods=['POST'])
async def view_upload(request):
    """Load multipart data and store it as a file."""
    formdata = await request.form()
    if formdata is None or 'file' not in formdata:
        return bad_request()

    with open(f"/tmp/{uuid4().hex}", 'w') as target:
        target.write(formdata['file'])

    return text(target.name)


@app.route('/api/users/{int:user}/records/{int:record}', methods=['PUT'])
async def view_api(request):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if not request.headers.get(b'authorization'):
        return unauthorized()

    return json({
        'params': {k: int(v) for k, v in request.route_values.items()},
        'query': dict(request.query),
        'data': await request.json(),
    })
