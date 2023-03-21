import string
from django.http import Http404
import requests
from rest_framework.views import APIView
from rest_framework.response import Response
from django.db import transaction

from Profile.models import *
import datetime as dt
from dateutil import tz, parser
from django.contrib.auth import authenticate
import random as rd
from rest_framework.authtoken.models import Token

class GetWhatsAppToken(APIView):
    @transaction.atomic
    def get(self, request, *args, **kwargs):
        sid = transaction.savepoint()
        try:
            whatsapp_token = request.META.get('HTTP_WHATSAPP_TOKEN')
            
            url = "https://testwin.authlink.me"
            
            headers = {
                "clientId":"8coxxve4",
                "clientSecret":"omyqbs9b8ctchmdq",
                "Content-Type":"application/json" 
            }

            body = {
                "waId":whatsapp_token
            }

            response = requests.post(url, headers=headers, json=body)
            response_json = response.json()

            if response_json['statusCode'] == 200:
                whatsapp_number = '+' + response_json['data']['userMobile']

                if Student.objects.filter(phoneNumber=whatsapp_number).exists():
                    student = Student.objects.get(phoneNumber=whatsapp_number)

                    if student.isLogin == False:
                        student.isLogin = True
                        student.save(
                            update_fields=[
                                'isLogin'
                            ]
                        )

                        #ssh stands for Student Session History 
                        ssh = StudentSessionHistory.objects.create(
                            student = student,
                            loginTimestamp = dt.datetime.now(tz.tzutc())
                        )

                        message = 'Exists'

                    else:
                        message = 'Already Logged In'

                    context = {
                        'status':'Success',
                        'message':message, 
                        'avatar':student.avatar,
                        'name':student.name, 
                        'email_id':student.emailID, 
                        'phone_number':str(student.phoneNumber), 
                        'residential_state':student.residentialState,
                        'course':student.competitiveExamSelection 
                    }

                    transaction.savepoint_commit(sid) 

                else:
                    context = {
                        'status':'Failed!',
                        'message':'Does Not Exist',
                        'phone_number':whatsapp_number
                    }
            else:
                raise Exception('Invalid WhatsApp Token')

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

            transaction.savepoint_rollback(sid)

        return Response(context)

def generate_username(email_id):
    temp_username = email_id.split('@')

    size = 2
    prefix_choices = string.ascii_uppercase + string.punctuation
    suffix_choices = string.ascii_lowercase + string.punctuation

    prefix = ''.join(rd.choices(prefix_choices, k=size))
    suffix = ''.join(rd.choices(suffix_choices, k=size))
    username = prefix + temp_username[0] + suffix

    return username



class StudentCRUDOperations(APIView):
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        sid = transaction.savepoint()
        try:
            student_data = request.data
            sname = student_data['name']
            device_token = student_data['device_token']
            emailID = student_data['email_id']
            phoneNo = student_data['phone_number']
            residential_state = student_data['state']
            competitive_exam_name = student_data['course']
            avatar_ind = str(student_data['avatar'])
            student_institute_type=student_data['institute_type']
            
            username = generate_username(emailID)

        except Exception as e:
            context = {
                'status':'Failed!', 
                'message':str(e)
            }
            
            return Response(context)

        try:
            student = Student.objects.get(
               emailID=emailID, 
               phoneNumber=phoneNo
            )

            context = {
                'status':'Failed!', 
                'message':'Student Already Exists!'
            }

        except Student.DoesNotExist:
            try:
                user = User.objects.create_user(
                    username=username
                )

                token, created = Token.objects.get_or_create(user=user)

                student = Student.objects.create(
                    studentUser = user,
                    deviceToken = device_token,
                    avatar = avatar_ind,
                    name = sname,
                    emailID = emailID,
                    phoneNumber = phoneNo,
                    residentialState = residential_state,
                    competitiveExamSelection = competitive_exam_name,
                    studentInstituteType=student_institute_type,
                    isLogin = True
                )

                #ssh stands for Student Session History
                ssh = StudentSessionHistory.objects.create(
                    student = student,
                    loginTimestamp = dt.datetime.now(tz.tzutc())
                )

                context = {
                    'status':'Success', 
                    'message':'Student Registered Successfully',  
                    'student_name':student.name,
                    'django_token':token.key
                }

                transaction.savepoint_commit(sid)

            except Exception as e:
                context = {
                    'status':'Failed!', 
                    'message':str(e)
                }

                transaction.savepoint_rollback(sid)

        return Response(context)

    def get(self, request, student_id=None, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')

            student = Student.objects.get(phoneNumber=phoneNo)

            context = {
                'status':'Success',
                'message':'Here are student details!', 
                'avatar':student.avatar,
                'name':student.name, 
                'email_id':student.emailID, 
                'phone_number':str(student.phoneNumber), 
                'residential_state':student.residentialState,
                'course':student.competitiveExamSelection 
            }

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class LoginStudent(APIView):
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        sid = transaction.savepoint()
        try:
            student_data = request.data
            
            phoneNo = student_data['phone_number']
            student = Student.objects.get(phoneNumber=phoneNo)

            if student.isLogin == False:
                student.isLogin = True
                student.save(
                    update_fields=[
                        'isLogin'
                    ]
                )

                #ssh stands for Student Session History 
                ssh = StudentSessionHistory.objects.create(
                    student = student,
                    loginTimestamp = dt.datetime.now(tz.tzutc())
                )

                context = {
                    'status':'Success', 
                    'message':'Student Already Exists and Login Successfully',
                    'student_name':student.name
                }

                transaction.savepoint_commit(sid)

            else:
                if student.isLogin == True:
                    context = {
                        'status':'Failed!', 
                        'message':'Student Already Logged In',
                        'student_name':student.name
                    }

                else:
                    raise Http404

        except Exception as e:
            context = {
                'status':'Failed!', 
                'message':str(e)
            }

            transaction.savepoint_rollback(sid)

        return Response(context)

class LogoutStudent(APIView):
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        sid = transaction.savepoint()
        try:
            student_data = request.data
            phoneNo = student_data['phone_number']
            
            student = Student.objects.get(phoneNumber=phoneNo)
            
            #ssh stands for Student Session History
            ssh = StudentSessionHistory.objects.filter(
                student=student, 
                logoutTimestamp=None
            ).latest('id')

            if student.isLogin == True:
                student.isLogin = False
                student.save(
                    update_fields=[
                        'isLogin'
                    ]
                )

                ssh.logoutTimestamp = dt.datetime.now(tz.tzutc())

                time_spend = ssh.logoutTimestamp - ssh.loginTimestamp
                ssh.timeSpend = time_spend
                ssh.save(
                    update_fields=[
                        'logoutTimestamp',
                        'timeSpend'
                    ]
                )

                context = {
                    'status':'Success',
                    'message':'Logout Successfully',
                    'student_name':student.name,
                }

                transaction.savepoint_commit(sid)

            else:
                raise Http404

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

            transaction.savepoint_rollback(sid)

        return Response(context)
