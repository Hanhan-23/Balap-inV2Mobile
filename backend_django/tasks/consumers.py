import json
from channels.generic.websocket import AsyncWebsocketConsumer

class CountdownConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.channel_layer.group_add('countdown_group', self.channel_name)
        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard('countdown_group', self.channel_name)

    async def receive(self, text_data):
        pass

    async def send_countdown(self, event):
        await self.send(text_data=json.dumps({
            'message': event['message']
        }))