from django.urls import path
from .views import *

urlpatterns = [

   path('get_wallets_balance/', GetWalletsBalance.as_view(), name="Get_Wallets_Student"),
   path('get_wallet_transactions_history/', GetWalletTransactionsHistory.as_view(), name="Get_Wallet_Transactions_History"),
]