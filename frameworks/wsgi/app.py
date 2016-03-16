import json
import os

import requests
from sqlalchemy import create_engine, schema, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from jinja2 import Template


TEMPLATE = Template(open(os.path.join(os.path.dirname(__file__), 'template.html')).read())

HOST = os.environ.get('THOST', '127.0.0.1')

engine = create_engine("postgres://benchmark:benchmark@%s:5432/benchmark" % HOST, pool_size=10)
metadata = schema.MetaData()
Base = declarative_base(metadata=metadata)
Session = sessionmaker(bind=engine)


class Message(Base):
    __tablename__ = 'message'

    id = Column(Integer, primary_key=True)
    content = Column(String(length=512))


def app(env, start_response):
    path = env['PATH_INFO']
    if path == '/json':
        start_response('200 OK', [('Content-Type', 'application/json')])
        return [json.dumps({'message': 'Hello, world!'}).encode('utf-8')]

    if path == '/remote':
        start_response('200 OK', [('Content-Type', 'text/html')])
        remote = requests.get('http://%s' % HOST).text
        return [remote.encode('utf-8')]

    if path == '/complete':
        start_response('200 OK', [('Content-Type', 'text/html')])
        session = Session()
        messages = list(session.query(Message).all())
        messages.append(Message(content='Hello, World!'))
        messages.sort(key=lambda m: m.content)
        session.close()
        return [TEMPLATE.render(messages=messages).encode('utf-8')]

    start_response('404 Not Found', [('Content-Type', 'text/plain')])
    return [b'Not Found']
