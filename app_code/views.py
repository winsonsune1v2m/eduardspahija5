import json
import re
import os
import time
from statics.scripts import encryption
from django.shortcuts import render,HttpResponse
from django.views import View
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from app_code import models as code_db
from app_asset import models as asset_db
from app_auth import models as auth_db
from app_log import models as log_db
from app_auth.views import login_check,perms_check
from django.db.models import Q
from statics.scripts import ansible_api,sendwx,recdn
from mtrops_v2.settings import SECRET_KEY,CODE_RUNAS,ANSIBLE_USER,BASE_DIR,WCHART_CORPID,WCHART_CORPSECRET,WCHART_ADMIN_UDSER,WCHART_URL,ALLOWED_HOSTS
from mtrops_v2.settings import MTR_ACCESS_KEY_ID,MTR_ACCESS_KEY_SECRET,MTY_ACCESS_KEY_ID,MTY_ACCESS_KEY_SECRET,REGION_ID,LANGUAGE_LIST
from app_code.tasks import code_clone
from django.core.paginator import Paginator,PageNotAnInteger,EmptyPage
from statics.scripts import page as pg

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
        return render(request, "code/code_project.html", locals())
    
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
        language_list = LANGUAGE_LIST
        return render(request, "code/code_gitcode.html", locals())

    def post(self,request):
        '''添加项目'''

        git_name = request.POST.get("git_name")
        git_msg = request.POST.get("git_msg")
        git_project = request.POST.get("git_project")
        git_url = request.POST.get("git_url")
        git_user = request.POST.get("git_user")
        git_passwd = request.POST.get("git_passwd")
        git_sshkey = request.POST.get("git_sshkey")
        git_language = request.POST.get("git_language")

        # 加密密码
        key = SECRET_KEY[2:18]
        pc = encryption.prpcrypt(key)  # 初始化密钥
        aes_passwd = pc.encrypt(git_passwd)

        try:
            gitcode_obj = code_db.GitCode(git_name=git_name,git_msg=git_msg,project_id=git_project,git_url=git_url,git_user=git_user,git_passwd=aes_passwd,git_sshkey=git_sshkey,git_language=git_language)
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
        git_language = git_info.get("git_language")
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
            git_obj.git_language = git_language
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

            info_json = {'git_id': git_info.id, 'git_name': git_info.git_name, 'git_msg': git_info.git_msg, 'git_language': git_info.git_language,"git_project":git_info.project.id,
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
    #@method_decorator(perms_check)
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
            publist_obj = code_db.Publist.objects.filter(gitcode_id=i.id).order_by("-publist_date")
            try:
                publist_all_obj = publist_all_obj | publist_obj
            except:
                publist_all_obj = publist_obj

        return render(request, "code/code_publist.html", locals())

    def post(self,request):
        '''添加发布'''
        gitcode_id = request.POST.get("gitcode_id")
        publist_ip = request.POST.get("publist_ip")
        publist_dir = request.POST.get("publist_dir")
        publist_msg = request.POST.get("publist_msg")
        tk = code_clone.delay(publist_ip,gitcode_id,publist_dir,publist_msg,SECRET_KEY,CODE_RUNAS,BASE_DIR,ANSIBLE_USER)
        data = "发布创建中,任务ID:{}".format(tk.id)
        user_name = request.session['user_name']
        user_obj = auth_db.User.objects.get(user_name=user_name)
        task_obj = log_db.TaskRecord(task_name="新建代码发布", task_id=tk.id, status=tk.state,task_user_id=user_obj.id)
        task_obj.save()
        return HttpResponse(data)


    def delete(self,request):
        req_info = eval(request.body.decode())
        publist_id = req_info.get("publist_id")
        code_db.Publist.objects.get(id=publist_id).delete()
        data = "发布已删除，代码保留在服务器，如需彻底删除，请登陆服务器操作！"
        return HttpResponse(data)

    def put(self,request):
        '''版本更新'''
        try:
            req_info = eval(request.body.decode())
            publist_id = req_info.get("publist_id")
            # 获取当前需要更新的发布信息
            publist_obj = code_db.Publist.objects.get(id=publist_id)
            git_name = publist_obj.gitcode.git_name
            host_ip = publist_obj.host_ip.host_ip
            publist_dir = publist_obj.publist_dir
            code_dir = publist_dir+'/'+git_name
            module_name = 'shell'
            host_list = [host_ip]

            #拉取代码
            module_args = "su - %s -c 'cd %s && git stash>/dev/null;git pull origin master'" % (CODE_RUNAS, code_dir)
            result_up = ansible_api.run_ansible(module_name, module_args,host_list,ANSIBLE_USER)

            #获取更新后的版本信息
            module_args = "su - {} -c 'cd {} && git log -1'".format(CODE_RUNAS,publist_dir+'/'+git_name)
            result_log = ansible_api.run_ansible(module_name, module_args,host_list,ANSIBLE_USER)
            #结果处理
            result_up = json.loads(result_up)
            result_log = json.loads(result_log)

            if result_up["success"]:
                up_log = result_up["success"][host_ip]
                log_msg= result_log["success"][host_ip]
                log_info = log_msg["stdout_lines"]
                tag_msg = ",".join(up_log['stdout_lines'])
                if re.search("Already up-to-date",tag_msg):
                    data = '已经是最新版本,无需更新'
                elif re.search("Permission denied",tag_msg):
                    data = up_log
                elif re.search("git config --global", tag_msg):
                    data = up_log
                else:
                    ret_msg = "\n".join(up_log['stdout_lines'])
                    data = "++++++++++++++代码更新成功++++++++++++++\n%s" % ret_msg
                    current_version = log_info[0].split()[1]
                    version_info = log_info[-1].strip()
                    author = log_info[1].split()[1]
                    try:
                        upcode_date = " ".join(log_info[2].split()[1:])
                        str_date = upcode_date.strip('+0800').strip()
                        array_date = time.strptime(str_date, "%a %b %d %H:%M:%S %Y")
                        upcode_date = time.strftime('%Y-%m-%d %H:%M:%S', array_date)
                    except:
                        upcode_date = " ".join(log_info[3].split()[1:])
                        str_date = upcode_date.strip('+0800').strip()
                        array_date = time.strptime(str_date, "%a %b %d %H:%M:%S %Y")
                        upcode_date = time.strftime('%Y-%m-%d %H:%M:%S', array_date)
                    publist_obj = code_db.Publist.objects.get(id=publist_id)
                    publist_obj.current_version = current_version
                    publist_obj.version_info = version_info
                    publist_obj.author = author
                    publist_obj.publist_date = upcode_date
                    publist_obj.save()
                    # 添加更新记录
                    try:
                        record_obj = code_db.PublistRecord(current_version=current_version, version_info=version_info,
                                                           author=author, publist_date=upcode_date, publist_id=publist_id,up_content=ret_msg)
                        record_obj.save()
                    except Exception as e:
                        print(e)
            else:
                faild_msg = result_up["failed"][host_ip]['stderr']
                data = "++++++++++++++更新失败++++++++++++++\n%s" % faild_msg

        except Exception as e:
            data = "更新失败：\n%s\n" % e
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

    return render(request, "code/code_publist_search.html", locals())


@csrf_exempt
@login_check
@perms_check
def git_log(request,id):
    '''git更新记录'''
    title = '代码发布'
    record_info = code_db.PublistRecord.objects.filter(publist_id=id).order_by('-publist_date')
    post_obj = code_db.Publist.objects.get(id=id)
    current_version = post_obj.current_version
    record_list = []
    for  i in  record_info:
        upcode_date = i.update_time
        site_name = i.publist.gitcode.git_name
        post_ip = i.publist.host_ip.host_ip
        if i.current_version == current_version:
            version_status = u"当前版本"
        else:
            version_status = u"历史版本"
        record_list.append({'record_id':i.id,'site_name':site_name,'post_ip':post_ip,
                            'current_version':i.current_version,'version_info':i.version_info,
                            'author':i.author,'upcode_date':upcode_date,'version_status':version_status})
    return render(request, "code/code_publist_record.html", locals())


@csrf_exempt
@login_check
@perms_check
def check_git_log(request):
    record_id = request.POST.get('record_id')
    PublistRecord_obj = code_db.PublistRecord.objects.get(id=record_id)
    result = PublistRecord_obj.up_content
    return HttpResponse(result)


@csrf_exempt
@login_check
@perms_check
def  RollBack(request):
    record_id = request.POST.get('record_id')
    record_obj = code_db.PublistRecord.objects.get(id=record_id)
    rollback_version = record_obj.current_version
    post_id = record_obj.publist_id

    post_obj = code_db.Publist.objects.get(id=post_id)
    site_name = post_obj.gitcode.git_name
    ip = post_obj.host_ip.host_ip
    site_path = post_obj.publist_dir
    # 修改ansible 参数，使用sudo执行命令
    host_list = [ip]
    # 拉取代码
    module_name = 'shell'
    module_arg = "su - {} -c 'cd {}/{} && git reset --hard {}'".format(CODE_RUNAS, site_path,site_name,rollback_version)
    result = ansible_api.run_ansible(module_name, module_arg, host_list,ANSIBLE_USER)
    #结果处理
    info=json.loads(result)
    if info['success']:
        if info['success'][ip]['stdout_lines']:
            current_version = record_obj.current_version
            version_info = record_obj.version_info
            author = record_obj.author
            upcode_date = record_obj.publist_date

            #同步版本信息
            post_obj.current_version = current_version
            post_obj.version_info = version_info
            post_obj.author = author
            post_obj.publist_date = upcode_date
            post_obj.save()
            msg = "代码回滚成功！"
        else:
            msg = "代码回滚失败\n{}".format(result)
    else:
        msg = "代码回滚失败,salt执行失败\n{}".format(result)
    return HttpResponse(msg)
    
class CodeLog(View):
    '''企业微信发布记录'''
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(CodeLog, self).dispatch(request, *args, **kwargs)

    def get(self, request,page=1):
        title = '发布记录'
        wchartlog_obj = code_db.Wchartlog.objects.all().order_by("-add_time")

        pagesize = 13
        paginator = Paginator(wchartlog_obj, pagesize)
        # 从前端获取当前的页码数,默认为1
        # 把当前的页码数转换成整数类型
        currentPage = int(page)
        page_nums = paginator.num_pages
        page_list = pg.control(currentPage, page_nums)
        try:
            wchartlog_list = paginator.page(page)  # 获取当前页码的记录
        except PageNotAnInteger:
            wchartlog_list = paginator.page(1)  # 如果用户输入的页码不是整数时,显示第1页的内容
        except EmptyPage:
            wchartlog_list = paginator.page(paginator.num_pages)

        return render(request, "code/code_wchartlog.html", locals())

    def post(self,request):
        """企业微信更新"""
        git_id = request.POST.get('git_id')
        log_obj = code_db.Wchartlog.objects.get(id=git_id)
        site_name = log_obj.site_name
        from_user = log_obj.from_user
        up_data = log_obj.content
        status = log_obj.status
        test_token = sendwx.get_token(WCHART_URL, WCHART_CORPID, WCHART_CORPSECRET)

        if status == "waiting":
            gitcode_obj = code_db.GitCode.objects.get(git_name=site_name)
            site_id = gitcode_obj.id
            publist_obj = code_db.Publist.objects.filter(gitcode_id=site_id)

            for i in publist_obj:
                ip = i.host_ip.host_ip
                site_path = i.publist_dir
                all_up_com = ""
                for j in up_data.split("##"):
                    if j:
                        if re.search(r"commit_msg", j):
                            continue
                        else:
                            up_com = "&& git checkout  origin/master {}".format(j)
                        all_up_com += up_com
                    else:
                        continue
                code_dir = os.path.join(site_path, site_name)
                checkout_cmd = "cd {} && git fetch {}".format(code_dir,all_up_com)
                #调用salt api 执行更新命令
                host_list=[ip]
                module_name = 'shell'
                module_arg = "su - {} -c '{}'".format(CODE_RUNAS,checkout_cmd)
                result = ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)
                result = json.loads(result)

                resp_user = WCHART_ADMIN_UDSER + "|" + from_user
                if result['success']:
                    #更新结果处理，发送企业微信小心
                    msg = "++++++++执行成功+++++++\n{}\n{}".format(ip, "\n".join(result['success'][ip]["stderr_lines"]))
                    msg_data = sendwx.params(msg, resp_user)
                    #更新状态
                    log_obj.status = "done"
                    log_obj.save()
                else:
                    msg = "++++++++执行失败+++++++\n{}\n{}".format(ip,"\n".join(result['failed'][ip]["stderr_lines"]))
                    msg_data = sendwx.params(msg, resp_user)
                sendwx.send_message(WCHART_URL, test_token, msg_data)

            #刷新CDN
            for k in up_data.split("##"):
                if re.search("(\.js$|\.css$|\.jpg$|\.gif$|\.png$)", k):
                    if re.search(r'mtrp2p', site_name):
                        access_key_id = MTR_ACCESS_KEY_ID
                        access_key_secret = MTR_ACCESS_KEY_SECRET
                    else:
                        access_key_id = MTY_ACCESS_KEY_ID
                        access_key_secret = MTY_ACCESS_KEY_SECRET
                    recdn.ReCDN(REGION_ID, access_key_id, access_key_secret, site_name, k)
                else:
                    pass
            ret_msg = "该请求已执行"
        return  HttpResponse(ret_msg)

@csrf_exempt
@login_check
@perms_check
def search_log(request):
    key = request.POST.get('key')
    wchartlog_obj = code_db.Wchartlog.objects.filter(Q(site_name__icontains=key)|Q(from_user__icontains=key)|Q(up_connect__icontains=key)|Q(status__icontains=key)).order_by("-add_time")
    return render(request, "code/code_wchartlog_search.html", locals())


