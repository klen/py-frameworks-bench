import os
HOST = os.environ.get('DHOST', '127.0.0.1')
# number of db rows returned
# back by api
DB_ROW_COUNT = 100
DB_CONNECTIONS = 50
HTTP_CONNECTIONS = 1000
