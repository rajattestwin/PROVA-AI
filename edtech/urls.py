"""edtech URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/challenge_analytics/', include('Challenge_Analytics_app.api.urls')),
    path('api/content/', include('Content_app.api.urls')),
    path('api/profile',include("Profile.api.urls")),
    path('api/play',include("Play_app.api.urls")),
    path('api/earn',include("Earn_app.api.urls")),
    path('api/management/', include('Management_app.api.urls')),
    path('api/chatbot',include("Chatbot_app.api.urls")),

]
