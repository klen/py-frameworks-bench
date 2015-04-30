from django.http import HttpResponse, JsonResponse
import requests

def hello(request):
    return HttpResponse('Hello, World!')


def json(request):
    return JsonResponse({'message': 'Hello, World!'})


def remote(request):
    response = requests.get('http://test')
    return HttpResponse(response.text)


from django.conf.urls import url

urlpatterns = [
    url('^hello', hello),
    url('^json',  json),
    url('^remote',  remote),
]
