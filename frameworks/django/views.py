from django.http import HttpResponse, JsonResponse
import requests
from django.db import models
from django.shortcuts import render


class Message(models.Model):
    content = models.CharField(max_length=512)

    class Meta:
        app_label = 'app'
        db_table = 'message'


def hello(request):
    return HttpResponse('Hello, World!')


def json(request):
    return JsonResponse({'message': 'Hello, World!'})


def remote(request):
    response = requests.get('http://test')
    return HttpResponse(response.text)


def complete(request):
    messages = list(Message.objects.all())
    messages.append(Message(content="Hello, World!"))
    messages.sort(key=lambda m: m.content)
    return render(request, 'template.html', {'messages': messages})


from django.conf.urls import url

urlpatterns = [
    url('^hello', hello),
    url('^json',  json),
    url('^remote',  remote),
    url('^complete',  complete),
]

# pylama:ignore=E402
