from django.db import models

# Create your models here.

class OpsLog(models.Model):
    host_ip = models.CharField(max_length=32)
    hostname = models.CharField(max_length=64, null=True)
    user_name = models.CharField(max_length=64)
    start_time = models.CharField(max_length=64)
    audit_log = models.TextField()
    def __unicode__(self):
        return self.host_ip

class UserLog(models.Model):
    user_name = models.CharField(max_length=32)
    ready_name = models.CharField(max_length=32)
    url_title = models.CharField(max_length=64)
    status = models.CharField(max_length=32)
    create_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.username
