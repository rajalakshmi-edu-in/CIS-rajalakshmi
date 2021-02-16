from django.db import models
from User.models import UserModel
# Create your models here.
class AppointmentModel(models.Model):
    patient = models.OneToOneField(UserModel,blank=True,on_delete=models.CASCADE,null=True)
    description = models.CharField(max_length=800)
    doctor = models.ForeignKey(UserModel,blank=True,on_delete=models.CASCADE,null=True,related_name="+")
    is_confirmed = models.BooleanField(default=False)
    datetime = models.DateTimeField(blank=True,null=True)

    def __str__(self):
        return str(self.patient)+" to "+str(self.doctor)
