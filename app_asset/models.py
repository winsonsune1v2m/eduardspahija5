from django.db import models

# Create your models here.

class Host(models.Model):
    """服务器基本信息"""
    host_ip = models.CharField(max_length=64,unique=True)
    host_remove_port = models.CharField(max_length=64,null=True)
    host_user = models.CharField(max_length=128)
    host_passwd = models.CharField(max_length=256)
    host_type = models.CharField(max_length=64)
    group = models.ForeignKey(to="HostGroup",on_delete=models.SET_NULL,null=True)
    idc = models.ForeignKey(to="IDC", on_delete=models.SET_NULL, null=True)
    host_msg = models.CharField(max_length=256)
    serial_num = models.CharField(max_length=256,null=True)
    supplier = models.ForeignKey(to="Supplier",on_delete=models.SET_NULL,null=True)
    purchase_date = models.CharField(max_length=128,null=True)
    overdue_date = models.CharField(max_length=128,null=True)
    creat_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.host_ip



class Netwk(models.Model):
    """网络设备基本信息"""
    netwk_ip = models.CharField(max_length=64,unique=True)
    netwk_remove_port = models.CharField(max_length=64, null=True)
    netwk_user = models.CharField(max_length=128)
    netwk_passwd = models.CharField(max_length=256)
    netwk_type = models.CharField(max_length=64)
    group = models.ForeignKey(to="HostGroup",on_delete=models.SET_NULL,null=True)
    idc = models.ForeignKey(to="IDC", on_delete=models.SET_NULL, null=True)
    netwk_msg = models.CharField(max_length=256)
    serial_num = models.CharField(max_length=256, null=True)
    supplier = models.ForeignKey(to="Supplier", on_delete=models.SET_NULL, null=True)
    purchase_date = models.CharField(max_length=128, null=True)
    overdue_date = models.CharField(max_length=128, null=True)
    creat_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.host_ip


class HostGroup(models.Model):
    """分组信息"""
    host_group_name = models.CharField(max_length=64,unique=True)
    host_group_msg = models.CharField(max_length=256,null=True)
    def __unicode__(self):
        return self.host_group_name


class IDC(models.Model):
    """机房管理信息"""
    idc_name = models.CharField(max_length=64, unique=True)
    idc_msg = models.CharField(max_length=128, null=True)
    idc_admin = models.CharField(max_length=128, null=True)
    idc_admin_phone = models.CharField(max_length=128, null=True)
    idc_admin_email = models.CharField(max_length=128, null=True)
    def __unicode__(self):
        return self.idc_name


class Supplier(models.Model):
    supplier = models.CharField(max_length=256, null=True)
    supplier_head = models.CharField(max_length=128, null=True)
    supplier_head_phone = models.CharField(max_length=128, null=True)
    supplier_head_email = models.CharField(max_length=128, null=True)
    def __unicode__(self):
        return self.supplier





