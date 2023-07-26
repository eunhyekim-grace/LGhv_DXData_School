from django.db import models

# Create your models here.
class Item(models.Model):
    itemid = models.CharField(max_length = 50, primary_key = True)
    itemname = models.CharField(max_length = 50)
    price = models.IntegerField()
    description = models.CharField(max_length=50)
    pictureurl = models.CharField(max_length=50)

# class Client(models.Model):
#     clientid = models.IntegerField(auto_created = True, primary_key = True) #auto_increment == auto_created ?
#     clientname = models.CharField(max_length = 50)
#     clienttel = models.CharField(max_length = 11)
#     clientaddr = models.CharField(max_length = 50)