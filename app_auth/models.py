from django.db import models
from app_asset.models import Host,Netwk
from app_code.models import GitCode

# Create your models here.


class Role(models.Model):
    """角色表"""
    role_title = models.CharField(max_length=64,unique=True)
    role_msg = models.CharField(max_length=128,null=True)
    perms = models.ManyToManyField(to='Perms')
    menu = models.ManyToManyField(to='Menus')
    host = models.ManyToManyField(to=Host)
    netwk = models.ManyToManyField(to=Netwk)
    project = models.ManyToManyField(to=GitCode)
    def __unicode__(self):
        return self.role_title


class User(models.Model):
    """用户表"""
    user_name = models.CharField(max_length=32,unique=True)
    ready_name = models.CharField(max_length=64, null=True)
    passwd = models.CharField(max_length=256,null=True)
    email = models.CharField(max_length=64,null=True)
    phone = models.CharField(max_length=128,null=True)
    role = models.ManyToManyField(to="Role")
    img = models.ImageField(upload_to='img',default="/static/img/user/11.jpg")
    status = models.CharField(max_length=64,default="离线")
    creat_time = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now=True)
    def __unicode__(self):
        return self.user_name


class Menus(models.Model):
    """菜单表"""
    menu_title = models.CharField(max_length=64)
    menu_url = models.CharField(max_length=64,unique=True)
    menu_type = models.CharField(max_length=64)
    pmenu_id = models.CharField(max_length=64,null=True)
    menu_num = models.CharField(max_length=32,null=True)
    menu_icon = models.CharField(max_length=256,null=True)
    menu_order = models.CharField(max_length=32,null=True)
    def __unicode__(self):
        return  self.menus_title


class Perms(models.Model):
    """权限表"""
    perms_title = models.CharField(max_length=128)
    perms_req = models.CharField(max_length=64)
    perms_url = models.CharField(max_length=64, null=True,unique=True)
    menus = models.ForeignKey(to="Menus",on_delete=models.CASCADE)
    def __unicode__(self):
        return  self.Perms


class RemoteUser(models.Model):
    lg_user = models.CharField(max_length=64,unique=True)
    lg_passwd = models.CharField(max_length=256,null=True)
    lg_key = models.TextField(null=True)
    lg_key_pass = models.TextField(null=True)
    user = models.ForeignKey(to="User",on_delete=models.CASCADE)

class Key(models.Model):
    """秘钥记录"""
    key_isa = models.TextField(null=True)
    key_isa_pub = models.TextField(null=True)
    key_msg = models.CharField(max_length=64, null=True)
    user = models.ForeignKey(to="User",on_delete=models.SET_NULL,null=True)
    def __unicode__(self):
        return  self.Perms









