import time
from uuid import uuid4

from django.urls import path
from django.http import HttpResponse, JsonResponse, HttpResponseNotAllowed, HttpResponseBadRequest
import json


async def html(request):
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {'x-time': f"{time.time()}"}
    return HttpResponse(content, headers=headers)


async def upload(request):
    """Load multipart data and store it as a file."""
    # 2021-04-18 Django 3.2 django.views.decorators.http.require_http_methods hasn't async support
    if request.method != 'POST':
        return HttpResponseNotAllowed(['POST'])

    formdata = request.FILES
    if 'file' not in formdata:
        return HttpResponseBadRequest('ERROR')

    with open(f"/tmp/{uuid4().hex}", 'wb') as target:
        target.write(formdata['file'].read())

    return HttpResponse(target.name, content_type="text/plain")


async def api(request, user, record):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if request.method != 'PUT':
        return HttpResponseNotAllowed(['PUT'])

    if not request.headers.get('authorization'):
        return HttpResponse('ERROR', status=401)

    data = json.loads(request.body.decode())
    return JsonResponse({
        'params': {'user': user, 'record': record},
        'query': dict(request.GET),
        'data': data,
    })


urlpatterns = [
    path('html',  html),
    path('upload',  upload),
    path('api/users/<int:user>/records/<int:record>',  api),
]


# More load for routing system
# ----------------------------
async def req_ok(*args, **kwargs):
    return HttpResponse('ok')


for n in range(5):
    urlpatterns.insert(0, path(f"route-{n}", req_ok))
    urlpatterns.insert(0, path(f"route-dyn-{n}/<part>", req_ok))
