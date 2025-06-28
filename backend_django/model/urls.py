# backend_django/model/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('sensor/', views.sensor_api_view, name='api_sensor'),
]