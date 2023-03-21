from django.urls import include, path
from .views import * 


urlpatterns = [
   path('login/',LoginStudent.as_view(),name='Login_Student'),
   path('logout/',LogoutStudent.as_view(),name='Logout_Student'),
   path('studentcrudoperations/',StudentCRUDOperations.as_view(),name='Student_CRUD_Operations'),
]
