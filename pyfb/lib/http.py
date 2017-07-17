import requests
import aiohttp
from .constants import HTTP_CONNECTIONS


def get_http_session():
    session = requests.Session()
    adapter = requests.adapters.HTTPAdapter(
        pool_connections=HTTP_CONNECTIONS,
        pool_maxsize=HTTP_CONNECTIONS
    )
    session.mount('http://', adapter)
    return session


def get_http_session_async():
    connector = aiohttp.TCPConnector(limit=HTTP_CONNECTIONS)
    return aiohttp.ClientSession(connector=connector)
