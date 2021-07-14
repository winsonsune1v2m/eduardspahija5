import datetime
import json
from django.views import View
from django.shortcuts import render,HttpResponse
from app_auth import models as auth_db
from django.views.decorators.csrf import csrf_exempt

# Create your views here.

class index(View):
    """首页"""
    def get(self,request,*args,**kwargs):
        title = "运维管理-首页"

        # 时间
        now = datetime.datetime.now()
        A = now.strftime('%A')
        Y = now.strftime('%Y')
        m = now.strftime('%m')
        d = now.strftime('%d')
        H_M = now.strftime('%H:%M')

        # 用户数量
        user_count = ""
        user_num = 5

        # 主机数量
        host_count = 3

        host_num = 3

        site_count = 3

        site_num = 3

        return  render(request,'base.html',locals())



class role_mg(View):
    """角色管理"""
    def get(self,request,*args,**kwargs):
        title = "角色管理"
        role_obj = auth_db.Role.objects.all()
        role_list = []
        for role in role_obj:
            role_list.append({"role_title": role.role_title, "role_msg": role.role_msg, 'role_id': role.id})

        return render(request,'rbac_role.html',locals())


    def post(self,request,*args,**kwargs):
        '''添加角色'''
        role_title = request.POST.get("role_title")
        role_msg = request.POST.get("role_msg")
        try:
            role_obj = auth_db.Role(role_title=role_title,role_msg=role_msg)
            role_obj.save()
            data = "角色 %s 添加成功，请刷新查看" % role_title
        except Exception as e:
            data = "添加失败：\n%s" % e

        return HttpResponse(data)


    def put(self,request,*args,**kwargs):

        role_info = eval(request.body.decode())
        role_id = role_info.get("role_id")
        role_title = role_info.get("role_title")
        role_msg = role_info.get("role_msg")
        action = role_info.get("action")
        if action:
            """修改角色信息"""
            role_obj = auth_db.Role.objects.get(id=role_id)
            role_obj.role_title = role_title
            role_obj.role_msg = role_msg
            role_obj.save()
            data = "角色已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            role_info = auth_db.Role.objects.get(id=role_id)
            info_json = {'role_id': role_info.id, 'role_title': role_info.role_title, 'role_msg': role_info.role_msg}
            data = json.dumps(info_json)

        return HttpResponse(data)

    def delete(self,request):
        role_info = eval(request.body.decode())
        role_id = role_info.get("role_id")
        auth_db.Role.objects.get(id=role_id).delete()
        data = "角色已删除，请刷新查看"
        return HttpResponse(data)






