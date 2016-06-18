import os

HOST = os.environ.get('DHOST', '127.0.0.1')

import signal
import logging

from tornado import web, gen, httpclient, httpserver, ioloop, template

logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)


class JSONHandler(web.RequestHandler):

    def get(self):
        self.write({'message': 'Hello, World!'})


class RemoteHandler(web.RequestHandler):

    @gen.coroutine
    def get(self):
        response = yield httpclient.AsyncHTTPClient().fetch('http://%s' % HOST)
        self.write(response.body)


root = os.path.dirname(os.path.abspath(__file__))


from sqlalchemy import create_engine, schema, Column
from sqlalchemy.sql.expression import func
from sqlalchemy.types import Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine('postgres://benchmark:benchmark@%s:5432/benchmark' % HOST, pool_size=10)
metadata = schema.MetaData()
Base = declarative_base(metadata=metadata)
Session = sessionmaker(bind=engine)
loader = template.Loader(os.path.join(root))


class Message(Base):
    __tablename__ = 'message'

    id = Column(Integer, primary_key=True)
    content = Column(String(length=512))


class CompleteHandler(web.RequestHandler):

    @gen.coroutine
    def get(self):
        session = Session()
        messages = list(session.query(Message).order_by(func.random()).limit(100))
        messages.append(Message(content='Hello, World!'))
        messages.sort(key=lambda m: m.content)
        response = loader.load('template.html').generate(messages=messages)
        session.close()
        self.write(response)


app = web.Application(
    [
        web.url('/json',    JSONHandler),
        web.url('/remote',  RemoteHandler),
        web.url('/complete', CompleteHandler),
    ]
)


def sig_handler(sig, frame):
    logging.warning('Caught signal: %s', sig)
    loop = ioloop.IOLoop.instance()
    loop.add_callback(shutdown)


def shutdown():
    logging.info('Stopping HTTP server.')
    loop = ioloop.IOLoop.instance()
    loop.stop()
    if os.path.exists('pid'):
        os.remove('pid')


if __name__ == '__main__':
    logging.info('Starting HTTP server.')

    with open('pid', 'w') as f:
        f.write(str(os.getpid()))

    server = httpserver.HTTPServer(app)
    server.bind(5000, "0.0.0.0")
    server.start(2)

    signal.signal(signal.SIGTERM, sig_handler)
    signal.signal(signal.SIGINT, sig_handler)

    loop = ioloop.IOLoop.instance()
    loop.start()


# pylama:ignore=E402
