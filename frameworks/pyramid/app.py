# Database

from sqlalchemy import create_engine, schema, Column
from sqlalchemy.types import Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine("postgres://benchmark:benchmark@localhost:5432/benchmark", pool_size=10)
metadata = schema.MetaData()
Base = declarative_base(metadata=metadata)
Session = sessionmaker(bind=engine)


class Message(Base):
    __tablename__ = 'message'

    id = Column(Integer, primary_key=True)
    content = Column(String(length=512))


import requests
from pyramid.config import Configurator
from pyramid.response import Response
from pyramid.view import view_config


@view_config(route_name='json', renderer='json')
def json(request):
    return {'message': 'Hello, World!'}


@view_config(route_name='remote')
def remote(request):
    response = requests.get('http://test')
    return Response(response.text)


@view_config(route_name='complete', renderer='template.jinja2')
def complete(request):
    session = Session()
    messages = list(session.query(Message))
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    session.close()
    return {'messages': messages}


config = Configurator()
config.include('pyramid_jinja2')

config.add_route('json', '/json')
config.add_route('remote', '/remote')
config.add_route('complete', '/complete')

config.scan()

app = config.make_wsgi_app()

# pylama:ignore=E402
