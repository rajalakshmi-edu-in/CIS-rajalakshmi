from django import forms
from .models import AppointmentModel

class AppointmentCreateForm(forms.ModelForm):
    class Meta:
        model = AppointmentModel
        fields = ('patient','description','doctor')

class ConfirmAppointment(forms.Form):
    datetime = forms.DateTimeField(label='datetime',widget=forms.DateTimeInput(format='%d/%m/%Y %H:%M'))
