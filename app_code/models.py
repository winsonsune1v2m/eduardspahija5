from django.db import models
from app_asset.models import Host

# Create your models here.


class Project(models.Model):
    project_name = models.CharField(max_length=32,unique=True)
    project_msg = models.CharField(max_length=64,null=True)
    def __unicode__(self):
        return self.project_name

class GitCode(models.Model):
    git_name = models.CharField(max_length=64,unique=True)
    git_msg = models.CharField(max_length=64, null=True)
    project = models.ForeignKey(to='Project',on_delete=models.SET_NULL,null=True)
    git_url = models.CharField(max_length=128,unique=True)
    git_user = models.CharField(max_length=64, null=True)
    git_passwd = models.CharField(max_length=64, null=True)
    git_sshkey = models.TextField( null=True)
    def __unicode__(self):
        return self.git_name


class Publist(models.Model):
    gitcode = models.ForeignKey(to='GitCode',on_delete=models.CASCADE)
    host_ip = models.ForeignKey(to=Host,on_delete=models.CASCADE)
    publist_dir = models.CharField(max_length=128)
    publist_msg = models.CharField(max_length=128,null=True)
    current_version = models.CharField(max_length=64,unique=True,null=True)
    version_info = models.CharField(max_length=512,null=True)
    author = models.CharField(max_length=64,null=True)
    publist_date = models.CharField(max_length=64,null=True)
    def __unicode__(self):
        return self.gitcode


class PublistRecord(models.Model):
    publist = models.ForeignKey(to='Publist',on_delete=models.CASCADE)
    current_version = models.CharField(max_length=64,null=True)
    version_info = models.CharField(max_length=1024, null=True)
    author = models.CharField(max_length=64, null=True)
    publist_date = models.CharField(max_length=64, null=True)
    def __unicode__(self):
        return self.publist


class Wchartlog(models.Model):
    site_name = models.CharField(max_length=64, null=True)
    from_user = models.CharField(max_length=64, null=True)
    up_connect= models.CharField(max_length=2048, null=True)
    up_id = models.CharField(max_length=64, null=True)
    status = models.CharField(max_length=64, default="waiting")
    add_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.Site_name






