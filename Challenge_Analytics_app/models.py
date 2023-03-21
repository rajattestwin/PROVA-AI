from django.db import models
from Content_app.models import *
from Play_app.models import *

# Create your models here.
class AttemptedQuestion(models.Model):
    student = models.ForeignKey(Student, related_name="student_attempted_questions", on_delete=models.CASCADE)
    course = models.ForeignKey(Course, related_name="course_attempted_questions", on_delete=models.CASCADE, null=True, blank=True)
    subject = models.ForeignKey(Subject, related_name="subject_attempted_questions", on_delete=models.CASCADE, null=True, blank=True)
    chapter = models.ForeignKey(Chapter, related_name="chapter_attempted_questions", on_delete=models.CASCADE, null=True, blank=True)
    topic = models.ForeignKey(Topic, related_name="topic_attempted_questions", on_delete=models.CASCADE, null=True, blank=True)
    question = models.ForeignKey(Question, related_name="attempted_questions", on_delete=models.CASCADE)
    isAttempted = models.BooleanField(default=False)
    optionAttempted = models.ForeignKey(Option, related_name="attempted_option", on_delete=models.SET_NULL, null=True, blank=True)
    attemptDuration = models.DurationField(null=True, blank=True)
    attemptedTimestamp = models.DateTimeField(auto_now_add=True)
    updatedTimestamp = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.id) + " " + self.student.name + " " + self.question.statement + " " + str(self.isAttempted)

    class Meta:
        verbose_name = "Attempted Question"

#CA and WA stands for Correct Answers and Wrong Answers
class DuosChallengeResult(models.Model):
    student = models.ForeignKey(Student, related_name="student_duos_challenge_results", on_delete=models.CASCADE, null=True, blank=True)

    #dc stands for Duos Challenge
    dc = models.ForeignKey(DuosChallenge, related_name="particular_dc_results", on_delete=models.CASCADE, null=True, blank=True)
    isCompleted = models.BooleanField(default=False)
    attemptedQuestions = models.ManyToManyField(AttemptedQuestion, related_name="dc_attempted_questions", blank=True)
    marksScoredForCA = models.FloatField(default=0)
    marksDeductedForWA = models.FloatField(default=0)
    finalMarksScored = models.FloatField(default=0)
    
    #nca stands for number of correct answers
    nca = models.IntegerField(default=0)

    #nwa stands for number of wrong answers
    nwa = models.IntegerField(default=0)

    #nqs stands for number of questions skipped
    nqs = models.IntegerField(default=0)
    dcAttemptDuration = models.DurationField(null=True, blank=True)
    rewardWon = models.CharField(max_length=100, null=True, blank=True)
    isViewedRewardPopout = models.BooleanField(default=False)
    submittedTimestamp = models.DateTimeField(auto_now_add=True)
    updatedTimestamp = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"username: {self.student.studentUser.username}, dc_title: {self.dc.title}, is_completed: {self.isCompleted}"

    class Meta:
        verbose_name = "Duos Challenge Result"