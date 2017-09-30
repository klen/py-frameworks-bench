import falcon
from ..lib.serializers import json
from ..lib.constants import HOST
from ..lib.http import get_http_session
from ..lib.db import get_pg_pool, perform_query


class JSONResource(object):
    def on_get(self, request, response):
        json_data = {'message': 'Hello, world!'}
        response.body = json.dumps(json_data)


class RemoteResource(object):
    def on_get(self, request, response):
        remote_response = session.get('http://%s' % HOST)
        response.set_header('Content-Type', 'text/html')
        response.body = remote_response.text


class CompleteResource(object):
    def on_get(self, request, response):
        results = perform_query(db)
        response.set_header('Content-Type', 'text/html')
        response.body = json.dumps(results)


app = falcon.API()
db = get_pg_pool()
session = get_http_session()

app.add_route("/json", JSONResource())
app.add_route("/remote", RemoteResource())
app.add_route("/complete", CompleteResource())
