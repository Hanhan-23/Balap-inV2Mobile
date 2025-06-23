from celery import shared_task
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer

@shared_task
def hello_celery():
    print("Hello from Celery")

    channel_layer = get_channel_layer()
    async_to_sync(channel_layer.group_send)(
        'countdown_group',
        {
            'type': 'send_countdown',
            'message': 'reset' 
        }
    )