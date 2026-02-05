from os import name
from django.urls import path
from .import views

app_name = 'unstoppable'
urlpatterns = [
    path('',views.index, name='index')
]