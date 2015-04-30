import flask
import requests


app = flask.Flask(__name__)


@app.route('/hello')
def hello():
    return "Hello, World!"


@app.route("/json")
def json():
    return flask.jsonify(message='Hello, World!')


@app.route("/remote")
def remote():
    response = requests.get('http://test')
    return response.text
