from django.urls import include, path
from .views import * 


urlpatterns = [
   path('create_challenge/', CreateChallenge.as_view(), name="Create_Challenge"),
   path('get_latest_challenge_details/', GetLatestCreatedChallengeDetails.as_view(), name="Get_Latest_Created_Challenge_Details"),
   path('get_duos_challenges/', GetDuosChallenges.as_view(), name="Get_Duos_Challenges"),
   path('get_live_duos_challenges/', GetLiveDuosChallenges.as_view(), name="Get_Live_Duos_Challenges"),
   path('get_inprogress_duos_challenges/', GetInProgressDuosChallenges.as_view(), name="Get_In-Progress_Duos_Challenges"),
   path('get_completed_duos_challenges/', GetCompletedDuosChallenges.as_view(), name="Get_Completed_Duos_Challenges"),
   path('join_duos_challenge/', JoinDuosChallenge.as_view(), name="Join_Duos_Challenge"),
   path('get_challenge_questions_detail/', GetIndividualChallengeQuestionsDetail.as_view(), name="Get_Challenge_Questions_Detail"),
]