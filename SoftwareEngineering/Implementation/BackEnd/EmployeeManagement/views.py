from django.shortcuts import render
from django.http import JsonResponse
from ManagerManagement.models import Manager
from EmployeeManagement.models import Employee

def login_view(request,username,password,company):
	# username == personnelCode
	# password == password
	employee = Employee.objects.filter(PersonnelCode=username,Password=password).first()
	if employee == None:
		return JsonResponse({'Token':'-1','ID':'-1','status':404,'isManager':'-1'}) # user not found
	else:
		if company == employee.CompanyID.Name:
			employee.Employee_SetToken()
			manager = Manager.objects.filter(EmployeeID=employee).first()
			isManager = -1
			if manager != None:
				isManager = 1
			else:
				isManager = 0
			return JsonResponse({'Token':employee.Token,'ID':employee.ID,'status':200,'isManager':isManager})
		else:
			return JsonResponse({'Token':'-1','ID':'-1','status':404,'isManager':'-1'}) # user not found in that company

