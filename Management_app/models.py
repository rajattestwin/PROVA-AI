from django.db import models
from Profile.models import Student

# Create your models here.
class PruvaAIAppFunctionality(models.Model):
    isPruvaAIAppActive = models.BooleanField(default=True)

    #CCF stands for Create Challenge Functionality
    isCCFActive =  models.BooleanField(default=True)  

    #GFDCF stands for Generate Free Duos Challenges Functionality
    isGFDCFActive =  models.BooleanField(default=True)

    #GRGCF stands for Generate Random Group Challenges Functionality
    isGRGCFActive = models.BooleanField(default=True)

    #WMRF stands for Withdraw Money Request Functionality
    isWMRFActive = models.BooleanField(default=True)

    #RF stands for Referral Functionality
    isRFActive = models.BooleanField(default=True)

    minWithdrawAmt = models.IntegerField(default=0)
    minDuosChallengesForWithdraw = models.IntegerField(default=0)

    minEntryAmt = models.IntegerField(default=10)


    eachTWCoinValue = models.FloatField(null=True, blank=True)


    def __str__(self):
        return f"is_PruvaAI_app_active: {self.isPruvaAIAppActive}, is_ccf_active: {self.isCCFActive}"

    class Meta:
        verbose_name = "PruvaAI App Functionality"
        verbose_name_plural = "PruvaAI App Functionalities"
