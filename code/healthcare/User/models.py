from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from .manager import UserManager
# Create your models here.
class PatientModel(models.Model):
    blood_grp = models.CharField(max_length=3)

    def __str__(self):
        return "Patient "+str(self.id)

class DoctorTypeModel(models.Model):
    type = models.CharField(max_length=30)

    def __str__(self):
        return self.type



class DoctorModel(models.Model):
    hospital = models.CharField(max_length=200)
    experience = models.IntegerField()
    rating = models.IntegerField()
    type = models.ManyToManyField(DoctorTypeModel)

    def __str__(self):
        return "Doctor "+str(self.id)



class UserModel(AbstractBaseUser):
    email = models.EmailField(max_length=70,unique=True)
    name = models.CharField(max_length=50)
    phone = models.CharField(max_length=10)
    doctor = models.OneToOneField(DoctorModel,null=True,on_delete=models.CASCADE,blank=True)
    patient = models.OneToOneField(PatientModel,null=True,blank=True,on_delete=models.CASCADE)

    is_doctor = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name','phone']

    objects = UserManager()

    def __str__(self):
        return self.email

    def has_perm(self,perm,object=None):
        return self.is_admin

    def has_module_perms(self,app_label):
        return True
