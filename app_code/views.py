import json
import re
from statics.scripts import encryption
from statics.scripts.git_clone import git_clone
from mtrops_v2.settings import SECRET_KEY
from django.shortcuts import render,HttpResponse
from django.views import View
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from app_code import models as code_db
from app_asset import models as asser_db

# Create your views here.

class Project(View):
    '''项目管理'''
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(Project,self).dispatch(request, *args, **kwargs)

    def get(self,request):
        title = '项目管理'
        project_obj = code_db.Project.objects.all()
        return render(request,"code_project.html",locals())
    
    def post(self,request):
        '''添加项目'''
        project_name = request.POST.get("project_name")
        project_msg = request.POST.get("project_msg")
        try:
            project_obj = code_db.Project(project_name=project_name,project_msg=project_msg)
            project_obj.save()
            data = "项目 %s 添加成功，请刷新查看" % project_name
        except Exception as e:
            data = "添加失败：\n%s" % e

        return HttpResponse(data)

    def put(self,request):
        """修改项目"""
        project_info = eval(request.body.decode())
        project_id = project_info.get("project_id")
        project_name = project_info.get("project_name")
        project_msg = project_info.get("project_msg")
        action = project_info.get("action",None)

        if action:
            """修改项目信息"""
            project_obj = code_db.Project.objects.get(id=project_id)
            project_obj.project_name = project_name
            project_obj.project_msg = project_msg
            project_obj.save()
            data = "角色已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            project_info = code_db.Project.objects.get(id=project_id)
            info_json = {'project_id': project_info.id, 'project_name': project_info.project_name, 'project_msg': project_info.project_msg}
            data = json.dumps(info_json)

        return HttpResponse(data)

    def delete(self,request):
        project_info = eval(request.body.decode())
        project_id = project_info.get("project_id")
        code_db.Project.objects.get(id=project_id).delete()
        data = "项目已删除，请刷新查看"
        return HttpResponse(data)


class GitCode(View):
    '''代码管理'''

    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(GitCode, self).dispatch(request, *args, **kwargs)

    def get(self, request):
        title = '代码管理'
        project_obj = code_db.Project.objects.all()
        gitcode_obj = code_db.GitCode.objects.all()
        return render(request, "code_gitcode.html", locals())

    def post(self,request):
        '''添加项目'''
        git_name = request.POST.get("git_name")
        git_msg = request.POST.get("git_msg")
        git_project = request.POST.get("git_project")
        git_url = request.POST.get("git_url")
        git_user = request.POST.get("git_user")
        git_passwd = request.POST.get("git_passwd")

        git_sshkey = request.POST.get("git_sshkey")

        # 加密密码
        key = SECRET_KEY[2:18]
        pc = encryption.prpcrypt(key)  # 初始化密钥
        aes_passwd = pc.encrypt(git_passwd)

        try:
            gitcode_obj = code_db.GitCode(git_name=git_name,git_msg=git_msg,project_id=git_project,git_url=git_url,git_user=git_user,git_passwd=aes_passwd,git_sshkey=git_sshkey)
            gitcode_obj.save()
            data = "代码 %s 添加成功，请刷新查看" % git_name
        except Exception as e:
            data = "添加失败：\n%s" % e

        return HttpResponse(data)

    def put(self,request):
        """修改git代码"""
        git_info = eval(request.body.decode())
        git_id = git_info.get("git_id")
        git_name = git_info.get("git_name")
        git_msg = git_info.get("git_msg")
        git_project = git_info.get("git_project")
        git_url = git_info.get("git_url")
        git_user = git_info.get("git_user")
        git_passwd = git_info.get("git_passwd")
        git_sshkey = git_info.get("git_sshkey")
        action = git_info.get("action",None)

        if action:
            """修改git信息"""
            # 加密密码
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)  # 初始化密钥
            aes_passwd = pc.encrypt(git_passwd)


            git_obj = code_db.GitCode.objects.get(id=git_id)
            git_obj.git_name = git_name
            git_obj.git_msg = git_msg
            git_obj.project_id = git_project
            git_obj.git_url = git_url
            git_obj.git_user = git_user
            git_obj.git_passwd = aes_passwd
            git_obj.git_sshkey = git_sshkey
            git_obj.save()
            data = "Git信息已修改，请刷新查看！"
            return HttpResponse(data)
        else:
            """获取修改信息"""
            git_info = code_db.GitCode.objects.get(id=git_id)

            if git_info.git_passwd:
                # 密码解密
                key = SECRET_KEY[2:18]
                pc = encryption.prpcrypt(key)
                passwd = git_info.git_passwd.strip("b").strip("'").encode(encoding="utf-8")
                de_passwd = pc.decrypt(passwd).decode()
            else:
                de_passwd = None

            info_json = {'git_id': git_info.id, 'git_name': git_info.git_name, 'git_msg': git_info.git_msg,"git_project":git_info.project.id,
                         "git_url":git_info.git_url,'git_user':git_info.git_user,'git_passwd':de_passwd,'git_sshkey':git_info.git_sshkey}

            data = json.dumps(info_json)

        return HttpResponse(data)

    def delete(self,request):
        git_info = eval(request.body.decode())
        git_id = git_info.get("git_id")
        code_db.GitCode.objects.get(id=git_id).delete()
        data = "Git已删除，请刷新查看"
        return HttpResponse(data)



class Publist(View):
    '''代码发布'''
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(Publist, self).dispatch(request, *args, **kwargs)

    def get(self, request):
        title = '项目管理'
        host_obj = asser_db.Host.objects.all()
        gitcode_obj = code_db.GitCode.objects.all()
        publist_obj = code_db.Publist.objects.all()
        return render(request, "code_publist.html", locals())

    def post(self,request):
        '''添加项目'''
        gitcode_name = request.POST.get("gitcode_name")
        publist_ip = request.POST.get("publist_ip")
        publist_dir = request.POST.get("publist_dir")
        publist_msg = request.POST.get("publist_msg")
        host_ip_ids = json.loads(publist_ip)
        try:
            for ip_id in host_ip_ids:
                publist_obj = code_db.Publist(gitcode_id=gitcode_name,host_ip_id=ip_id,publist_dir=publist_dir,publist_msg=publist_msg)
                publist_obj.save()
                host_obj = asser_db.Host.objects.get(id=ip_id)
                host_ip = host_obj.host_ip
                gitcode_obj = code_db.GitCode.objects.get(id=gitcode_name)
                git_url = gitcode_obj.git_url
                #git_clone(host_ip,publist_dir,git_url)
            data = "添加成功，请刷新查看"
        except Exception as e:
            data = "添加失败：\n%s" % e

        return HttpResponse(data)



class CodeLog(View):
    '''发布记录'''

    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(CodeLog, self).dispatch(request, *args, **kwargs)

    def get(self, request):
        title = '项目管理'
        wchartlog_obj = code_db.Wchartlog.objects.all()
        return render(request, "code_wchartlog.html", locals())



