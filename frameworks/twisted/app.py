import json
import os
import sys

import treq
from alchimia import TWISTED_STRATEGY
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String
from twisted.internet import reactor
from twisted.application import service, internet
from twisted.logger import globalLogBeginner, FileLogObserver, formatEvent
from twisted.web.resource import Resource
from twisted.web.server import Site, NOT_DONE_YET
from twisted.web.template import Element, renderer, XMLString, flatten


HOST = os.environ.get('DHOST', '127.0.0.1')


globalLogBeginner.beginLoggingTo([
    FileLogObserver(sys.stdout, lambda e: formatEvent(e) + os.linesep)])


def execute(arg, returnsData=True, fetchAll=True):
    d = engine.execute(arg)
    if fetchAll and returnsData:
        d.addCallback(lambda result: result.fetchall())
    elif returnsData:
        d.addCallback(lambda result: result.fetchone())
    return d


connectionString = 'postgres://benchmark:benchmark@%s:5432/benchmark' % HOST

engine = create_engine(
    connectionString, reactor=reactor, strategy=TWISTED_STRATEGY)

metadata = MetaData()

messages = Table(
    "message", metadata,
    Column("id", Integer, primary_key=True),
    Column("content", String)
)

baseResource = Resource()


class JSONResource(Resource):

    def render_GET(self, request):
        return json.dumps({'message': 'Hello, World!'}).encode('utf8')


class RemoteResource(Resource):

    def render_GET(self, request):

        d = treq.get('http://%s' % HOST)
        d.addCallback(treq.content)
        d.addCallback(request.write)
        d.addCallback(lambda _: request.finish())

        return NOT_DONE_YET


TEMPLATE = """<html xmlns:t="http://twistedmatrix.com/ns/twisted.web.template/0.1">
  <head>
    <title>Messages</title>
  </head>
  <body>
    <table>
      <tr>
        <th>id</th>
        <th>message</th>
      </tr>
      <t:transparent t:render="messages">
      <tr>
        <td><t:slot name="id"/></td>
        <td><t:slot name="content"/></td>
      </tr>
      </t:transparent>
    </table>
  </body>
</html>"""


class MessagesElement(Element):

    loader = XMLString(TEMPLATE)

    def __init__(self, messages):
        self._messages = messages

    @renderer
    def messages(self, request, tag):

        for message in self._messages:
            yield tag.clone().fillSlots(id=message[0], content=message[1])


class CompleteResource(Resource):

    def render_GET(self, request):

        d = execute(messages.select())

        def _(results):
            allResults = []
            results.sort(key=lambda r: r.content)
            for r in results:
                allResults.append((str(r.id), r.content))
            return allResults

        d.addCallback(_)
        d.addCallback(lambda r: flatten(request, MessagesElement(r), request.write))
        d.addCallback(lambda _: request.finish())

        return NOT_DONE_YET

baseResource.putChild(b'json', JSONResource())
baseResource.putChild(b'remote', RemoteResource())
baseResource.putChild(b'complete', CompleteResource())

webFactory = Site(baseResource)
import ipdb; ipdb.set_trace()  # XXX BREAKPOINT
tcp_service = internet.TCPServer(5000, webFactory)

application = service.Application("Python benchmark")
tcp_service.setServiceParent(application)
