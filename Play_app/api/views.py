import string
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from django.db import transaction

from Profile.models import *
from Content_app.models import *
from Management_app.models import *
from Play_app.models import *
from Earn_app.models import *
from edtech.helper import *
from Challenge_Analytics_app.models import *
import datetime as dt
from django.db.models import Q
from dateutil import tz, parser
from django.contrib.auth import authenticate
import random as rd
from rest_framework.authtoken.models import Token


class CreateChallenge(APIView):
    @transaction.atomic
    def post(self, request, *args, **Kwargs):
        sid = transaction.savepoint()
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')

            challenge_data = request.data
            chapter_id = int(challenge_data['chapter_id'])
            entry_amt = int(challenge_data['entry_amt'])
            challenge_type = challenge_data['challenge_type']
            slots = int(challenge_data['slots'])
            start_timestamp = challenge_data['start_time']

            student = Student.objects.get(phoneNumber=phoneNo)

            student_language = Language.objects.get(studentsInParticularLanguage=student)
            #twaf stands for TestWin App Functionality
            paiaf = PruvaAIAppFunctionality.objects.all()[0]
            #CCF stands for Create Challenge Functionality
            if paiaf.isCCFActive == False:
                context = {
                    'status':'Failed!',
                    'message':'This feature is under maintenance, please come back after sometime'
                }
            elif entry_amt < paiaf.minEntryAmt:
                context = {
                    'status':'Failed!',
                    'message':f'Please enter entry amount between ₹{paiaf.minEntryAmt} and above (in the multiples of ₹{paiaf.minEntryAmt})'
                }
            else:
               wallet=PruvaAICoinsWallet.objects.get(student=student)        
               if entry_amt > wallet.pruvaAICoin:
                  context = {
                        'status':'Failed!',
                        'message':'Insufficient Balance! Please add money to your wallet'
                    }
                  return Response(context)
               else:
                  rem_coins=wallet.pruvaAICoin-entry_amt
                  wallet.pruvaAICoin=rem_coins
                  wallet.save(
                        update_fields=[
                            'pruvaAICoin'
                        ]
                  )

                  #sbawth stands for Student Bonus Amt Wallet Transaction History
                  spaiwth = StudentPAICoinsWalletTransactionHistory.objects.create(
                        student = student,
                        coinsTransacted = entry_amt,
                        PAIcTransactionStatus = 'DR',
                        description='Money deducted for creating duos challenge'
                    )
                  

                  chapter = Chapter.objects.get(id=chapter_id)
                  subject = Subject.objects.get(id=chapter.subject.id)
                  course = Course.objects.get(id=subject.course.id)

                  ques_to_be_used = Question.objects.filter(
                      chapter=chapter,
                      quesLanguage=student_language
                  ).values_list(
                      'id', 
                      flat=True
                    )
                    
                  student_attempted_ques = AttemptedQuestion.objects.filter(
                      student=student, 
                      chapter=chapter
                  ).prefetch_related('question').values_list(
                      'question__id', 
                      flat=True
                  )

                  no_of_ques = 10

                  difference_of_ques_list = list(set(ques_to_be_used).difference(set(student_attempted_ques)))

                  final_ques_list = rd.sample(difference_of_ques_list, no_of_ques)

                  finally_ques_to_be_used = Question.objects.filter(id__in=final_ques_list)

                  #entry_amt_20 stands for 20 percent of entry_amt
                  entry_amt_20 = 0.2 * entry_amt

                  if challenge_type == "DUOS":
                        winning_amt = 2 * (entry_amt)

                        duos_challenge = DuosChallenge.objects.create(
                            course = course,
                            subject = subject,
                            chapter = chapter,
                            challenger = student,
                            title = chapter.name + " Challenge",
                            entryAmt = entry_amt,
                            winningAmt = winning_amt,
                            challengeLanguage = student_language
                        )

                        duos_challenge.quesInChallenge.add(*finally_ques_to_be_used)
                        duos_challenge.activeTimestamp = duos_challenge.createdTimestamp + dt.timedelta(1)
                        duos_challenge.save(
                            update_fields=[
                                'activeTimestamp'
                            ]
                        )
                        context = {
                            'status':'Success',
                            'message':'Duos Challenge Created Sucessfully',
                            'challenge_type':challenge_type,
                            'created_by':student.name,
                        }

                        transaction.savepoint_commit(sid)
                  else:   
                     context = {
                        'status':'Failed!',
                        'message':"Please select Valid Challenge Type"
                     }
                     transaction.savepoint_rollback(sid)
        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

            transaction.savepoint_rollback(sid)

        return Response(context)

class GetLatestCreatedChallengeDetails(APIView):
    def get(self, request, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')
            challenge_type = request.META.get('HTTP_TYPE')

            student = Student.objects.get(phoneNumber=phoneNo)

            if challenge_type == 'D':

                #dc stands for duos challenge
                dc = DuosChallenge.objects.prefetch_related(
                    'course',
                    'subject'
                ).filter(challenger=student).latest('id')

                local_created_timestamp = get_local_from_utc(dc.createdTimestamp)

                local_active_timestamp = get_local_from_utc(dc.activeTimestamp)
                dc_active_time_left = local_active_timestamp - get_local_from_utc(get_current_utc())
                dc_active_time_left = dc_active_time_left.__str__().split(".")[0]

                latest_dc_list = [
                    {
                        'challenge_status':'Unattempted',
                        'challenge_id':dc.id,
                        'course_logo':dc.course.logo,
                        'course_name':dc.course.name,
                        'subject_name':dc.subject.name,
                        'title':dc.title,
                        'challenger_name':student.name,
                        'competitor_name':None,
                        'winner_name':None,
                        'entry_amt':str(dc.entryAmt),
                        'winning_amt':str(dc.winningAmt),
                        'winning_status':None,
                        'created_date':get_date_in_particular_format(local_created_timestamp),
                        'active_time_left':dc_active_time_left,
                        'completed_timestamp':None
                    }
                ]

                context = {
                    'status':'Success',
                    'message':'Here are latest duos challenge details!',
                    'challenge_type':'D',
                    'latest_duos_challenge':latest_dc_list
                }

            else:
               context = {
                  'status':'Failed!',
                  'message':"Please select Valid Challenge Type"
               }

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class GetDuosChallenges(APIView):
    def get(self, request, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')
            course_name = request.META.get('HTTP_COURSE_NAME')

            student = Student.objects.get(phoneNumber=phoneNo)

            student_language = Language.objects.get(
                studentsInParticularLanguage=student
            )

            course = Course.objects.get(
                name=course_name, 
                courseLanguage=student_language
            )

            duos_challenges = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger',
                'quesInChallenge',
                'competitor'
            ).filter(
                course=course,
                isActive=True,
                isThisFreeChallenge=False
            ).distinct()

            free_duos_challenges = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger'
            ).filter(
                course=course,
                isThisFreeChallenge=True,
                competitor=student
            ).distinct()

            attempted_ques = AttemptedQuestion.objects.filter(
                student=student, 
                course=course
            ).prefetch_related('question').values_list(
                'question__id', 
                flat=True
            )

            #dc stands for duos challenges
            live_dc_list = []
            inprogress_dc_list = []

            if duos_challenges.exists():
                for dc in duos_challenges:
                    local_created_timestamp = get_local_from_utc(dc.createdTimestamp)

                    local_active_timestamp = get_local_from_utc(dc.activeTimestamp)
                    dc_active_time_left = local_active_timestamp - get_local_from_utc(get_current_utc())
                    dc_active_time_left = dc_active_time_left.__str__().split(".")[0]

                    if dc.isPublish == True and dc.isAttemptedByChallenger == True:
                        if dc.challenger != student: 
                            if dc.isAcceptedByCompetitor == False:
                                ques_in_current_challenge = dc.quesInChallenge.all().values_list(
                                    'id',
                                    flat=True
                                )

                                common_ques = list(set(attempted_ques).intersection(set(ques_in_current_challenge)))

                                if len(common_ques) <= 2:
                                    live_dc_dict = {
                                        'challenge_status':'Live',
                                        'challenge_id':dc.id,
                                        'course_logo':course.logo,
                                        'course_name':course.name,
                                        'subject_name':dc.subject.name,
                                        'title':dc.title,
                                        'challenger_name':dc.challenger.name,
                                        'competitor_name':None,
                                        'winner_name':None,
                                        'entry_amt':str(dc.entryAmt),
                                        'winning_amt':str(dc.winningAmt),
                                        'winning_status':None,
                                        'created_date':get_date_in_particular_format(local_created_timestamp),
                                        'active_time_left':dc_active_time_left,
                                        'completed_timestamp':None
                                    }

                                    live_dc_list.append(live_dc_dict)

                            elif dc.isAcceptedByCompetitor == True and dc.competitor == student:
                                inprogress_dc_dict = {
                                    'challenge_status':'In-Progress',
                                    'challenge_id':dc.id,
                                    'course_logo':course.logo,
                                    'course_name':course.name,
                                    'subject_name':dc.subject.name,
                                    'title':dc.title,
                                    'challenger_name':dc.challenger.name,
                                    'competitor_name':student.name,
                                    'winner_name':None,
                                    'entry_amt':str(dc.entryAmt),
                                    'winning_amt':str(dc.winningAmt),
                                    'winning_status':None,
                                    'created_date':get_date_in_particular_format(local_created_timestamp),
                                    'active_time_left':dc_active_time_left,
                                    'completed_timestamp':None
                                }

                                inprogress_dc_list.append(inprogress_dc_dict)

                        else:
                            if dc.isAcceptedByCompetitor == True:
                                competitor_name = dc.competitor.name

                            else:
                                competitor_name = None

                            inprogress_dc_dict = {
                                'challenge_status':'In-Progress',
                                'challenge_id':dc.id,
                                'course_logo':course.logo,
                                'course_name':course.name,
                                'subject_name':dc.subject.name,
                                'title':dc.title,
                                'challenger_name':dc.challenger.name,
                                'competitor_name':competitor_name,
                                'winner_name':None,
                                'entry_amt':str(dc.entryAmt),
                                'winning_amt':str(dc.winningAmt),
                                'winning_status':'Active',
                                'created_date':get_date_in_particular_format(local_created_timestamp),
                                'active_time_left':dc_active_time_left,
                                'completed_timestamp':None
                            }

                            inprogress_dc_list.append(inprogress_dc_dict)

                    elif dc.challenger == student and dc.isPublish == False and dc.isAttemptedByChallenger == False:
                        inprogress_dc_dict = {
                            'challenge_status':'In-Progress',
                            'challenge_id':dc.id,
                            'course_logo':course.logo,
                            'course_name':course.name,
                            'subject_name':dc.subject.name,
                            'title':dc.title,
                            'challenger_name':student.name,
                            'competitor_name':None,
                            'winner_name':None,
                            'entry_amt':str(dc.entryAmt),
                            'winning_amt':str(dc.winningAmt),
                            'winning_status':None,
                            'created_date':get_date_in_particular_format(local_created_timestamp),
                            'active_time_left':dc_active_time_left,
                            'completed_timestamp':None
                        }

                        inprogress_dc_list.append(inprogress_dc_dict)

                live_dc_list = sorted(live_dc_list, key=lambda i: i['active_time_left'])
                inprogress_dc_list = sorted(inprogress_dc_list, key=lambda i: i['active_time_left'])

            free_live_dc_list = []
            free_inprogress_dc_list = []
            free_completed_dc_list = []

            if free_duos_challenges.exists():
                for fdc in free_duos_challenges:
                    local_created_timestamp = get_local_from_utc(fdc.createdTimestamp)
        
                    local_active_timestamp = get_local_from_utc(fdc.activeTimestamp)
                    fdc_active_time_left = local_active_timestamp - get_local_from_utc(get_current_utc())
                    fdc_active_time_left = fdc_active_time_left.__str__().split(".")[0]

                    if fdc.isActive == True:
                        if fdc.isAcceptedByCompetitor == False:
                            free_live_dc_dict = {
                                'challenge_status':'Live',
                                'challenge_id':fdc.id,
                                'course_logo':course.logo,
                                'course_name':course.name,
                                'subject_name':fdc.subject.name,
                                'title':fdc.title,
                                'challenger_name':'TestWin',
                                'competitor_name':None,
                                'winner_name':None,
                                'entry_amt':'FREE',
                                'winning_amt':str(fdc.winningAmt),
                                'winning_status':None,
                                'created_date':get_date_in_particular_format(local_created_timestamp),
                                'active_time_left':fdc_active_time_left,
                                'completed_timestamp':None
                            }

                            free_live_dc_list.append(free_live_dc_dict)

                        else:
                            free_inprogress_dc_dict = {
                                'challenge_status':'In-Progress',
                                'challenge_id':fdc.id,
                                'course_logo':course.logo,
                                'course_name':course.name,
                                'subject_name':fdc.subject.name,
                                'title':fdc.title,
                                'challenger_name':'TestWin',
                                'competitor_name':student.name,
                                'winner_name':None,
                                'entry_amt':'FREE',
                                'winning_amt':str(fdc.winningAmt),
                                'winning_status':None,
                                'created_date':get_date_in_particular_format(local_created_timestamp),
                                'active_time_left':fdc_active_time_left,
                                'completed_timestamp':None
                            }

                            free_inprogress_dc_list.append(free_inprogress_dc_dict)

                    else:
                        local_completed_timestamp = get_formatted_timestamp(get_local_from_utc(fdc.completedTimestamp), False)

                        free_completed_dc_dict = {
                            'challenge_status':'Completed',
                            'challenge_id':fdc.id,
                            'course_logo':course.logo,
                            'course_name':course.name,
                            'subject_name':fdc.subject.name,
                            'title':fdc.title,
                            'challenger_name':'TestWin',
                            'competitor_name':student.name,
                            'winner_name':student.name,
                            'entry_amt':'FREE',
                            'winning_amt':str(fdc.winningAmt),
                            'winning_status':'Won',
                            'created_date':get_date_in_particular_format(local_created_timestamp),
                            'active_time_left':None,
                            'completed_timestamp':local_completed_timestamp
                        }

                        free_completed_dc_list.append(free_completed_dc_dict)

                free_live_dc_list = sorted(free_live_dc_list, key=lambda i: i['active_time_left'])
                free_inprogress_dc_list = sorted(free_inprogress_dc_list, key=lambda i: i['active_time_left'])


                live_dc_list = free_live_dc_list + live_dc_list
                inprogress_dc_list = free_inprogress_dc_list + inprogress_dc_list

            completed_dc = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger',
                'competitor',
                'winner'
            ).filter(
                Q(course=course)
                &
                Q(Q(challenger=student) | Q(competitor=student))
                &
                Q(isActive=False)
                &
                Q(isThisFreeChallenge=False)
            ).distinct()

            completed_dc_list = []

            if completed_dc.exists():
                for cdc in completed_dc:
                    if cdc.winner is not None:
                        if cdc.winner == student:
                            status = 'Won'

                        else:
                            status = 'Lost'

                    else:
                        status = 'Tied'

                    local_created_timestamp = get_local_from_utc(cdc.createdTimestamp)

                    local_completed_timestamp = get_formatted_timestamp(get_local_from_utc(cdc.completedTimestamp), False)

                    completed_dc_dict = {
                        'challenge_status':'Completed',
                        'challenge_id':cdc.id,
                        'course_logo':course.logo,
                        'course_name':course.name,
                        'subject_name':cdc.subject.name,
                        'title':cdc.title,
                        'challenger_name':cdc.challenger.name,
                        'competitor_name':cdc.competitor.name,
                        'winner_name':cdc.winner.name,
                        'entry_amt':str(cdc.entryAmt),
                        'winning_amt':str(cdc.winningAmt),
                        'winning_status':status,
                        'created_date':get_date_in_particular_format(local_created_timestamp),
                        'active_time_left':None,
                        'completed_timestamp':local_completed_timestamp
                    }

                    completed_dc_list.append(completed_dc_dict)
                    
            completed_dc_list += free_completed_dc_list

            completed_dc_list = sorted(completed_dc_list, key=lambda i: i['completed_timestamp'], reverse=True)

            #all_dc_list = live_dc_list + inprogress_dc_list + completed_dc_list 

            context = {
                'status':'Success',
                'message':'Here are duos challenges list!',
                'live_duos_challenges':live_dc_list,
                'in-progress_duos_challenges':inprogress_dc_list,
                'completed_duos_challenges':completed_dc_list
            }
                        
        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class GetLiveDuosChallenges(APIView):
    def get(self, request, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')
            course_name = request.META.get('HTTP_COURSE_NAME')

            student = Student.objects.get(phoneNumber=phoneNo)

            student_language = Language.objects.get(
                studentsInParticularLanguage=student
            )

            course = Course.objects.get(
                name=course_name, 
                courseLanguage=student_language
            )

            duos_challenges = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger',
                'quesInChallenge',
                'competitor'
            ).filter(
                Q(course=course)
                &
                ~Q(challenger=student)
                &
                Q(isActive=True)
                &
                Q(isPublish=True)
                &
                Q(isAttemptedByChallenger=True)
                &
                Q(isAcceptedByCompetitor=False)
                &
                Q(isThisFreeChallenge=False)
            ).distinct()

            free_duos_challenges = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger'
            ).filter(
                course=course,
                isActive=True,
                isThisFreeChallenge=True,
                isAcceptedByCompetitor=False,
                competitor=student
            ).distinct()

            attempted_ques = AttemptedQuestion.objects.filter(
                student=student, 
                course=course
            ).prefetch_related('question').values_list(
                'question__id', 
                flat=True
            )

            #dc stands for duos challenges
            live_dc_list = []

            if duos_challenges.exists():
                for dc in duos_challenges:
                    local_created_timestamp = get_local_from_utc(dc.createdTimestamp)

                    local_active_timestamp = get_local_from_utc(dc.activeTimestamp)
                    dc_active_time_left = local_active_timestamp - get_local_from_utc(get_current_utc())
                    # dc_active_time_left = dc_active_time_left.__str__().split(".")[0]
                    if dc_active_time_left>dt.timedelta():
                        dc_active_time_left=dc_active_time_left.__str__().split(".")[0]
                        

                    
                        ques_in_current_challenge = dc.quesInChallenge.all().values_list(
                            'id',
                            flat=True
                        )

                        common_ques = list(set(attempted_ques).intersection(set(ques_in_current_challenge)))

                        if len(common_ques) <= 2:
                            live_dc_dict = {
                                'challenge_status':'Live',
                                'challenge_id':dc.id,
                                'course_logo':course.logo,
                                'course_name':course.name,
                                'subject_name':dc.subject.name,
                                'title':dc.title,
                                'challenger_name':dc.challenger.name,
                                'competitor_name':None,
                                'winner_name':None,
                                'entry_amt':str(dc.entryAmt),
                                'winning_amt':str(dc.winningAmt),
                                'winning_status':None,
                                'created_date':get_date_in_particular_format(local_created_timestamp),
                                'active_time_left':dc_active_time_left,
                                'completed_timestamp':None
                            }

                            live_dc_list.append(live_dc_dict)

                live_dc_list = sorted(live_dc_list, key=lambda i: i['active_time_left'])

            free_live_dc_list = []

            if free_duos_challenges.exists():
                for fdc in free_duos_challenges:
                    local_created_timestamp = get_local_from_utc(fdc.createdTimestamp)
        
                    local_active_timestamp = get_local_from_utc(fdc.activeTimestamp)
                    fdc_active_time_left = local_active_timestamp - get_local_from_utc(get_current_utc())
                    # fdc_active_time_left = fdc_active_time_left.__str__().split(".")[0]
                    if fdc_active_time_left>dt.timedelta():
                        fdc_active_time_left=fdc_active_time_left.__str__().split(".")[0]

                        free_live_dc_dict = {
                            'challenge_status':'Live',
                            'challenge_id':fdc.id,
                            'course_logo':course.logo,
                            'course_name':course.name,
                            'subject_name':fdc.subject.name,
                            'title':fdc.title,
                            'challenger_name':'TestWin',
                            'competitor_name':None,
                            'winner_name':None,
                            'entry_amt':'FREE',
                            'winning_amt':str(fdc.winningAmt),
                            'winning_status':None,
                            'created_date':get_date_in_particular_format(local_created_timestamp),
                            'active_time_left':fdc_active_time_left,
                            'completed_timestamp':None
                        }

                        free_live_dc_list.append(free_live_dc_dict)
     
                free_live_dc_list = sorted(free_live_dc_list, key=lambda i: i['active_time_left'])

                live_dc_list = free_live_dc_list + live_dc_list
 
            context = {
                'status':'Success',
                'message':'Here are live duos challenges list!',
                'live_duos_challenges':live_dc_list
            }
                        
        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class GetInProgressDuosChallenges(APIView):
    def get(self, request, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')
            course_name = request.META.get('HTTP_COURSE_NAME')

            student = Student.objects.get(phoneNumber=phoneNo)

            student_language = Language.objects.get(
                studentsInParticularLanguage=student
            )

            course = Course.objects.get(
                name=course_name, 
                courseLanguage=student_language
            )

            duos_challenges = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger',
                'competitor'
            ).filter(
                Q(course=course)
                &
                Q(Q(challenger=student) | Q(competitor=student))
                &
                Q(isActive=True)
                &
                Q(isThisFreeChallenge=False)
            ).distinct()

            free_duos_challenges = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger'
            ).filter(
                course=course,
                isActive=True,
                isThisFreeChallenge=True,
                isAcceptedByCompetitor=True,
                competitor=student
            ).distinct()

            #dc stands for duos challenges
            inprogress_dc_list = []
            inprogress_active_dc_list = []
       
            if duos_challenges.exists():
                for dc in duos_challenges:
                    local_created_timestamp = get_local_from_utc(dc.createdTimestamp)

                    local_active_timestamp = get_local_from_utc(dc.activeTimestamp)
                    dc_active_time_left = local_active_timestamp - get_local_from_utc(get_current_utc())
                    # dc_active_time_left = dc_active_time_left.__str__().split(".")[0]
                    if dc_active_time_left>dt.timedelta():
                        dc_active_time_left=dc_active_time_left.__str__().split(".")[0]


                        if dc.isPublish == True and dc.isAttemptedByChallenger == True:
                            if dc.challenger == student:
                                challenger_name = student.name
                                winning_status = 'Active'

                                if dc.isAcceptedByCompetitor == True:
                                    competitor_name = dc.competitor.name

                                else:
                                    competitor_name = None

                            else:
                                challenger_name = dc.challenger.name
                                competitor_name = student.name
                                winning_status = None

                        else:
                            challenger_name = student.name
                            competitor_name = None
                            winning_status = None

                        inprogress_dc_dict = {
                            'challenge_status':'In-Progress',
                            'challenge_id':dc.id,
                            'course_logo':course.logo,
                            'course_name':course.name,
                            'subject_name':dc.subject.name,
                            'title':dc.title,
                            'challenger_name':challenger_name,
                            'competitor_name':competitor_name,
                            'winner_name':None,
                            'entry_amt':str(dc.entryAmt),
                            'winning_amt':str(dc.winningAmt),
                            'winning_status':winning_status,
                            'created_date':get_date_in_particular_format(local_created_timestamp),
                            'active_time_left':dc_active_time_left,
                            'completed_timestamp':None
                        }

                        if winning_status is None:
                            inprogress_dc_list.append(inprogress_dc_dict)

                        else:
                            inprogress_active_dc_list.append(inprogress_dc_dict)

                inprogress_dc_list = sorted(inprogress_dc_list, key=lambda i: i['active_time_left'])
                inprogress_active_dc_list = sorted(inprogress_active_dc_list, key=lambda i: i['active_time_left'])
                inprogress_dc_list += inprogress_active_dc_list 

            free_inprogress_dc_list = []

            if free_duos_challenges.exists():
                for fdc in free_duos_challenges:
                    local_created_timestamp = get_local_from_utc(fdc.createdTimestamp)
        
                    local_active_timestamp = get_local_from_utc(fdc.activeTimestamp)
                    fdc_active_time_left = local_active_timestamp - get_local_from_utc(get_current_utc())
                    # fdc_active_time_left_next = fdc_active_time_left.__str__().split(".")[0]
                    if fdc_active_time_left>dt.timedelta():
                        fdc_active_time_left = fdc_active_time_left.__str__().split(".")[0]
                
                        free_inprogress_dc_dict = {
                            'challenge_status':'In-Progress',
                            'challenge_id':fdc.id,
                            'course_logo':course.logo,
                            'course_name':course.name,
                            'subject_name':fdc.subject.name,
                            'title':fdc.title,
                            'challenger_name':'TestWin',
                            'competitor_name':student.name,
                            'winner_name':None,
                            'entry_amt':'FREE',
                            'winning_amt':str(fdc.winningAmt),
                            'winning_status':None,
                            'created_date':get_date_in_particular_format(local_created_timestamp),
                            'active_time_left':fdc_active_time_left,
                            'completed_timestamp':None
                        }

                        free_inprogress_dc_list.append(free_inprogress_dc_dict)

                free_inprogress_dc_list = sorted(free_inprogress_dc_list, key=lambda i: i['active_time_left'])

                inprogress_dc_list = free_inprogress_dc_list + inprogress_dc_list

            context = {
                'status':'Success',
                'message':'Here are in-progress duos challenges list!',
                'in-progress_duos_challenges':inprogress_dc_list
            }
                        
        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)

class GetCompletedDuosChallenges(APIView):
    def get(self, request, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')
            course_name = request.META.get('HTTP_COURSE_NAME')

            student = Student.objects.get(phoneNumber=phoneNo)

            student_language = Language.objects.get(
                studentsInParticularLanguage=student
            )

            course = Course.objects.get(
                name=course_name, 
                courseLanguage=student_language
            )

            completed_dc = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger',
                'competitor',
                'winner'
            ).filter(
                Q(course=course)
                &
                Q(Q(challenger=student) | Q(competitor=student))
                &
                Q(isActive=False)
                &
                Q(isThisFreeChallenge=False)
            ).distinct()

            free_completed_dc = DuosChallenge.objects.prefetch_related(
                'subject',
                'challenger'
            ).filter(
                course=course,
                isActive=False,
                isThisFreeChallenge=True,
                competitor=student
            ).distinct()

            completed_dc_list = []

            if completed_dc.exists():
                for cdc in completed_dc:
                    if cdc.winner is not None:
                        if cdc.winner == student:
                            winning_status = 'Won'

                        else:
                            winning_status = 'Lost'

                    else:
                        winning_status = 'Tied'

                    local_created_timestamp = get_local_from_utc(cdc.createdTimestamp)

                    local_completed_timestamp = get_formatted_timestamp(get_local_from_utc(cdc.completedTimestamp), False)

                    completed_dc_dict = {
                        'challenge_status':'Completed',
                        'challenge_id':cdc.id,
                        'course_logo':course.logo,
                        'course_name':course.name,
                        'subject_name':cdc.subject.name,
                        'title':cdc.title,
                        'challenger_name':cdc.challenger.name,
                        'competitor_name':cdc.competitor.name,
                        'winner_name':cdc.winner.name,
                        'entry_amt':str(cdc.entryAmt),
                        'winning_amt':str(cdc.winningAmt),
                        'winning_status':winning_status,
                        'created_date':get_date_in_particular_format(local_created_timestamp),
                        'active_time_left':None,
                        'completed_timestamp':local_completed_timestamp
                    }

                    completed_dc_list.append(completed_dc_dict)
            
            free_completed_dc_list = []
    
            if free_completed_dc.exists():
                for fcdc in free_completed_dc:
                    local_created_timestamp = get_local_from_utc(fcdc.createdTimestamp)
        
                    local_completed_timestamp = get_formatted_timestamp(get_local_from_utc(fcdc.completedTimestamp), False)

                    free_completed_dc_dict = {
                        'challenge_status':'Completed',
                        'challenge_id':fcdc.id,
                        'course_logo':course.logo,
                        'course_name':course.name,
                        'subject_name':fcdc.subject.name,
                        'title':fcdc.title,
                        'challenger_name':'TestWin',
                        'competitor_name':student.name,
                        'winner_name':student.name,
                        'entry_amt':'FREE',
                        'winning_amt':str(fcdc.winningAmt),
                        'winning_status':'Won',
                        'created_date':get_date_in_particular_format(local_created_timestamp),
                        'active_time_left':None,
                        'completed_timestamp':local_completed_timestamp
                    }

                    free_completed_dc_list.append(free_completed_dc_dict)

                completed_dc_list += free_completed_dc_list

            completed_dc_list = sorted(completed_dc_list, key=lambda i: i['completed_timestamp'], reverse=True)

            context = {
                'status':'Success',
                'message':'Here are completed duos challenges list!',
                'completed_duos_challenges':completed_dc_list
            }
                        
        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

        return Response(context)


class JoinDuosChallenge(APIView):
    @transaction.atomic
    def patch(self, request, challenge_id=None, *args, **kwargs):
        sid = transaction.savepoint()
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')

            #dc stands for duos challenge
            dc_challenge_data = request.data
            dc_challenge_id = dc_challenge_data['challenge_id']

            student = Student.objects.get(phoneNumber=phoneNo)

            if student.accessTestWinApp == True:
               if DuosChallenge.objects.filter(id=dc_challenge_id).exists():
                  dc = DuosChallenge.objects.get(id=dc_challenge_id)

                  if dc.isActive == True:
                     if dc.isPublish == True and dc.isAttemptedByChallenger == True:
                        entry_amt = dc.entryAmt

                        if entry_amt != 0:
                                 if dc.isAcceptedByCompetitor == False:
                                    wallet=PruvaAICoinsWallet.objects.get(student=student)
                                    if entry_amt>wallet.pruvaAICoin:
                                       context = {
                                          'status':'Failed!',
                                          'message':"Insuffcient wallet coins please add coins to join challenge"
                                       }
                                       return Response(context)

                                    else:
                                       rem_coins=wallet.pruvaAICoin-entry_amt
                                       wallet.pruvaAICoin=rem_coins
                                       wallet.save(
                                       update_fields=[
                                          'pruvaAICoin'
                                       ]
                                       )

                                       #sbawth stands for Student Bonus Amt Wallet Transaction History
                                       spaiwth = StudentPAICoinsWalletTransactionHistory.objects.create(
                                             student = student,
                                             coinsTransacted = entry_amt,
                                             PAIcTransactionStatus = 'DR',
                                             description = "Deducted for Joining " + dc.chapter.name + " Duos Challenge"
                                         )


                                        
                                       dc.isAcceptedByCompetitor = True
                                       dc.competitor = student
                                       dc.save(
                                           update_fields=[
                                               'isAcceptedByCompetitor',
                                               'competitor'
                                           ]
                                       )
                        
                                       context = {
                                            'status':'Success',
                                            'message':'You have successfully joined the duos challenge',
                                            'student_name':student.name,
                                            'entry_amt_deducted':str(entry_amt)
                                       }

                                       transaction.savepoint_commit(sid)
                                 else:
                                    raise Exception("Another student has already accepted this duos challenge")
                        else:
                           dc.isAcceptedByCompetitor = True
                           dc.competitor = student
                           dc.save(
                               update_fields=[
                                   'isAcceptedByCompetitor',
                                   'competitor'
                               ]
                           )
                           context = {
                               'status':'Success',
                               'message':'You have successfully joined the duos challenge',
                               'student_name':student.name,
                               'entry_amt_deducted':str(0)
                           }

                           transaction.savepoint_commit(sid)
                     else:
                        raise Exception("Duos Challenge is not published or not attempted by challenger")     

                  else:
                        raise Exception("We regret to inform you this duos challenge is completed")

               else:
                    raise Exception("Duos Challenge Does Not Exist!")

            else:
                raise Exception("Your app is not updated, please update it to keep learning, playing, and earning")

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }
            transaction.savepoint_rollback(sid)
        return Response(context)

class GetIndividualChallengeQuestionsDetail(APIView):
    def get(self, request, challenge_id=None, *args, **kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')
            challenge_id = request.META.get('HTTP_CHALLENGE_ID')
            challenge_type = request.META.get('HTTP_TYPE')

            student = Student.objects.get(phoneNumber=phoneNo)

            if DuosChallenge.objects.filter(id=challenge_id).exists() and challenge_type == 'D':

                #dc stands for duos challenge
                dc = DuosChallenge.objects.prefetch_related('quesInChallenge').get(id=challenge_id)

                ques_list = []

                for ques in dc.quesInChallenge.all():
                    options = Option.objects.filter(ques=ques).values('id', 'optionText', 'optionImg')

                    ques_dict = {
                        'ques_id':ques.id,
                        'ques_text':ques.statement,
                        'ques_img':ques.quesImg,
                        'ques_time':str(int(ques.quesTime.total_seconds())),
                        'options':options
                    }

                    ques_list.append(ques_dict)

                context = {
                    'status':'Success',
                    'message':'Here are duos challenge questions details!',
                    'duos_challenge_id':challenge_id,
                    'challenge_time':str(int(dc.challengeTime.total_seconds())),
                    'total_marks':dc.totalMarks,
                    'questions':ques_list
                }

            else:
                context = {
                    'status':'Failed!',
                    'message':'Challenge Does Not Exist!'
                }

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }
        return Response(context)