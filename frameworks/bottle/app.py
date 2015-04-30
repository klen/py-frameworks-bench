import bottle
from bottle_sqlalchemy import Plugin
from sqlalchemy import create_engine, Column, String, Integer
from sqlalchemy.ext.declarative import declarative_base
import requests

Base = declarative_base()
engine = create_engine('postgres://benchmark:benchmark@localhost:5432/benchmark')

app = bottle.Bottle()
plugin = Plugin(engine, Base.metadata)
app.install(plugin)


class Message(Base):
    __tablename__ = "message"
    id = Column(Integer, primary_key=True)
    content = Column(String(length=512))


@app.route("/hello")
def hello():
    return "Hello, World!"


@app.route("/json")
def json():
    return {"message": "Hello, World!"}


@app.route("/remote")
def remote():
    response = requests.get('http://test')
    return response.text


@app.route("/complete")
def complete(db):
    messages = list(db.query(Message).all())
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    return bottle.template('template', messages=messages)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
