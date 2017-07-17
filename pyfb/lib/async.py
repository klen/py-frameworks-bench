import asyncio
import uvloop


def get_event_loop():
    loop = uvloop.new_event_loop()
    asyncio.set_event_loop(loop)
    return loop
