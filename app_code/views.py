import json
import re
import os
from statics.scripts import encryption
from django.shortcuts import render,HttpResponse
from django.views import View
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from app_code import models as code_db
from app_asset import models as asset_db
from app_auth import models as auth_db
from app_auth.views import login_check,perms_check
from django.db.models import Q
from statics.scripts import salt_api
from mtrops_v2.settings import SECRET_KEY,CODE_RUNAS,SALT_API,BASE_DIR

# Create your views here.

class Project(View):
    '''项目管理'''
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
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
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(GitCode, self).dispatch(request, *args, **kwargs)

    def get(self, request):
        title = '代码管理'
        project_obj = code_db.Project.objects.all()
        role_id = request.session['role_id']
        role_obj = auth_db.Role.objects.get(id=role_id)
        gitcode_obj = role_obj.project.all()
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
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(Publist, self).dispatch(request, *args, **kwargs)

    def get(self, request):
        title = '代码发布'

        role_id = request.session['role_id']

        host_obj = asset_db.Host.objects.filter(role__id=role_id)

        gitcode_obj = code_db.GitCode.objects.filter(role__id=role_id)

        project_obj = code_db.Project.objects.all()

        publist_all_obj=None

        for i in gitcode_obj:
            publist_obj = code_db.Publist.objects.filter(gitcode_id=i.id)
            try:
                publist_all_obj = publist_all_obj | publist_obj
            except:
                publist_all_obj = publist_obj

        return render(request, "code_publist.html", locals())

    def post(self,request):
        '''添加发布'''
        gitcode_name = request.POST.get("gitcode_name")
        publist_ip = request.POST.get("publist_ip")
        publist_dir = request.POST.get("publist_dir")
        publist_msg = request.POST.get("publist_msg")
        host_ip_ids = json.loads(publist_ip)
        minions=[]
        try:
            for ip_id in host_ip_ids:
                publist_obj = code_db.Publist(gitcode_id=gitcode_name,host_ip_id=ip_id,publist_dir=publist_dir,publist_msg=publist_msg)
                publist_obj.save()
                host_obj = asset_db.Host.objects.get(id=ip_id)
                host_ip = host_obj.host_ip
                minions.append(host_ip)
                gitcode_obj = code_db.GitCode.objects.get(id=gitcode_name)
                git_url = gitcode_obj.git_url

                if gitcode_obj.git_sshkey:
                    git_sshkey = gitcode_obj.git_sshkey
                else:
                    git_sshkey = None

                if gitcode_obj.git_user and gitcode_obj.git_passwd:
                    git_user = gitcode_obj.git_user

                    key = SECRET_KEY[2:18]
                    pc = encryption.prpcrypt(key)
                    passwd = gitcode_obj.git_passwd.strip("b").strip("'").encode(encoding="utf-8")
                    de_passwd = pc.decrypt(passwd).decode()
                    git_passwd = de_passwd

                else:
                    git_user =None
                    git_passwd = None

                git_info = {"git_dir": publist_dir, "git_url": git_url, "git_user": git_user, "git_passwd": git_passwd, "git_sshkey": git_sshkey,"code_runas": CODE_RUNAS}

            salt_url = SALT_API['url']
            salt_user = SALT_API['user']
            salt_passwd = SALT_API['passwd']
            salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

            hosts = ",".join(minions)

            script_file = os.path.join(BASE_DIR,"statics/scripts/git_clone.py")

            result = salt.salt_run_script(hosts, "cmd.script",script_file,git_info)

            data = "添加成功，请刷新查看"

        except Exception as e:
            data = "添加失败：\n%s" % e

        return HttpResponse(data)


    def delete(self,request):
        req_info = eval(request.body.decode())
        publist_id = req_info.get("publist_id")
        code_db.Publist.objects.get(id=publist_id).delete()
        data = "发布已删除，代码保留在服务器，如需彻底删除，请登录系操作！"
        return HttpResponse(data)


@csrf_exempt
@login_check
@perms_check
def search_publist(request):
    """过滤发布信息"""
    gitcode_id = request.POST.get('code_id')
    project_id = request.POST.get('project_id')
    host_id = request.POST.get('host_id')
    role_id = request.session['role_id']
    publist_all_obj = None
    gitcode_obj=None

    if gitcode_id:
        gitcode_obj = code_db.GitCode.objects.filter(Q(id=gitcode_id) & Q(role__id=role_id))

    if project_id:
        gitcode_obj = code_db.GitCode.objects.filter(Q(project_id=project_id)& Q(role__id=role_id))

    if gitcode_obj:
        for i in gitcode_obj:
            publist_obj = code_db.Publist.objects.filter(gitcode_id=i.id)
            try:
                publist_all_obj = publist_all_obj | publist_obj
            except:
                publist_all_obj = publist_obj

    if host_id:
        publist_all_obj = code_db.Publist.objects.filter(host_ip_id=host_id)

    return render(request, "code_publist_search.html", locals())




class CodeLog(View):
    '''发布记录'''

    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(CodeLog, self).dispatch(request, *args, **kwargs)

    def get(self, request):
        title = '发布记录'
        wchartlog_obj = code_db.Wchartlog.objects.all()
        return render(request, "code_wchartlog.html", locals())



