from celery import shared_task

@shared_task
def hello_celery():
    print("✅ Hello from Celery!")