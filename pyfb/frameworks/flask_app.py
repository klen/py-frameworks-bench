from ..lib.constants import HOST
from ..lib.http import get_http_session
from ..lib.db import get_pg_pool, perform_query

import flask
from flask import current_app

app = flask.Flask(__name__, template_folder='.')
app.session = get_http_session()
app.db = get_pg_pool()


@app.route('/json')
def json():
    return flask.jsonify(message='Hello, World!')


@app.route('/remote')
def remote():
    response = current_app.session.get('http://%s' % HOST)
    return response.text


@app.route('/complete')
def complete():
    results = perform_query(current_app.db)
    return flask.jsonify(results)
