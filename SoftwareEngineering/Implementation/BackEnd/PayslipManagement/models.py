from django.db import models
from django.contrib.postgres.fields import JSONField
import uuid

class Payslip(models.Model):
	PayslipID  		 = models.UUIDField(primary_key=True,default=uuid.uuid4, editable=False, unique=True)
	CompanyID  		 = models.ForeignKey('CompanyManagement.Company',on_delete=models.CASCADE,default=0)
	Date 	   		 = models.CharField(max_length=8, blank=True, null=True)
	EmployeeID 		 = models.ForeignKey('EmployeeManagement.Employee',on_delete=models.CASCADE,default=0)
	LastModifiedDate = models.CharField(max_length=8, blank=True, null=True)
	Data 			 = JSONField()

	def Payslip_Add(compID,employeeID,date,data):
		payslip = Payslip(CompanyID=compID,Date=date,EmployeeID=employeeID,LastModifiedDate="time",Data=data)
		payslip.save()

	def Payslip_Edit(self,payslipID,data):
		self.Data=data
		self.save()

	def Payslip_Show(self):
		return self.Data
