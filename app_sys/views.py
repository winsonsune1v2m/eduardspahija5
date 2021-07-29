import json
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_sys import models as sys_db
from app_asset import models as asset_db
from app_auth.views import login_check,perms_check

# Create your views here.

class EnvSofeware(View):
    """环境部署"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(EnvSofeware,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "环境部署"

        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []
        n = 1
        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(group_id=hostgroup_id)
            if n == 1:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "true"})
            else:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "false"})
            n += 1
            for j in hostinfo_obj:
                host_id = j.id
                host_ip = j.host_ip
                id = hostgroup_id * 10 + host_id
                tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})

        znodes_data = json.dumps(tree_info, ensure_ascii=False)

        sofeware_obj = sys_db.EnvSofeware.objects.all()
        return render(request,'sys_install.html',locals())

    def post(self,request):
        sofeware_name = request.POST.get('sofeware_name')
        sofeware_version = request.POST.get('sofeware_version')
        install_script = request.POST.get('install_script')
        try:
            env_obj = sys_db.EnvSofeware(sofeware_name=sofeware_name, sofeware_version=sofeware_version,install_script=install_script)
            env_obj.save()
            data = '添加成功,请刷新查看！'
        except Exception as e:
            data = '添加失败：\n%s' % e

        return HttpResponse(data)

    def put(self,request):
        """修改项目"""
        req_info = eval(request.body.decode())
        sofeware_id = req_info.get("sofeware_id")
        sofeware_name = req_info.get("sofeware_name")
        sofeware_version = req_info.get("sofeware_version")
        install_script = req_info.get("install_script")
        action = req_info.get("action",None)

        if action:
            """修改项目信息"""
            sofeware_obj = sys_db.EnvSofeware.objects.get(id=sofeware_id)
            sofeware_obj.sofeware_name = sofeware_name
            sofeware_obj.sofeware_version = sofeware_version
            sofeware_obj.install_script = install_script
            sofeware_obj.save()
            data = "角色已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            sofeware_info = sys_db.EnvSofeware.objects.get(id=sofeware_id)
            info_json = {'sofeware_id': sofeware_info.id, 'sofeware_name': sofeware_info.sofeware_name, 'sofeware_version': sofeware_info.sofeware_version,
                         'install_script': sofeware_info.install_script}
            data = json.dumps(info_json)

        return HttpResponse(data)

    def delete(self,request):
        req_info = eval(request.body.decode())
        sofeware_id = req_info.get("sofeware_id")
        sys_db.EnvInstall.objects.get(id=sofeware_id).delete()
        data = "软件已删除，请刷新查看"
        return HttpResponse(data)




class Batch(View):
    """批量管理"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(Batch,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "批量管理"

        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []
        n = 1
        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(group_id=hostgroup_id)
            if n == 1:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "true"})
            else:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "false"})
            n += 1
            for j in hostinfo_obj:
                host_id = j.id
                host_ip = j.host_ip
                id = hostgroup_id * 10 + host_id
                tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})

        znodes_data = json.dumps(tree_info, ensure_ascii=False)


        return render(request,'sys_batch.html',locals())


class FileMG(View):
    """文件管理"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(FileMG,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "文件管理"

        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []
        n = 1
        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(group_id=hostgroup_id)
            if n == 1:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "true"})
            else:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "false"})
            n += 1
            for j in hostinfo_obj:
                host_id = j.id
                host_ip = j.host_ip
                id = hostgroup_id * 10 + host_id
                tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})

        znodes_data = json.dumps(tree_info, ensure_ascii=False)

        return render(request,'sys_file.html',locals())


