import os
HOST = os.environ.get('DHOST', '127.0.0.1')
MAX_DB_CONNECTIONS = 50
# number of db rows returned
# back by api
DB_ROW_COUNT = 100
MAX_HTTP_CONNECTIONS = 1000
