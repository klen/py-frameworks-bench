import os

HOST = os.environ.get('DHOST', '127.0.0.1')

import requests

from django.conf.urls import url
from django.db import models
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render


class Message(models.Model):
    content = models.CharField(max_length=512)

    class Meta:
        app_label = 'app'
        db_table = 'message'


def json(request):
    return JsonResponse({'message': 'Hello, World!'})


def remote(request):
    response = requests.get('http://%s' % HOST)
    return HttpResponse(response.text)


def complete(request):
    messages = list(Message.objects.order_by('?')[:100])
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    return render(request, 'template.html', {'messages': messages})


urlpatterns = [
    url('^json',  json),
    url('^remote',  remote),
    url('^complete',  complete),
]

# pylama:ignore=E402
