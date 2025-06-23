from django.urls import re_path
from tasks import consumers

websocket_urlpatterns = [
    re_path(r'ws/countdown/$', consumers.CountdownConsumer.as_asgi()),
]