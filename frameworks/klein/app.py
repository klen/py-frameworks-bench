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


from klein import Klein
import treq


app = Klein()


@app.route('/hello')
def hello(request):
    return 'Hello, World!'


@app.route('/json')
def json(request):
    return 'Hello, World!'


@app.route('/remote')
def remote(request):
    d = treq.get('http://test')
    d.addCallback(treq.content)
    return d


@app.route('/complete')
def complete(request):
    return 'Hello, World!'


# pylama:ignore=E402
