from django.shortcuts import render
from django.http import JsonResponse
import json
from .models import Company
from django import forms


class helloForm (forms.Form):
    name=forms.CharField()
    num=forms.DecimalField()

# Create your views here.
def CompanyAdd_view(request,name):
    obj=Company.objects.get(Name=name)
    data={
        'name':obj.Name,
        'max':obj.MaxEmployee
    }
    return JsonResponse(data)
def hello_view(request):
    #form=helloForm(request.GET)
    obj=request.GET.dict()

    return JsonResponse(obj)
