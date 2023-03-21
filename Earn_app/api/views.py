from rest_framework.views import APIView
from rest_framework.response import Response
from django.db import transaction

from edtech.helper import *
from Management_app.models import *
from Profile.models import *
from Earn_app.models import *







class GetWalletsBalance(APIView):
    @transaction.atomic
    def get(self, request, *args, **kwargs):
         sid = transaction.savepoint()
         try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')

            student = Student.objects.get(phoneNumber=phoneNo)
            pruvaAIcoinswallet=PruvaAICoinsWallet.objects.get(student=student)
            context = {
                'status':'Success',
                'message':'Here is the student wallets coins!',
                'student_name':student.name,
                'wallet_balance':pruvaAIcoinswallet.pruvaAICoin,
            }
            transaction.savepoint_commit(sid)
         except PruvaAICoinsWallet.DoesNotExist:
            try:
               pruvaAIcoinswallet=PruvaAICoinsWallet.objects.create(student=student,pruvaAICoin=50)
               context = {
                  'status':'Success',
                  'message':'Here is the student wallets coins!',
                  'student_name':student.name,
                  'wallet_balance':pruvaAIcoinswallet.pruvaAICoin,
               }
               transaction.savepoint_commit(sid)

            except Exception as e:
                context = {
                    'status':'Failed!',
                    'message':str(e)
                }

                transaction.savepoint_rollback(sid)
         except Exception as e:
                context = {
                    'status':'Failed!',
                    'message':str(e)
                }
                transaction.savepoint_rollback(sid)

         return Response(context)

class GetWalletTransactionsHistory(APIView):
    def get(self,request,*args,**kwargs):
        try:
            phoneNo = request.META.get('HTTP_PHONE_NUMBER')

            student = Student.objects.get(phoneNumber=phoneNo)

            #spaicwth stands for StudentPruvaAICoinsWalletTransactionHistory
            spaicwth = StudentPAICoinsWalletTransactionHistory.objects.filter(
                student=student
            ).order_by('-id')

            transactions = list(spaicwth)
            wallet_history_list=[]
            for txn in transactions:                
               wallet_history_dict = {
                    'amount_transacted':'Rs.' + str(txn.coinsTransacted),
                    'transaction_status':txn.PAIcTransactionStatus,
                    'description':txn.description,
                    'time':txn.timestamp
                }
               wallet_history_list.append(
                wallet_history_dict
            )

            context = {
                'status':'Success',
                'message':'Here is student wallet transaction history!',
                'student_name':student.name,
                'wallet_history':wallet_history_list
            }

        except Exception as e:
            context = {
                    'status':'Failed!',
                    'message':str(e)
                }

        return Response(context)
