from django.urls import path
from .views import *

urlpatterns = [
    path('admin_create_superuser/', AdminCreateSuperuser.as_view(), name="Admin_Create_Superuser"),
]