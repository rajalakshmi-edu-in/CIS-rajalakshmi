from django.shortcuts import render, redirect
from .models import UserModel, PatientModel, DoctorModel
from passlib.hash import sha256_crypt
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required

# Create your views here.
def UserSignup(request):
    if request.method == "POST":
        name = request.POST['name']
        email = request.POST['email']
        phone = request.POST['phone']
        blood_grp = request.POST['bg']
        password1 = request.POST['password1']
        password2 = request.POST['password2']
        if password1 == password2:
            enc_password = sha256_crypt.hash(password1,rounds=12000,salt_size=16)
            p = PatientModel(blood_grp = blood_grp)
            p.save()
            u = UserModel(name=name,
                        email = email,
                        phone = phone,
                        is_doctor=False,
                        patient = p,
                        password = enc_password
                         )
            u.save()
    return render(request,"User/SignUp.html",{})

def DoctorSignup(request):
    if request.method == "POST":
        name = request.POST['name']
        email = request.POST['email']
        phone = request.POST['phone']
        hospital = request.POST['hospital']
        password1 = request.POST['password1']
        password2 = request.POST['password2']
        if password1 == password2:
            enc_password = sha256_crypt.hash(password1,rounds=12000,salt_size=16)
            d = DoctorModel(hospital = hospital, experience= 0 , rating= 0 )
            d.save()
            u = UserModel(name=name,
                        email = email,
                        phone = phone,
                        is_doctor=True,
                        password = enc_password,
                        doctor = d,
                         )
            u.save()
    return render(request,"User/DoctorSignUp.html",{})

def Login(request):
    context ={}
    if request.method == "POST":
        email = request.POST['email']
        password = request.POST['password']
        user = None
        try:
            user1 = UserModel.objects.get(email=email)
            if sha256_crypt.verify(password,user1.password):
                user = user1
            else:
                context['error'] = "Wrong Password"
        except:
            context["error"] = "User Does not exist"
        if user is not None:
            login(request,user)
        else:
            print("user is none")
    return render(request,"User/login.html",context)

login_required(login_url='/user/login')
def Signout(request):
    logout(request)
    return redirect('/user/login')
