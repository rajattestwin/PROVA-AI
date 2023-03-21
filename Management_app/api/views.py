from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.db import transaction

# Create your views here.
class AdminCreateSuperuser(APIView):
    @transaction.atomic
    def post(self, request, *args, **kwargs):
        sid = transaction.savepoint()
        try:
            superuser_data = request.data
            username = superuser_data['username']
            emailID = superuser_data['email_id']
            password = superuser_data['password']

            user = User.objects.create_superuser(
                username = username, 
                email = emailID,
                password = password
            )

            context = {
                'status':'Success',
                'message':'Superuser Created Successfully',
                'username':user.username,
            }

            transaction.savepoint_commit(sid)

        except Exception as e:
            context = {
                'status':'Failed!',
                'message':str(e)
            }

            transaction.savepoint_rollback(sid)

        return Response(context)