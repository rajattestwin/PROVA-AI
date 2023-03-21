from django.urls import path
from .views import *

urlpatterns = [
    path('submit_challenge/', ChallengeResultCRUDOperations.as_view(), name="Submit_Challenge"),
    path('get_challenge_analytics/', ChallengeResultCRUDOperations.as_view(), name="Get_Challenge_Analytics"),
    path('get_challenge_reward/', GetChallengeReward.as_view(), name="Get_Challenge_Reward"),
]