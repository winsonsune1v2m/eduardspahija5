from django.db import models

# Create your models here.


class Role(models.Model):
    """角色表"""
    role_title = models.CharField(max_length=64,unique=True)
    role_msg = models.CharField(max_length=128,null=True)
    perms = models.TextField(null=True)
    menu = models.ManyToManyField(to='Menus',)
    def __unicode__(self):
        return self.role_title


class User(models.Model):
    """用户表"""
    user_name = models.CharField(max_length=32)
    ready_name = models.CharField(max_length=64, null=True)
    passwd = models.CharField(max_length=256,null=True)
    email = models.CharField(max_length=64,null=True)
    phone = models.CharField(max_length=128,null=True)
    role = models.ManyToManyField(to="Role")
    img = models.ImageField(upload_to='img')
    status = models.CharField(max_length=64,null=True)
    creat_time = models.DateTimeField(auto_now_add=True)

    def __unicode__(self):
        return self.user_name


class Menus(models.Model):
    """菜单表"""
    menus_title = models.CharField(max_length=64)
    menus_url = models.CharField(max_length=64)
    parent = models.ForeignKey("Menus", null=True, on_delete=models.SET_NULL)
    menus_id = models.CharField(max_length=32,null=True)
    menus_icon = models.CharField(max_length=256,null=True)
    menus_perms = models.ManyToManyField(to="Perms")
    def __unicode__(self):
        return  self.menus_title


class Perms(models.Model):
    """权限表"""
    Perms = models.CharField(max_length=64)
    Perms_msg = models.CharField(max_length=128)
    def __unicode__(self):
        return  self.Perms








