from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from .models import AnswerModel, QuestionModel
# Create your views here.
@login_required(login_url="/user/login")
def QuestionPostView(request):
    context = {}
    if request.method == "POST":
        user = request.user
        if user.is_doctor == False:
            question = request.POST['ques']
            q = QuestionModel(question_name=question,
                                asked_by = user)
            q.save()
            context['success'] = "Successfully Posted Question"
        else:
            context['error'] = "Sign in as Doctor"
    return render(request,"forum/postquestion.html",context)

@login_required(login_url="/user/login")
def QuestionListView(request):
    context = {}
    questions = QuestionModel.objects.all()
    context['questions'] = questions
    return render(request,"forum/list.html",context)

@login_required(login_url="/user/login")
def QuestionDetailView(request,id):
    context = {}
    try:
        question = QuestionModel.objects.get(pk=id)
        context['question'] = question
    except:
        context['error'] = "Question Not Found"
    return render(request,"forum/detail.html",context)



# home page
def indexView(request):
    return render(request,"index.html",{})