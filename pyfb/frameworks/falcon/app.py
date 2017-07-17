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
env = jinja2.Environment(loader=loader)


# Application

import json
import falcon
import requests


class JSONResource(object):
    def on_get(self, request, response):
        json_data = {'message': 'Hello, world!'}
        response.body = json.dumps(json_data)


class RemoteResource(object):
    def on_get(self, request, response):
        remote_response = requests.get('http://%s' % HOST)
        response.set_header('Content-Type', 'text/html')
        response.body = remote_response.text


class CompleteResource(object):
    def on_get(self, request, response):
        session = Session()
        messages = list(session.query(Message).order_by(func.random()).limit(100))
        messages.append(Message(content='Hello, World!'))
        messages.sort(key=lambda m: m.content)
        session.close()
        template = env.get_template('template.html')
        response.set_header('Content-Type', 'text/html')
        response.body = template.render(messages=messages)


app = falcon.API()

app.add_route("/json", JSONResource())
app.add_route("/remote", RemoteResource())
app.add_route("/complete", CompleteResource())


# pylama:ignore=E402
