import os

import peewee
from mixer.backend.peewee import mixer
from playhouse.db_url import connect


HOST = os.environ.get('DHOST', '127.0.0.1')

PEEWEE_CONNECTION = 'postgres+pool://benchmark:benchmark@%s:5432/benchmark' % HOST
db = connect(PEEWEE_CONNECTION)
db.connect()


class Message(peewee.Model):

    content = peewee.CharField(max_length=512)

    def __unicode__(self):
        return "%s: %s" % (self.id, self.content)

    class Meta:
        database = db

try:
    Message.create_table()
except Exception:
    db.rollback()

mixer.cycle(10000).blend(Message)

db.close()
