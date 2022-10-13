import json
import time

from uuid import uuid4

from django.http import HttpResponse, JsonResponse
from django.views.generic import View
from django.urls import path


class HtmlView(View):
    """ Return HTML content and a custom header. """
    async def get(self, request):
        resp = HttpResponse('<b>HTML OK</b>')
        resp.headers['x-time'] = time.time()
        return resp


class UploadView(View):
    """ Load multipart data and store it as a file. """
    async def post(self, request):
        file = request.FILES.get('file')
        if not file:
            return HttpResponse('ERROR', status=400)
        
        with open(f"/tmp/{uuid4().hex}", 'wb') as target:
            target.write(file.read())

        return HttpResponse(target.name, content_type="text/plain")


class ApiView(View):
    """ Check headers for authorization, load JSON/query data and return as JSON. """
    async def put(self, request, **kwargs):
        if not request.headers.get('authorization'):
            return HttpResponse('ERROR', status=401)

        data = json.loads(request.body)
        return JsonResponse({
            'params': kwargs,
            'query': request.GET.dict(),
            'data': data,
        })


urlpatterns = [
    path('html',  HtmlView.as_view()),
    path('upload',  UploadView.as_view()),
    path('api/users/<int:user>/records/<int:record>',  ApiView.as_view()),
]


# More load for routing system
# ----------------------------
class ReqOk(View):
    async def get(self, request):
        return HttpResponse('ok')


for n in range(5):
    urlpatterns.insert(0, path(f"route-{n}", ReqOk.as_view()))
    urlpatterns.insert(0, path(f"route-dyn-{n}/<part>", ReqOk.as_view()))