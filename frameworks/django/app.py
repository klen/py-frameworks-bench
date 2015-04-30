from django.conf import settings

settings.configure(
    ADMINS=('test', 'test@test.com'),

    APPEND_SLASH=False,

    ALLOWED_HOSTS=('33.33.33.8', 'localhost'),

    ROOT_URLCONF='views',

    DATABASES={
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': ':memory:',
            'USER': '',
            'PASSWORD': '',
            'TEST_CHARSET': 'utf8',
        }
    },
    CACHE_BACKEND='locmem://',

    INSTALLED_APPS=(),

    TEMPLATE_CONTEXT_PROCESSORS=(
        'django.core.context_processors.static',
        'django.core.context_processors.request',
    ),

    EMAIL_BACKEND='django.core.mail.backends.locmem.EmailBackend',
)

from django.apps import apps
apps.populate(settings.INSTALLED_APPS)

from django.core.handlers.wsgi import WSGIHandler
app = WSGIHandler()
