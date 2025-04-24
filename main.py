#!/usr/bin/env python3
import asyncio
from hypercorn import Config
from hypercorn.asyncio import serve
from pycrdt_websocket import ASGIServer, WebsocketServer
import os


websocket_server = WebsocketServer()
app = ASGIServer(websocket_server)

async def main():
    websocket_server = WebsocketServer()
    app = ASGIServer(websocket_server)
    config = Config()
    config.bind = [f"0.0.0.0:{os.getenv('PORT', '8000')}"]
    async with websocket_server:
        await serve(app, config, mode="asgi")

asyncio.run(main())