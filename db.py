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

for n in range(0, 10000, 1000):
    mixer.cycle(1000).blend(Message)
    print("Generated %d messages from 10000." % (n + 1000))

db.close()
