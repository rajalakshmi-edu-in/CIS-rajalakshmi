from django.urls import path, include
from .views import UserSignup, DoctorSignup, Login, Signout

app_name = "User"


urlpatterns = [

    path('signup/',UserSignup,name='signup'),
    path('doctor-signup/',DoctorSignup,name='doctorsignup'),
    path('login/',Login,name='login'),
    path('logout/',Signout,name='logout')


]
