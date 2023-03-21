from django.db import models
from phonenumber_field.modelfields import PhoneNumberField
from picklefield.fields import PickledObjectField
import datetime as dt
from Play_app.models import *
from Profile.models import *

# Create your models here.


class PruvaAICoinsWallet(models.Model):
    student = models.OneToOneField(Student, on_delete=models.CASCADE)
    pruvaAICoin = models.IntegerField(default=0)
    def __str__(self):
        return str(self.id) + " " + self.student.studentUser.username + " " + str(self.pruvaAICoin)

class StudentPAICoinsWalletTransactionHistory(models.Model):
   student = models.ForeignKey(Student, related_name="student_doing_tw_coins_transactions", on_delete=models.CASCADE)
   coinsTransacted = models.IntegerField(default=0)

   PAIC_Transaction_Status_Choices = [
       ('CR', 'Credited'),
       ('DR', 'Debited'),
   ]
   PAIcTransactionStatus = models.CharField(max_length=3, choices=PAIC_Transaction_Status_Choices, default='DR')
   description = models.CharField(max_length=255, null=True, blank=True)
   timestamp = models.DateTimeField(auto_now_add=True)

   def __str__(self):
       return self.student.studentUser.username + " " + str(self.coinsTransacted) + " " + self.twcTransactionStatus

