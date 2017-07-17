from .constants import MAX_HTTP_CONNECTIONS

def get_async_client():
    connector = aiohttp.TCPConnector(limit=MAX_HTTP_CONNECTIONS)
    return ClientSession(connector=connector)
