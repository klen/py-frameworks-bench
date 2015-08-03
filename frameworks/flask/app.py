import os

HOST = os.environ.get('THOST', '127.0.0.1')

import flask
import requests
from flask_sqlalchemy import SQLAlchemy


app = flask.Flask(__name__, template_folder='.')
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://benchmark:benchmark@%s:5432/benchmark' % HOST
app.config['SQLALCHEMY_POOL_SIZE'] = 10
db = SQLAlchemy(app)


class Message(db.Model):
    __tablename__ = 'message'
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(length=512))


@app.route('/json')
def json():
    return flask.jsonify(message='Hello, World!')


@app.route('/remote')
def remote():
    response = requests.get('http://%s' % HOST)
    return response.text


@app.route('/complete')
def complete():
    messages = list(Message.query.all())
    messages.append(Message(content='Hello, World!'))
    messages.sort(key=lambda m: m.content)
    return flask.render_template('template.html', messages=messages)

if __name__ == '__main__':
    app.run('0.0.0.0')
