import json
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_asset import models as asset_db
from app_auth.views import login_check

# Create your views here.

class WebSSH(View):
    """webssh"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    def dispatch(self, request, *args, **kwargs):
        return super(WebSSH,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "webssh"

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

        return render(request,'tool_webssh.html',locals())


class PhpMyadmin(View):
    """phpMyadmin"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    def dispatch(self, request, *args, **kwargs):
        return super(PhpMyadmin,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "phpMyadmin"

        return render(request,'tool_phpmyadmin.html',locals())