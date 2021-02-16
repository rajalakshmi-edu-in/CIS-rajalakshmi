from django.contrib import admin
from .models import AnswerModel, QuestionModel
# Register your models here.
admin.site.register(AnswerModel)
admin.site.register(QuestionModel)
