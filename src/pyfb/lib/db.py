import asyncpg
from .constants import HOST, MAX_DB_CONNECTIONS, DB_ROW_COUNT

DB_NAME = "benchmark"
USER = "benchmark"
PASSWORD = "benchmark"

SQL_STATEMENT = f"""
SELECT * FROM {DB_NAME}
ORDER BY random() LIMIT {DB_ROW_COUNT};
""".strip()

async def get_async_pg_pool():
    conn = await asyncpg.create_pool(
        user=USER, password=PASSWORD,
        host=HOST, database=DB_NAME,
        max_size=MAX_DB_CONNECTIONS
    )
    return conn

async def perform_query(async_pg_pool):
    async with async_pg_pool.acquire() as connection:
        result = await connection.fetch(SQL_STATEMENT)
        result_dict = []
        for r in result:
            result_dict.append({"id": r.id, "content": r.content})
    return result_dict
