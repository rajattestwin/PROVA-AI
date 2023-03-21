from django.db import models
from django.contrib.auth.models import User
from phonenumber_field.modelfields import PhoneNumberField
from django.utils.timezone import now



class Institute(models.Model):
   instituteUser = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
   serverKey = models.TextField(max_length=2000, null=True, blank=True)
   name = models.CharField(max_length=100)
   logo = models.URLField(max_length=1500, null=True, blank=True)
   instituteCode = models.CharField(max_length=20, null=True, blank=True)
   emailID = models.EmailField(null=True, blank=True)
   phoneNumber = PhoneNumberField(unique=True, null=False, blank=False)
   aboutUs = models.URLField(max_length=2000, null=True, blank=True)
   Institute_Type_Choices = [
       ('Inst', 'Institute'),
       ('Sch', 'School'),
       ('Clg', 'College'),
       ('Univ', 'University'),
   ]
   typeOfInstitute = models.CharField(max_length=5, choices=Institute_Type_Choices, default='Inst')
   Institute_Level_Choices = [
       ('T1', 'Tier - I'),
       ('T2', 'Tier - II'),
       ('T3', 'Tier - III'),
   ]
   levelOfInstitute = models.CharField(max_length=3, choices=Institute_Level_Choices, default='T1')
   Institute_Badges_Choices = [
       ('B', 'Bronze'),
       ('S', 'Silver'),
       ('G', 'Gold'),
       ('D', 'Diamond'),
   ]
   badge = models.CharField(max_length=2, choices=Institute_Badges_Choices, default='B')
   fullAddress = models.TextField(null=True, blank=True)
   websiteURL = models.URLField(null=True, blank=True)
   facebookURL = models.URLField(null=True, blank=True)
   instagramURL = models.URLField(null=True, blank=True)
   twitterURL = models.URLField(null=True, blank=True)
   linkedinURL = models.URLField(null=True, blank=True)
   telegramURL = models.URLField(null=True, blank=True)
   whatsappToSendDoubt = models.BooleanField(default=False)
   whatsappURL = models.URLField(null=True, blank=True)
   showCourses = models.BooleanField(default=False)
   joiningTimestamp = models.DateTimeField(auto_now_add=True)
   
   def __str__(self):
     return f"name: {self.name}, type: {self.typeOfInstitute}, badge: {self.badge}"





class Student(models.Model):
   studentUser = models.OneToOneField(User, on_delete=models.CASCADE)
   deviceToken = models.TextField(max_length=2000, null=True, blank=True)
   avatar = models.CharField(max_length=2, null=True, blank=True)
   name = models.CharField(max_length=255)
   emailID = models.EmailField(unique=True)
   phoneNumber = PhoneNumberField(unique=True, null=False, blank=False)
   residentialState = models.CharField(max_length=30)
   Competitive_Exam_Choices = [
        ('JEE', 'JEE'),
        ('GATE', 'GATE'),
        ('NEET', 'NEET'),
        ('CAT', 'CAT'),
        ('GMAT', 'GMAT'),
        ('UPSC', 'UPSC'),
        ('SSC', 'SSC'),
    ]
   competitiveExamSelection = models.CharField(max_length=7, choices=Competitive_Exam_Choices)
   Institute_Type_Choices = [
        ('Inst', 'Institute'),
        ('Sch', 'School'),
        ('Clg', 'College'),
        ('Univ', 'University'),
    ]
   studentInstituteType = models.CharField(max_length=5, choices=Institute_Type_Choices)   
   isLogin = models.BooleanField(default=False)
   joiningTimestamp = models.DateTimeField(auto_now_add=True)
   updated=models.DateTimeField(auto_now=True)
   
   def __str__(self):
      return f"username: {self.studentUser.username}, is_login: {self.isLogin}"

class StudentSessionHistory(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    loginTimestamp = models.DateTimeField(null=True, blank=True)
    logoutTimestamp = models.DateTimeField(null=True, blank=True)
    timeSpend = models.DurationField(null=True, blank=True)

    def __str__(self):
        return f"username: {self.student.studentUser.username}, time_spend: {self.timeSpend}"
    




