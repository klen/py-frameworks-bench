import signal
import os
import logging

from tornado import web, gen, httpclient, httpserver, ioloop

logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)


class HelloHandler(web.RequestHandler):

    def get(self):
        self.write("Hello, World!")


class JSONHandler(web.RequestHandler):

    def get(self):
        self.write({"message": "Hello, World!"})


class RemoteHandler(web.RequestHandler):

    @gen.coroutine
    def get(self):
        response = yield httpclient.AsyncHTTPClient().fetch("http://test")
        self.write(response.body)


app = web.Application(
    [
        web.url("/hello", HelloHandler),
        web.url("/json", JSONHandler),
        web.url("/remote", RemoteHandler),
    ]
)

pid = os.path.dirname(os.path.abspath(__file__)) + "/pid"


def sig_handler(sig, frame):
    logging.warning('Caught signal: %s', sig)
    loop = ioloop.IOLoop.instance()
    loop.add_callback(shutdown)


def shutdown():
    logging.info('Stopping http server')
    loop = ioloop.IOLoop.instance()
    loop.stop()
    os.remove(pid)


if __name__ == '__main__':
    logging.info('Starting http server')
    server = httpserver.HTTPServer(app)
    server.bind(5000, "0.0.0.0")
    server.start(2)

    signal.signal(signal.SIGTERM, sig_handler)
    signal.signal(signal.SIGINT, sig_handler)

    with open(pid, 'w') as f:
        f.write(str(os.getppid()))

    loop = ioloop.IOLoop.instance()
    loop.start()
