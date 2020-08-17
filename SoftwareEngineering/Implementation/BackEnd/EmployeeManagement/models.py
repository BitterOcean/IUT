from django.db import models
import uuid
from PayslipManagement.models import Payslip
import secrets

class Employee(models.Model):
	ID 			  = models.UUIDField(primary_key=True,default=uuid.uuid4, editable=False, unique=True)
	Name  		  = models.CharField(max_length=100)
	LastName 	  = models.CharField(max_length=100)
	CompanyID 	  = models.ForeignKey('CompanyManagement.Company',on_delete=models.CASCADE,default=0)
	PersonnelCode = models.DecimalField(max_digits=10, decimal_places=0, unique=True)
	Password	  = models.CharField(max_length=10,blank=False, null=False, default='1234')
	AccountNumber = models.DecimalField(max_digits=16, decimal_places=0,)
	PhoneNumber   = models.DecimalField(max_digits=10, decimal_places=0,)
	EmailAddress  = models.EmailField(max_length=254)
	Token 		  = models.CharField(max_length=16,blank=True, null=True)

	def Employee_SetToken(self):
		self.Token = secrets.token_hex(8)
		self.save()

	def Employee_DeleteToken(self):
		self.update(Token=None)

	def Employee_GetPayslip(self,date):
		return Payslip.objects.get(Date=date,EmployeeID=self.ID).Payslip_Show()

	# Not needed for now :)
	# def Employee_GetReport(self):
	# 	pass

	def Employee_Create(self,name,lastname,companyid,personnelcode,accountnumber,phonenumber,email):
		employee = Employee(
							Name=name,
							LastName=lastname,
							CompanyID=companyid,
							PersonnelCode=personnelcode,
							AccountNumber=accountnumber,
							PhoneNumber=phonenumber,
							EmailAddress=email
							)
		employee.save()

	def Employee_Edit(self,filed,newValue):
		self.update(filed=newValue)

	def Employee_GetProfile(self):
		return {
				'ID':self.ID,
				'Name':self.name,
				'LastName':self.LastName,
				'PersonnelCode':self.PersonnelCode,
				'AccountNumber':self.AccountNumber,
				'PhoneNumber':self.PhoneNumber,
				'EmailAddress':self.EmailAddress
				}


def Employee_CountEmployees(companyID):
	Employee.objects.filter(CompanyID=companyID).count()
