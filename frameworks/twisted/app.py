import os
import sys

HOST = os.environ.get('THOST', '127.0.0.1')

import json
import treq

from twisted.internet import reactor
from twisted.internet.endpoints import serverFromString
from twisted.logger import globalLogBeginner, FileLogObserver, formatEvent
from twisted.web.template import Element, renderer, XMLString, flatten
from twisted.web.server import Site, NOT_DONE_YET
from twisted.web.resource import Resource

from alchimia import TWISTED_STRATEGY

from sqlalchemy import create_engine, MetaData
from sqlalchemy import Table, Column, Integer, String
from sqlalchemy.sql import and_, or_, not_
from sqlalchemy.schema import CreateTable

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
#connectionString = "sqlite://"
engine = create_engine(
    connectionString, reactor=reactor, strategy=TWISTED_STRATEGY)
metadata = MetaData()

messages = Table("message", metadata,
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

template = """<html xmlns:t="http://twistedmatrix.com/ns/twisted.web.template/0.1">
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

    loader = XMLString(template)

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

if __name__ == '__main__':

    with open('pid', 'w') as f:
        f.write(str(os.getpid()))

    server = serverFromString(reactor, "tcp:port=5000:interface=0.0.0.0")
    webFactory = Site(baseResource)
    server.listen(webFactory)

    reactor.run()
