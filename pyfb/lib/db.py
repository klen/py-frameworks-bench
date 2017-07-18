import asyncpg
import psycopg2.pool
import time
from .constants import HOST, DB_CONNECTIONS, DB_ROW_COUNT

DB_NAME = "benchmark"
DB_TABLE_NAME = "message"
USER = "benchmark"
PASSWORD = "benchmark"

SQL_STATEMENT = f"""
SELECT * FROM {DB_TABLE_NAME}
ORDER BY random() LIMIT {DB_ROW_COUNT};
""".strip()

async def get_pg_pool_async():
    conn = await asyncpg.create_pool(
        user=USER, password=PASSWORD,
        host=HOST, database=DB_NAME,
        max_size=DB_CONNECTIONS
    )
    return conn

async def perform_query_async(async_pg_pool):
    async with async_pg_pool.acquire() as connection:
        result = await connection.fetch(SQL_STATEMENT)
        result_dict = []
        for r in result:
            result_dict.append(dict(r.items()))
    return result_dict


def get_pg_pool():
    return psycopg2.pool.ThreadedConnectionPool(
        0, DB_CONNECTIONS,
        dbname=DB_NAME, user=USER,
        password=PASSWORD, host=HOST
    )


def perform_query(pg_pool):
    result_list = []
    key = time.time()
    conn = pg_pool.getconn()
    with conn.cursor() as cursor:
        cursor.execute(SQL_STATEMENT)
        for result in cursor.fetchall():
            result_list.append({"id": result[0],
                                "content": result[1]})
    pg_pool.putconn(conn)
    return result_list
