import bottle
import requests


app = bottle.Bottle()


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
