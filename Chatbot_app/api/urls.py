from django.urls import path
from .views import *

urlpatterns = [
    path('get_solution/', GetSolution.as_view(), name="Get_Solution"),
    ]