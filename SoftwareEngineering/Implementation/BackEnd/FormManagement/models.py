from django.db import models
from django.contrib.postgres.fields import ArrayField
import uuid
#from CompanyManagement.models import Company

class Form(models.Model):
    ID        = models.UUIDField(primary_key=True,default=uuid.uuid4, editable=False, unique=True)
    CompanyID = models.ForeignKey('CompanyManagement.Company',on_delete=models.CASCADE,default=0)
    Field     = ArrayField(models.CharField(max_length=100))

    def Form_AddField(self,name,type):
        fields=self.Field
        a=name+":"+str(type)
        fields.append(a)
        self.Field=fields
        self.save()

    def Form_EditField(self,id,name):
        fields=self.Field
        splitfield=(fields[id]).split(":")
        a=name+":"+splitfield[1]
        fields[id]=a
        self.Field=fields
        self.save()

    def Form_DeleteField(self,id):
        fields=self.Field
        del fields[id]
        self.Field=fields
        self.save()

    def Form_GetForm(self):
        formlist=[]
        fields=self.Field
        for field in fields:
            splitfield=field.split(":")
            formlist.append(splitfield)
        return formlist
