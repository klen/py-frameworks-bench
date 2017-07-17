import os
from ..lib.constants import HOST
from ..lib.http import get_http_session

HOST = os.environ.get('DHOST', '127.0.0.1')

import flask
import requests
from flask import current_app
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql.expression import func

app = flask.Flask(__name__, template_folder='.')
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://benchmark:benchmark@%s:5432/benchmark' % HOST
app.config['SQLALCHEMY_POOL_SIZE'] = 1000
app.session = get_http_session()
db = SQLAlchemy(app)


@app.route('/json')
def json():
    return flask.jsonify(message='Hello, World!')


@app.route('/remote')
def remote():
    response = current_app.session.get('http://%s' % HOST)
    return response.text


@app.route('/complete')
def complete():
    messages = list(Message.query.order_by(func.random()).limit(100))
    messages.append(Message(content='Hello, World!'))
    content = [{"id": m.id, "content": m.content} for m in messages]
    return flask.jsonify(content)
