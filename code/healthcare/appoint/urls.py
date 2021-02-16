from django.urls import path, include
from .views import ListDoctors, DetailDoctors, CreateAppointment, DoctorNotification, Confirmed, MarkCompleted

urlpatterns = [
    path('list/',ListDoctors,name='doctorslist'),
    path('detail/<int:id>',DetailDoctors,name='detaildoc'),
    path('create/<int:id>',CreateAppointment,name='create'),
    path('notification/',DoctorNotification,name='notification'),
    path('confirmed/<int:id>',Confirmed,name="confirmed"),
    path('markcomplete/<int:id>',MarkCompleted,name='complete')
]
