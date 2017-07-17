import asyncpg
from .constants import HOST, MAX_DB_CONNECTIONS, DB_ROW_COUNT
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql.expression import func

DB = SQLAlchemy(app)
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
        max_size=MAX_DB_CONNECTIONS
    )
    return conn

async def perform_query_async(async_pg_pool):
    async with async_pg_pool.acquire() as connection:
        result = await connection.fetch(SQL_STATEMENT)
        result_dict = []
        for r in result:
            result_dict.append(dict(r.items()))
    return result_dict


class Message(DB.Model):
    __tablename__ = 'message'
    id = DB.Column(DB.Integer, primary_key=True)
    content = DB.Column(db.String(length=512))


def get_pg_pool():
    return DB


def perform_query(pg_pool):
    messages = list(Message.query.order_by(func.random()).limit(100))
    content = [{"id": m.id, "content": m.content} for m in messages]
    return content
