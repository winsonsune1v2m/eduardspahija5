from django.db import models
from app_auth.models import User
from app_asset.models import Host
# Create your models here.

class DB(models.Model):
    db_name = models.CharField(max_length=256,null=False)
    db_host = models.ForeignKey(to=Host,on_delete=models.CASCADE)
    db_port = models.CharField(max_length=32,default=3306)
    db_user = models.CharField(max_length=32,null=False)
    db_passwd = models.CharField(max_length=256,null=True)
    db_env = models.CharField(max_length=16,default='测试')
    db_status = models.CharField(max_length=16,null=True)
    db_msg = models.CharField(max_length=512,null=True)
    user = models.ForeignKey(to=User,on_delete=models.SET_NULL,null=True)
    def __unicode__(self):
        return self.db_name

class Inception(models.Model):
    inc_title = models.CharField(max_length=128, null=False)
    inc_option = models.CharField(max_length=64,default="ON/OFF")
    inc_default = models.CharField(max_length=64)
    inc_msg = models.TextField()
    inc_value = models.CharField(max_length=64)
    def __unicode__(self):
        return self.inc_title

class IncDB(models.Model):
    inc_ip = models.CharField(max_length=128,unique=True,null=False)
    inc_port = models.CharField(max_length=32,null=False)
    def __unicode__(self):
        return self.inc_ip

class BackDb(models.Model):
    back_db_ip = models.CharField(max_length=128,null=False)
    back_db_port = models.CharField(max_length=128, null=False)
    back_db_user = models.CharField(max_length=128, null=False)
    back_db_passwd = models.CharField(max_length=128, null=False)
    def __unicode__(self):
        return self.back_db_ip

class WorkOrderLog(models.Model):
    db = models.ForeignKey(to=DB,on_delete=models.SET_NULL,null=True)
    sql = models.TextField(null=False)
    msg = models.TextField(null=True)
    review_user = models.ForeignKey(to=User,on_delete=models.SET_NULL,null=True)
    from_user  = models.CharField(max_length=128, null=False)
    inc_status = models.TextField(null=True)
    status = models.CharField(max_length=128, null=False)
    exec_result = models.TextField(null=True)
    rollback_status = models.TextField(null=True)
    create_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.db.db_name

