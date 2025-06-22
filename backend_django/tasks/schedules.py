from celery.schedules import crontab
from backend_django.celery import app

app.conf.beat_schedule = {
    'run-every-1-minutes': {
        'task': 'tasks.tasks.hello_celery',
        'schedule': crontab(minute='*/1'),
    },
}
