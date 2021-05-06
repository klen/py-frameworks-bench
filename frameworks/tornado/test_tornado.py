import pathlib
import json
import random
from importlib import import_module

from asgi_tools.tests import encode_multipart
from tornado.testing import AsyncHTTPTestCase


class TornadoTests(AsyncHTTPTestCase):

    def get_app(self):
        return import_module('.tornado.app', package='frameworks').app

    def test_routes(self):
        rand = random.randint(10, 99)
        for n in range(5):
            res = self.fetch(f"/route-{n}")
            self.assertEqual(res.code, 200)

            res = self.fetch(f"/route-dyn-{n}/{rand}")
            self.assertEqual(res.code, 200)

    def test_html(self):
        res = self.fetch('/html')
        self.assertEqual(res.code, 200)
        self.assertEqual(res.headers.get('content-type'), 'text/html; charset=UTF-8')
        header = res.headers.get('x-time')
        self.assertTrue(header)
        self.assertEqual(res.body, b'<b>HTML OK</b>')

    def test_upload(self):
        res = self.fetch('/upload')
        self.assertEqual(res.code, 405)

        res = self.fetch('/upload', method='POST', allow_nonstandard_methods=True)
        self.assertEqual(res.code, 400)

        body, content_type = encode_multipart({'file': open(__file__)})
        res = self.fetch(
            "/upload", method='POST', body=body, headers={'content-type': content_type})
        self.assertEqual(res.code, 200)
        self.assertEqual(res.headers['content-type'], 'text/plain')
        filename = res.body.decode()
        self.assertTrue(pathlib.Path(filename).read_text('utf-8').startswith('import pathlib'))

    def test_api(self):
        rand = random.randint(10, 99)
        url = f"/api/users/{rand}/records/{rand}?query=test"
        res = self.fetch(url)
        self.assertEqual(res.code, 405)

        res = self.fetch(url, method='PUT', body='{"foo":"bar"}')
        self.assertEqual(res.code, 401)

        res = self.fetch(url, method='PUT', body='{"foo":"bar"}', headers={"authorization": "1"})
        self.assertEqual(res.code, 200)
        data = json.loads(res.body)
        self.assertTrue(data['data'])
        self.assertEqual(data['data'], {'foo': 'bar'})
        self.assertTrue(data['query'])
        self.assertEqual(data['query']['query'], 'test')
        self.assertEqual(data['params'], {'user': rand, 'record': rand})

