from django.core.asgi import get_asgi_application
from django.conf import settings

from . import views

settings.configure(
    SECRET_KEY='nosecret',
    DEBUG=False,
    ROOT_URLCONF = views,
)

app = get_asgi_application()
