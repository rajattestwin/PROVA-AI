from django.db import models
import datetime as dt
from Content_app.models import *
from Profile.models import *

# Create your models here.
class DuosChallenge(models.Model):
   course = models.ForeignKey(Course, related_name="duos_challenge_courses", on_delete=models.CASCADE, null=True, blank=True)
   subject = models.ForeignKey(Subject, related_name="duos_challenge_subjects", on_delete=models.CASCADE, null=True, blank=True)
   chapter = models.ForeignKey(Chapter, related_name="duos_challenge_chapters", on_delete=models.CASCADE, null=True, blank=True)
   topic = models.ForeignKey(Topic, related_name="duos_challenge_topics", on_delete=models.CASCADE, null=True, blank=True)
   challenger = models.ForeignKey(Student, related_name="student_creating_duos_challenges", on_delete=models.CASCADE)
   title = models.CharField(max_length=100)
   entryAmt = models.IntegerField(default=0)
   winningAmt = models.IntegerField(default=0)
   quesInChallenge = models.ManyToManyField(Question, related_name="questions_in_duos_challenge", blank=True)
   totalMarks = models.FloatField(default=40)
   correctAnswerMarks = models.FloatField(default=4)
   negativeMarks = models.FloatField(default=1)
   challengeTime = models.DurationField(default=dt.timedelta(minutes=5))
   activeTimestamp = models.DateTimeField(null=True, blank=True)
   isActive = models.BooleanField(default=True)
   challengeLanguage = models.ForeignKey(Language, related_name="language_of_duos_challenges", on_delete=models.SET_NULL, null=True, blank=True)
   isPublish = models.BooleanField(default=False)
   isThisFreeChallenge = models.BooleanField(default=False)
   isAttemptedByChallenger = models.BooleanField(default=False)
   isAcceptedByCompetitor = models.BooleanField(default=False)
   competitor = models.ForeignKey(Student, related_name="student_accepting_duos_challenges", on_delete=models.SET_NULL, null=True, blank=True)
   winner = models.ForeignKey(Student, related_name="duos_challenge_winners", on_delete=models.SET_NULL, null=True, blank=True)
   completedTimestamp = models.DateTimeField(null=True, blank=True)
   instructions = models.TextField(null=True, blank=True)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
        return str(self.id) + " " + self.title + " " + self.course.name + " " + str(self.entryAmt) + " " + self.challenger.name + " " + " " + str(self.isActive)