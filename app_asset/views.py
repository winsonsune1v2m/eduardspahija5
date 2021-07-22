import json
from statics.scripts import encryption
from mtrops_v2.settings import SECRET_KEY
from django.shortcuts import render,HttpResponse
from django.views import View
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from app_asset import models as asset_db
# Create your views here.



class IDC(View):
    """机房管理"""
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(IDC,self).dispatch(request, *args, **kwargs)

    def get(self,request):
        title = "IDC 机房"
        idc_obj = asset_db.IDC.objects.all()
        return render(request,'asset_idc.html',locals())

    def post(self,request):
        idc_name = request.POST.get("idc_name")
        idc_msg = request.POST.get("idc_msg")
        idc_admin = request.POST.get("idc_admin")
        idc_admin_phone = request.POST.get("idc_admin_phone")
        idc_admin_email = request.POST.get("idc_admin_email")
        idc_obj = asset_db.IDC(idc_name=idc_name,idc_msg=idc_msg,idc_admin=idc_admin,idc_admin_phone=idc_admin_phone,
                               idc_admin_email=idc_admin_email)
        idc_obj.save()
        data = '机房已添加，请刷新查看！'
        return HttpResponse(data)

    def put(self,request):
        req_info = eval(request.body.decode())
        idc_id = req_info.get("idc_id")
        idc_name = req_info.get("idc_name")
        idc_msg = req_info.get("idc_msg")
        idc_admin = req_info.get("idc_admin")
        idc_admin_phone = req_info.get("idc_admin_phone")
        idc_admin_email = req_info.get("idc_admin_email")
        action = req_info.get("action",None)

        if action:
            """修改IDC信息"""
            idc_obj = asset_db.IDC.objects.get(id=idc_id)
            idc_obj.idc_name = idc_name
            idc_obj.idc_msg = idc_msg
            idc_obj.idc_admin = idc_admin
            idc_obj.idc_admin_phone = idc_admin_phone
            idc_obj.idc_admin_email = idc_admin_email
            idc_obj.save()
            data = "IDC已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            idc_info = asset_db.IDC.objects.get(id=idc_id)
            info_json = {'idc_id': idc_info.id, 'idc_name': idc_info.idc_name, 'idc_msg': idc_info.idc_msg,
                         'idc_admin': idc_info.idc_admin,'idc_admin_phone': idc_info.idc_admin_phone,'idc_admin_email': idc_info.idc_admin_email}
            data = json.dumps(info_json)

        return HttpResponse(data)


    def delete(self,request):
        """删除权限"""
        req_info = eval(request.body.decode())
        idc_id = req_info.get("idc_id")
        asset_db.IDC.objects.get(id=idc_id).delete()
        data = "IDC 已删除,请刷新查看！"
        return HttpResponse(data)


class HostGroup(View):
    """分组管理"""
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(HostGroup,self).dispatch(request, *args, **kwargs)

    def get(self,request):
        title = "主机分组"
        group_obj = asset_db.HostGroup.objects.all()
        return render(request,'asset_group.html',locals())


    def post(self,request):
        group_name = request.POST.get("group_name")
        group_msg = request.POST.get("group_msg")
        group_obj = asset_db.HostGroup(host_group_name=group_name,host_group_msg=group_msg)
        group_obj.save()
        data = '分组已添加，请刷新查看！'
        return HttpResponse(data)

    def put(self,request):
        '''修改分组'''
        req_info = eval(request.body.decode())
        group_id = req_info.get("group_id")
        group_name = req_info.get("group_name")
        group_msg = req_info.get("group_msg")
        action = req_info.get("action",None)

        if action:
            """修改group信息"""
            group_obj = asset_db.HostGroup.objects.get(id=group_id)
            group_obj.host_group_name = group_name
            group_obj.host_group_msg = group_msg
            group_obj.save()
            data = "分组已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            group_info = asset_db.HostGroup.objects.get(id=group_id)
            info_json = {'group_id': group_info.id, 'group_name': group_info.host_group_name, 'group_msg': group_info.host_group_msg}
            data = json.dumps(info_json)

        return HttpResponse(data)


    def delete(self,request):
        """删除分组"""
        req_info = eval(request.body.decode())
        group_id = req_info.get("group_id")
        asset_db.HostGroup.objects.get(id=group_id).delete()
        data = "分组已删除,请刷新查看！"
        return HttpResponse(data)



class Supplier(View):
    """供应商管理"""
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(Supplier,self).dispatch(request, *args, **kwargs)

    def get(self,request):
        title = "设备厂商"
        supplier_obj = asset_db.Supplier.objects.all()
        return render(request,'asset_supplier.html',locals())


    def post(self,request):
        supplier = request.POST.get("supplier")
        supplier_head = request.POST.get("supplier_head")
        supplier_head_phone = request.POST.get("supplier_head_phone")
        supplier_head_email = request.POST.get("supplier_head_email")
        supplier_obj = asset_db.Supplier(supplier=supplier,supplier_head=supplier_head,supplier_head_phone=supplier_head_phone,
                               supplier_head_email=supplier_head_email)
        supplier_obj.save()
        data = '供应商已添加，请刷新查看！'
        return HttpResponse(data)

    def put(self,request):
        req_info = eval(request.body.decode())
        supplier_id = req_info.get("supplier_id")
        supplier = req_info.get("supplier")
        supplier_head = req_info.get("supplier_head")
        supplier_head_phone = req_info.get("supplier_head_phone")
        supplier_head_email = req_info.get("supplier_head_email")
        action = req_info.get("action",None)
        if action:
            """修改supplier信息"""
            supplier_obj = asset_db.Supplier.objects.get(id=supplier_id)
            supplier_obj.supplier = supplier
            supplier_obj.supplier_head = supplier_head
            supplier_obj.supplier_head_phone = supplier_head_phone
            supplier_obj.supplier_head_email = supplier_head_email
            supplier_obj.save()
            data = "供应商已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            supplier_info = asset_db.Supplier.objects.get(id=supplier_id)

            info_json = {'supplier_id': supplier_info.id, 'supplier': supplier_info.supplier,'supplier_head': supplier_info.supplier_head,
                         'supplier_head_phone': supplier_info.supplier_head_phone,'supplier_head_email': supplier_info.supplier_head_email}
            data = json.dumps(info_json)

        return HttpResponse(data)


    def delete(self,request):
        """删除权限"""
        req_info = eval(request.body.decode())
        supplier_id = req_info.get("supplier_id")
        asset_db.Supplier.objects.get(id=supplier_id).delete()
        data = "supplier 已删除,请刷新查看！"
        return HttpResponse(data)



class Host(View):
    """服务器管理"""
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(Host,self).dispatch(request, *args, **kwargs)

    def get(self,request):
        title = "服务器"
        supplier_obj = asset_db.Supplier.objects.all()
        group_obj = asset_db.HostGroup.objects.all()
        idc_obj = asset_db.IDC.objects.all()
        host_obj = asset_db.Host.objects.all()
        return render(request,'asset_host.html',locals())

    def post(self,request):
        host_ip = request.POST.get("host_ip")
        host_remove_port = request.POST.get("host_remove_port")
        host_user = request.POST.get("host_user")
        host_passwd = request.POST.get("host_passwd")
        host_type = request.POST.get("host_type")
        host_group = request.POST.get("host_group")
        host_idc = request.POST.get("host_idc")
        host_supplier = request.POST.get("host_supplier")
        host_msg = request.POST.get("host_msg")
        serial_num = request.POST.get("serial_num")
        purchase_date = request.POST.get("purchase_date")
        overdue_date = request.POST.get("overdue_date")

        if host_group == "0":
            host_group = None

        if host_idc == "0":
            host_idc = None

        if host_supplier == "0":
            host_supplier = None

        # 加密密码
        key = SECRET_KEY[2:18]
        pc = encryption.prpcrypt(key)  # 初始化密钥
        aes_passwd = pc.encrypt(host_passwd)

        host_obj = asset_db.Host(host_ip=host_ip,host_remove_port=host_remove_port,host_user=host_user,host_passwd=aes_passwd,host_type=host_type,
                                 group_id=host_group,idc_id=host_idc,supplier_id=host_supplier,host_msg=host_msg,serial_num=serial_num,
                                 purchase_date=purchase_date,overdue_date=overdue_date)
        host_obj.save()
        data = '服务器已添加，请刷新查看！'
        return HttpResponse(data)

    def put(self,request):
        req_info = eval(request.body.decode())
        host_id = req_info.get("host_id")
        host_ip = req_info.get("host_ip")
        host_remove_port = req_info.get("host_remove_port")
        host_user = req_info.get("host_user")
        host_passwd = req_info.get("host_passwd")
        host_type = req_info.get("host_type")
        host_group = req_info.get("host_group")
        host_idc = req_info.get("host_idc")
        host_supplier = req_info.get("host_supplier")
        host_msg = req_info.get("host_msg")
        serial_num = req_info.get("serial_num")
        purchase_date = req_info.get("purchase_date")
        overdue_date = req_info.get("overdue_date")
        action = req_info.get("action",None)
        if action:
            """修改服务器信息"""
            # 加密密码
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)  # 初始化密钥
            aes_passwd = pc.encrypt(host_passwd)

            if host_group == "0":
                host_group = None

            if host_idc == "0":
                host_idc = None

            if host_supplier == "0":
                host_supplier = None

            host_obj = asset_db.Host.objects.get(id=host_id)
            host_obj.host_ip = host_ip
            host_obj.host_remove_port = host_remove_port
            host_obj.host_user = host_user
            host_obj.host_passwd = aes_passwd
            host_obj.host_type = host_type
            host_obj.group_id = host_group
            host_obj.idc_id = host_idc
            host_obj.supplier_id = host_supplier
            host_obj.host_msg = host_msg
            host_obj.serial_num = serial_num
            host_obj.purchase_date = purchase_date
            host_obj.overdue_date = overdue_date

            host_obj.save()
            data = "服务器已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            host_info = asset_db.Host.objects.get(id=host_id)

            #密码解密
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)
            passwd =host_info.host_passwd.strip("b").strip("'").encode(encoding="utf-8")
            de_passwd = pc.decrypt(passwd).decode()


            info_json = {'host_id': host_info.id, 'host_ip': host_info.host_ip,'host_remove_port': host_info.host_remove_port,
                         'host_user': host_info.host_user,'host_passwd': de_passwd,'host_type': host_info.host_type,
                         'host_group': host_info.group_id,'host_idc': host_info.idc_id,'host_supplier': host_info.supplier_id,
                         'host_msg': host_info.host_msg,'serial_num': host_info.serial_num,'purchase_date': host_info.purchase_date,'overdue_date': host_info.overdue_date}
            data = json.dumps(info_json,ensure_ascii=False)

        return HttpResponse(data)

    def delete(self,request):
        """删除服务器"""
        req_info = eval(request.body.decode())
        host_id = req_info.get("host_id")
        asset_db.Host.objects.get(id=host_id).delete()
        data = "服务器已删除,请刷新查看！"
        return HttpResponse(data)





class Netwk(View):
    """网络设备管理"""
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(Netwk,self).dispatch(request, *args, **kwargs)

    def get(self,request):
        title = "网络设备"
        supplier_obj = asset_db.Supplier.objects.all()
        group_obj = asset_db.HostGroup.objects.all()
        idc_obj = asset_db.IDC.objects.all()
        netwk_obj = asset_db.Netwk.objects.all()
        return render(request,'asset_netwk.html',locals())

    def post(self,request):
        netwk_ip = request.POST.get("netwk_ip")
        netwk_remove_port = request.POST.get("netwk_remove_port")
        netwk_user = request.POST.get("netwk_user")
        netwk_passwd = request.POST.get("netwk_passwd")
        netwk_type = request.POST.get("netwk_type")
        netwk_group = request.POST.get("netwk_group")
        netwk_idc = request.POST.get("netwk_idc")
        netwk_supplier = request.POST.get("netwk_supplier")
        netwk_msg = request.POST.get("netwk_msg")
        serial_num = request.POST.get("serial_num")
        purchase_date = request.POST.get("purchase_date")
        overdue_date = request.POST.get("overdue_date")

        if netwk_group == "0":
            netwk_group = None

        if netwk_idc == "0":
            netwk_idc = None

        if netwk_supplier == "0":
            netwk_supplier = None

        # 加密密码
        key = SECRET_KEY[2:18]
        pc = encryption.prpcrypt(key)  # 初始化密钥
        aes_passwd = pc.encrypt(netwk_passwd)

        netwk_obj = asset_db.Netwk(netwk_ip=netwk_ip,netwk_remove_port=netwk_remove_port,netwk_user=netwk_user,netwk_passwd=aes_passwd,netwk_type=netwk_type,
                                 group_id=netwk_group,idc_id=netwk_idc,supplier_id=netwk_supplier,netwk_msg=netwk_msg,serial_num=serial_num,
                                 purchase_date=purchase_date,overdue_date=overdue_date)
        netwk_obj.save()
        data = '设备已添加，请刷新查看！'
        return HttpResponse(data)

    def put(self,request):
        req_info = eval(request.body.decode())
        netwk_id = req_info.get("netwk_id")
        netwk_ip = req_info.get("netwk_ip")
        netwk_remove_port = req_info.get("netwk_remove_port")
        netwk_user = req_info.get("netwk_user")
        netwk_passwd = req_info.get("netwk_passwd")
        netwk_type = req_info.get("netwk_type")
        netwk_group = req_info.get("netwk_group")
        netwk_idc = req_info.get("netwk_idc")
        netwk_supplier = req_info.get("netwk_supplier")
        netwk_msg = req_info.get("netwk_msg")
        serial_num = req_info.get("serial_num")
        purchase_date = req_info.get("purchase_date")
        overdue_date = req_info.get("overdue_date")
        action = req_info.get("action",None)
        if action:
            """修改网络设备信息"""
            # 加密密码
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)  # 初始化密钥
            aes_passwd = pc.encrypt(netwk_passwd)

            if netwk_group == "0":
                netwk_group = None

            if netwk_idc == "0":
                netwk_idc = None

            if netwk_supplier == "0":
                netwk_supplier = None

            netwk_obj = asset_db.Netwk.objects.get(id=netwk_id)
            netwk_obj.netwk_ip = netwk_ip
            netwk_obj.netwk_remove_port = netwk_remove_port
            netwk_obj.netwk_user = netwk_user
            netwk_obj.netwk_passwd = aes_passwd
            netwk_obj.netwk_type = netwk_type
            netwk_obj.group_id = netwk_group
            netwk_obj.idc_id = netwk_idc
            netwk_obj.supplier_id = netwk_supplier
            netwk_obj.netwk_msg = netwk_msg
            netwk_obj.serial_num = serial_num
            netwk_obj.purchase_date = purchase_date
            netwk_obj.overdue_date = overdue_date

            netwk_obj.save()
            data = "设备已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            netwk_info = asset_db.Netwk.objects.get(id=netwk_id)

            #密码解密
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)
            passwd =netwk_info.netwk_passwd.strip("b").strip("'").encode(encoding="utf-8")
            de_passwd = pc.decrypt(passwd).decode()


            info_json = {'netwk_id': netwk_info.id, 'netwk_ip': netwk_info.netwk_ip,'netwk_remove_port': netwk_info.netwk_remove_port,
                         'netwk_user': netwk_info.netwk_user,'netwk_passwd': de_passwd,'netwk_type': netwk_info.netwk_type,
                         'netwk_group': netwk_info.group_id,'netwk_idc': netwk_info.idc_id,'netwk_supplier': netwk_info.supplier_id,
                         'netwk_msg': netwk_info.netwk_msg,'serial_num': netwk_info.serial_num,'purchase_date': netwk_info.purchase_date,'overdue_date': netwk_info.overdue_date}
            data = json.dumps(info_json,ensure_ascii=False)

        return HttpResponse(data)

    def delete(self,request):
        """删除网络设备"""
        req_info = eval(request.body.decode())
        netwk_id = req_info.get("netwk_id")
        asset_db.Netwk.objects.get(id=netwk_id).delete()
        data = "设备已删除,请刷新查看！"
        return HttpResponse(data)


