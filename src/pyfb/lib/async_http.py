import aiohttp
from .constants import MAX_HTTP_CONNECTIONS

def get_async_http_session():
    connector = aiohttp.TCPConnector(limit=MAX_HTTP_CONNECTIONS)
    return aiohttp.ClientSession(connector=connector)
