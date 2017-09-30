import os

HOST = os.environ.get('DHOST', '127.0.0.1')

# Database
from sqlalchemy import create_engine, schema, Column
from sqlalchemy.sql.expression import func
from sqlalchemy.types import Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine("postgres://benchmark:benchmark@%s:5432/benchmark" % HOST, pool_size=10)
metadata = schema.MetaData()
Base = declarative_base(metadata=metadata)
Session = sessionmaker(bind=engine)


class Message(Base):
    __tablename__ = 'message'

    id = Column(Integer, primary_key=True)
    content = Column(String(length=512))


# Templates

import os
import jinja2

root = os.path.dirname(os.path.abspath(__file__))
loader = jinja2.FileSystemLoader(root)
jinja_env = jinja2.Environment(loader=loader)


# Application

from wheezy.http import HTTPResponse, WSGIApplication
from wheezy.http.config import bootstrap_http_defaults
from wheezy.routing import PathRouter
from wheezy.web.middleware import path_routing_middleware_factory
from wheezy.web.templates import Jinja2Template
import json
import requests


def json_handler(request):
    response = HTTPResponse(content_type='application/json')
    json_data = {'message': 'Hello, world!'}
    response.write(json.dumps(json_data))
    return response


def remote(request):
    response = HTTPResponse()
    response.write(requests.get('http://%s' % HOST).text)
    return response


def complete(request):
    session = Session()
    messages = list(session.query(Message).order_by(func.random()).limit(100))
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    session.close()

    response = HTTPResponse()
    response.write(render_template('template.html', {'messages': messages}))
    return response


render_template = Jinja2Template(jinja_env)

r = PathRouter()
r.add_routes([
    ('json', json_handler),
    ('remote', remote),
    ('complete', complete)
])


app = WSGIApplication(
    middleware=[
        bootstrap_http_defaults,
        path_routing_middleware_factory,
    ],
    options={
        'path_router': r,
    }
)


if __name__ == '__main__':
    from wsgiref.simple_server import make_server
    make_server('0.0.0.0', 5000, app).serve_forever()
