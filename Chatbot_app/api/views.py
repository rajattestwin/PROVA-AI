from rest_framework.views import APIView
from rest_framework.response import Response


from edtech.helper import *
from Management_app.models import *
from Profile.models import *
from Content_app.models import *
from Challenge_Analytics_app.models import *
from Earn_app.models import *
from Play_app.models import *

import openai,os

# Create your views here.
openai.api_key='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'
class GetSolution(APIView):
   def post(self, request, *args, **Kwargs):
         try:
            que=request.data['que']
            soln_type=request.data['type']
            if soln_type=='H':
               response = openai.Completion.create(
                 engine='text-davinci-003',
                 prompt=(f"Conversation:\nHuman:Explain this question {que}\nAI:"),
                 max_tokens=2000,
                 n=1,
                 stop=None,
                 temperature=0.7,
             )
            else:
               response = openai.Completion.create(
                 engine='text-davinci-003',
                 prompt=(f"Conversation:\nHuman:Explain this question in easier language {que}\nAI:"),
                 max_tokens=2000,
                 n=1,
                 stop=None,
                 temperature=0.7,
             ) 
            context={
                    'status':'Success',
                     'response':response.choices[0].text.strip()
               }
         except Exception as e:
                context = {
                    'status':'Failed!', 
                    'message':str(e)
                }
         return Response(context)