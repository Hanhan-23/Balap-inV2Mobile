import os
from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_django.settings')

app = Celery('backend_django')

app.config_from_object('django.conf:settings', namespace='CELERY')

# Wajib, agar celery worker bisa scanning ke folder tasks
app.autodiscover_tasks()