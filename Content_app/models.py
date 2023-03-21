from django.db import models
import datetime as dt
from Profile.models import *

# Create your models here.
class Language(models.Model):
   Language_Name_Choices = [
       ('ENG', 'English'),
       ('HIN', 'Hindi'),
   ]
   name = models.CharField(max_length=5, choices=Language_Name_Choices, default='ENG')
   studentsInParticularLanguage = models.ManyToManyField(Student, related_name="students_in_a_language", blank=True)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
       return str(self.id) + " " + self.name + " " + str(self.updatedTimestamp) + " " + str(self.createdTimestamp)

class Course(models.Model):
   institute = models.ForeignKey(Institute, related_name="institute_courses", on_delete=models.CASCADE)
   studentsInCourse = models.ManyToManyField(Student, related_name="students_in_course", blank=True)
   name = models.CharField(max_length=255)
   logo = models.URLField(max_length=2000, null=True, blank=True)
   courseCode = models.CharField(max_length=10, unique=True)
   courseLanguage = models.ForeignKey(Language, related_name="course_Language", on_delete=models.SET_NULL, null=True, blank=True)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
       return str(self.id) + " " + self.name + " " + self.courseCode + " " + self.institute.name + " " + str(self.updatedTimestamp)

class Subject(models.Model):
   course = models.ForeignKey(Course, related_name="course_subjects", on_delete=models.CASCADE)
   name = models.CharField(max_length=255)
   subjectCode = models.CharField(max_length=10, unique=True)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
       return str(self.id) + " " + self.name + " " + self.subjectCode + " " + self.course.name + " " + str(self.updatedTimestamp)

class Chapter(models.Model):
   subject = models.ForeignKey(Subject, related_name="subject_chapters", on_delete=models.CASCADE)
   name = models.CharField(max_length=255)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
       return str(self.id) + " " + self.name + " " + self.subject.name + " " + self.subject.course.name + " " + str(self.updatedTimestamp)

class Topic(models.Model):
   chapter = models.ForeignKey(Chapter, related_name="chapter_topics", on_delete=models.CASCADE)
   name = models.CharField(max_length=255)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
       return str(self.id) + " " + self.name + " " + self.chapter.name + " " + self.chapter.subject.name + " " + self.chapter.subject.course.name + " " + str(self.updatedTimestamp)

class Question(models.Model):
   subject = models.ForeignKey(Subject, related_name="subject_questions", on_delete=models.CASCADE, null=True, blank=True)
   chapter = models.ForeignKey(Chapter, related_name="chapter_questions", on_delete=models.CASCADE, null=True, blank=True)
   topic = models.ForeignKey(Topic, related_name="topic_questions", on_delete=models.CASCADE, null=True, blank=True)
   statement = models.TextField(null=True, blank=True)
   quesImg = models.URLField(max_length=2000, null=True, blank=True)
   marks = models.FloatField(default=4)
   quesTime = models.DurationField(default=dt.timedelta(seconds=30))
   quesLanguage = models.ForeignKey(Language, related_name="language_of_questions", on_delete=models.SET_NULL, null=True, blank=True)
   Ques_Difficulty_Level_Choices = [
       ('Easy', 'Easy'),
       ('Medium', 'Medium'),
       ('Hard', 'Hard'),
   ]
   difficultyLevel = models.CharField(max_length=8, choices=Ques_Difficulty_Level_Choices, default='Easy')
   answerExplanation = models.TextField(null=True, blank=True)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
       return str(self.id) + " " +  self.subject.name + " " + self.chapter.name + " " + str(self.updatedTimestamp)

class Option(models.Model):
   ques = models.ForeignKey(Question, related_name="question_options", on_delete=models.CASCADE)
   optionText = models.CharField(max_length=255, null=True, blank=True)
   optionImg = models.URLField(max_length=2000, null=True, blank=True)
   isCorrect = models.BooleanField(default=False)
   createdTimestamp = models.DateTimeField(auto_now_add=True)
   updatedTimestamp = models.DateTimeField(auto_now=True)

   def __str__(self):
       return str(self.id) + " " + str(self.ques.id) + " " + str(self.isCorrect) + " " + str(self.updatedTimestamp)