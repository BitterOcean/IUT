"""Payslip URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from CompanyManagement.views import CompanyAdd_view,hello_view
from ManagerManagement.views import EmployeeList_view,DeletePayslip_view,ShowPayslip_view,AddPayslipManual_view,EditPayslip_view,Getemployeeinfo_view
from FormManagement.views import addfield_view,editfield_view,deletefield_view,showform_view
from EmployeeManagement.views import login_view

urlpatterns = [
    path('admin/', admin.site.urls),
    path('employeelist/<str:token>/<uuid:id>/', EmployeeList_view,name='EmployeeList'),
    path('getemployeeinfo/<int:personnelCode>/<str:token>/<uuid:id>/',Getemployeeinfo_view,name='Getemployeeinfo'),
    path('deletepayslip/<uuid:payslipID>/<str:token>/<uuid:id>/',DeletePayslip_view,name='DeletePayslip'),
    path('showpayslip/<uuid:employeeID>/<str:date>/<str:token>/<uuid:id>/',ShowPayslip_view,name='ShowPayslip'),
    path('getcompany/<str:name>/',CompanyAdd_view,name='CompanyAdd'),
    path('getcompany/<str:name>/',CompanyAdd_view,name="CompanyAdd"),
    path('addfield/<str:name>/<int:type>/<str:token>/<uuid:id>/',addfield_view,name="AddField"),
    path('editfield/<int:index>/<str:name>/<str:token>/<uuid:id>/',editfield_view,name="EditField"),
    path('deletefield/<int:index>/<str:token>/<uuid:id>/',deletefield_view,name="DeleteField"),
    path('showform/<str:token>/<uuid:id>/',showform_view,name="ShowForm"),
    path('login/<int:username>/<str:password>/<str:company>/', login_view, name="Login"), # username = personnelCode / password = password
    path('addpayslipmanual/',AddPayslipManual_view,name="AddPayslipManual"),
    path('editpayslip/',EditPayslip_view,name="EditPayslip"),
    path('hello/',hello_view,name="hello"),
]
