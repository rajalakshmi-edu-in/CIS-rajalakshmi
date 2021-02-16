from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from .models import AppointmentModel
from .forms import AppointmentCreateForm, ConfirmAppointment
from django.http import HttpResponse
from User.models import UserModel, DoctorTypeModel, DoctorModel
from django.core.mail import send_mail


# Create your views here.
@login_required(login_url="/user/login")
def CreateAppointment(request,id):
    UserObject = request.user
    if UserObject.is_doctor == False:
        if request.method == "POST":
            description = request.POST['desc']
            patient = UserObject
            try:
                doctor = UserModel.objects.get(pk=id)
                print("Doctor exist")
            except:
                print("Doctor Doesn't exist")

            try:
                AppointObject = AppointmentModel(patient=patient,
                                                doctor = doctor,
                                                description = description
                                                )
                AppointObject.save()
            except:
                return HttpResponse("Patient already has a prior appointment")
        else:
            print("method is not post")
        return HttpResponse("Success")

@login_required(login_url="/user/login")
def ListDoctors(request):
    types_obj = DoctorTypeModel.objects.all()
    context = {}
    context['types'] = types_obj
    if request.method == "POST":
        search_type = request.POST['type']
        doctors = UserModel.objects.filter(is_doctor=True,doctor__type = search_type)
        context['doctor'] = doctors
    return render(request,"appoint/list.html",context)


@login_required(login_url="/user/login/")
def DetailDoctors(request,id):
    context = {}
    try:
        doctor = UserModel.objects.get(pk=id)
        context['doctor'] = doctor
    except:
        context['error'] = "Doctor Not found"

    return render(request,"appoint/Details.html",context)

@login_required(login_url="/user/login/")
def DoctorNotification(request):
    context = {}
    user = request.user
    if user.is_doctor == True:
        appointments = AppointmentModel.objects.filter(doctor=user,is_confirmed=False)
        confirmed_appointments = AppointmentModel.objects.filter(doctor=user,is_confirmed=True)
        context['confirmed'] = confirmed_appointments
        context['appointments'] = appointments
        context['form'] = ConfirmAppointment()
    else:
        return HttpResponse("Only Doctors Allowed")
    return render(request,"appoint/notifications.html",context)


@login_required(login_url="/user/login/")
def Confirmed(request,id):
    context = {}
    date = request.POST['date']
    time = request.POST['time']
    if request.method == "POST":
        AppointmentModel.objects.filter(pk=id).update(is_confirmed=True,
                                                    datetime = str(date)+" "+str(time))
        #send_mail("Regarding Appointment",str(AppointmentModel.objects.filter(pk=id)[0].doctor.name)+" has given an appointment to you on "+str(AppointmentModel.objects.filter(pk=id)[0].datetime)+"\nThank you","ashwinprasad202@gmail.com",[str(AppointmentModel.objects.filter(pk=id)[0].patient.email)],fail_silently=False)
    return redirect("/appointment/notification")


@login_required(login_url="/user/login/")
def MarkCompleted(request,id):
    context = {}
    if request.method == "POST":
        app_obj = AppointmentModel.objects.filter(pk=id)
        exp = app_obj[0].doctor.doctor.experience + 1
        DoctorModel.objects.filter(id=app_obj[0].doctor.doctor.id).update(experience = exp)
        app_obj[0].delete()

    return redirect("/appointment/notification")
