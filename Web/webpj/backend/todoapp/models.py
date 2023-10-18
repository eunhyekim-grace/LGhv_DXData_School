from django.db import models

# Create your models here.
from django.db import models


class Todo(models.Model):
    id = models.AutoField(primary_key= True) #Auto_increment
    userid = models.CharField(max_length=100)
    title = models.CharField(max_length=100)
    done = models.BooleanField() 
    regdate = models.DateTimeField(auto_now_add = True) #default로 현재 날짜 시각 들어가게 하기
    moddate = models.DateTimeField(null = True)
    #deleteField 생성해서 휴면 계정 관리 
    #delete = models.BooleanField()