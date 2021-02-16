from django.db import models
from User.models import UserModel
# Create your models here.

class AnswerModel(models.Model):
    answered_by = models.ForeignKey(UserModel,on_delete=models.CASCADE)
    answer = models.CharField(max_length = 1000)

    def __str__(self):
        return str(self.answer[0:10])


class QuestionModel(models.Model):
    question_name = models.CharField(max_length=500)
    asked_by = models.ForeignKey(UserModel,on_delete=models.CASCADE)
    answers = models.ManyToManyField(AnswerModel,blank=True)

    def __str__(self):
        return str(self.question_name[0:20])
