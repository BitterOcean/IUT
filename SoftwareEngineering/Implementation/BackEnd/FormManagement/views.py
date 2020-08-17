from django.shortcuts import render
from django.http import JsonResponse
from .models import Form
from ManagerManagement.models import Manager
from EmployeeManagement.models import Employee

def addfield_view(request,name,type,token,id):
	manager = Employee.objects.filter(ID=id).first()
	if manager == None:
		return JsonResponse({'ACK':0,'status':404}) # user not found
	elif manager.Token != token:
		return JsonResponse({'ACK':0,'status':403}) # user is not authorized
	else:
		form = Form.objects.filter(CompanyID=manager.CompanyID).first()
		if form == None:
			return JsonResponse({'ACK':0,'status':404}) # form not found
		else:
			form.Form_AddField(name=name,type=type)
			return JsonResponse({'ACK':1,'status':200})


def editfield_view(request,name,index,token,id):
	manager = Employee.objects.filter(ID=id).first()
	if manager == None:
		return JsonResponse({'ACK':0,'status':404}) # user not found
	elif manager.Token != token:
		return JsonResponse({'ACK':0,'status':403}) # user is not authorized
	else:
		form = Form.objects.filter(CompanyID=manager.CompanyID).first()
		if form == None:
			return JsonResponse({'ACK':0,'status':404}) # form not found
		else:
			form.Form_EditField(name=name,id=index)
			return JsonResponse({'ACK':1,'status':200})


def deletefield_view(request,index,token,id):
	manager = Employee.objects.filter(ID=id).first()
	if manager == None:
		return JsonResponse({'ACK':0,'status':404}) # user not found
	elif manager.Token != token:
		return JsonResponse({'ACK':0,'status':403}) # user is not authorized
	else:
		form = Form.objects.filter(CompanyID=manager.CompanyID).first()
		if form == None:
			return JsonResponse({'ACK':0,'status':404}) # form not found
		else:
			form.Form_DeleteField(id=index)
			return JsonResponse({'ACK':1,'status':200})


def showform_view(request,token,id):
	manager = Employee.objects.filter(ID=id).first()
	if manager == None:
		return JsonResponse({'ACK':0,'status':404}) # user not found
	elif manager.Token != token:
		return JsonResponse({'ACK':0,'status':403}) # user is not authorized
	else:
		form = Form.objects.filter(CompanyID=manager.CompanyID).first()
		if form == None:
			return JsonResponse({'ACK':0,'status':404}) # form not found
		else:
			formlist = form.Form_GetForm()
			output = {'status':200}
			i = 0
			output['count'] = len(formlist)
			output['fields']={}
			for field in formlist:
				output['fields'][str(i)] = {
					'name':field[0],
					'type':field[1]
		        	}
				i=i+1
			return JsonResponse(output)
