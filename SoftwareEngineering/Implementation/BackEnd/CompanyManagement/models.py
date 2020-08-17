from django.db import models
import uuid
from ManagerManagement.models import Manager
from EmployeeManagement.models import Employee

class Company(models.Model):
	ID 			= models.UUIDField(primary_key=True,default=uuid.uuid4, editable=False, unique=True)
	Name 		= models.CharField(max_length=100,)
	MaxEmployee = models.DecimalField(max_digits=10, decimal_places=0,)

	def Company_GetFormID(self):
		form = Form.objects.get(CompanyID=ID)
		return form.ID

	def Company_GetProfile(self,managerID):
		manager = Manager.objects.get(ID=managerID)
		return {'ID':self.ID,'Name':self.name,'Manager':manager.Name,'MaxEmployee':self.MaxEmployee}

	def Company_CheckMaxEmployee(self):
		# it returns 1 mean that manager can add employees
		# and returns 0 mean that manager can not add more employees anymore
		# till she/he buys more accounts
		EmployeeCount_Now = Employee.objects.filter(CompanyID=self.ID).count()
		return EmployeeCount_Now < MaxEmployee
