from django.db import models

# Create your models here.


class Role(models.Model):
    """角色表"""
    role_title = models.CharField(max_length=64,unique=True)
    role_msg = models.CharField(max_length=128,null=True)
    perms = models.ManyToManyField(to='Perms')
    menu = models.ManyToManyField(to='Menus',)
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
    img = models.ImageField(upload_to='img',null=True)
    status = models.CharField(max_length=64,default="离线")
    creat_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.user_name


class Menus(models.Model):
    """菜单表"""
    menu_title = models.CharField(max_length=64)
    menu_url = models.CharField(max_length=64,null=True)
    menu_type = models.CharField(max_length=64)
    pmenu_id = models.CharField(max_length=64,null=True)
    menu_num = models.CharField(max_length=32,null=True)
    menu_icon = models.CharField(max_length=256,null=True)
    menu_order = models.CharField(max_length=32,null=True)
    def __unicode__(self):
        return  self.menus_title


class Perms(models.Model):
    """权限表"""
    perms_list = (('get','查'),('post','增'),('delete','删'),('put','改'))
    perms = models.CharField(max_length=64,choices=perms_list)
    perms_msg = models.CharField(max_length=128)
    menus = models.ForeignKey(to="Menus",on_delete=models.CASCADE)
    def __unicode__(self):
        return  self.Perms








