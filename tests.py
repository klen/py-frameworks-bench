import os

from webtest import TestApp

os.environ['TEST'] = 'yes'


def test_muffin(app, client):
    response = client.get('/json')
    assert response.json == {'message': 'Hello, World!'}

    response = client.get('/remote')
    assert response.status_code == 200
    assert 'html' in response

    app.ps.peewee.models.message.create_table()
    response = client.get('/complete')
    import ipdb; ipdb.set_trace()  # XXX BREAKPOINT


def test_django():
    from frameworks.django.app import app
    app = TestApp(app)
    import ipdb; ipdb.set_trace()  # XXX BREAKPOINT

