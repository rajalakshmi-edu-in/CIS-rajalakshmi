from django.urls import path, include
from .views import QuestionPostView, QuestionListView, QuestionDetailView

urlpatterns = [

    path('postquestion/',QuestionPostView,name='questionpost'),
    path('questionlist/',QuestionListView,name='questionlist'),
    path('questiondetail/<str:id>',QuestionDetailView,name='detail')
]
