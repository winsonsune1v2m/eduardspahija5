import json
import re
import os
import datetime
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_sys import models as sys_db
from app_asset import models as asset_db
from app_auth import models as auth_db
from app_log import models as log_db
from app_auth.views import login_check,perms_check
from django.db.models import Q
from mtrops_v2.settings import BASE_DIR,MTROPS_HOST,ANSIBLE_USER
from statics.scripts import ansible_api
from app_sys.tasks import install_server


class EnvSofeware(View):
    """环境部署"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(EnvSofeware,self).dispatch(request,*args, **kwargs)


    def get(self,request):
        title = "环境部署"
        role_id = request.session["role_id"]
        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []

        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id) & Q(role__id=role_id) & Q(hostdetail__host_status="up"))

            if hostinfo_obj:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "false"})

                for j in hostinfo_obj:
                    host_id = j.id
                    host_ip = j.host_ip
                    id = hostgroup_id * 10 + host_id
                    tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})


        znodes_data = json.dumps(tree_info, ensure_ascii=False)

        sofeware_obj = sys_db.EnvSofeware.objects.all()
        return render(request, 'sys/sys_install.html', locals())

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
        """修改"""
        req_info = eval(request.body.decode())
        sofeware_id = req_info.get("sofeware_id")
        sofeware_name = req_info.get("sofeware_name")
        sofeware_version = req_info.get("sofeware_version")
        install_script = req_info.get("install_script")
        action = req_info.get("action",None)

        if action:
            """修改部署信息"""
            sofeware_obj = sys_db.EnvSofeware.objects.get(id=sofeware_id)
            sofeware_obj.sofeware_name = sofeware_name
            sofeware_obj.sofeware_version = sofeware_version
            sofeware_obj.install_script = install_script
            sofeware_obj.save()
            data = "部署信息已修改，请刷新查看！"
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
        sys_db.EnvSofeware.objects.get(id=sofeware_id).delete()
        data = "软件部署已删除，请刷新查看"
        return HttpResponse(data)


@csrf_exempt
@login_check
@perms_check
def sofeware_install(request):
    host_info = request.POST.get("node_id_json")
    sofeware_id = request.POST.get("sofeware_id")
    ip_list = []
    for i in json.loads(host_info):
        if re.search("\d+.\d+.\d+.\d", i):
            ip_list.append(i)
    sofeware_obj = sys_db.EnvSofeware.objects.get(id=sofeware_id)
    install_script = sofeware_obj.install_script
    sofeware_name = sofeware_obj.sofeware_name
    script_name = "install_%s" % sofeware_name
    script_file = os.path.join(BASE_DIR, 'statics', 'scripts', script_name)
    f = open(script_file, 'w')
    f.write(install_script)
    f.close()
    runas = request.session['remote_user']
    tk = install_server.delay(json.dumps(ip_list),script_file,runas)
    data = "服务安装中,任务ID:{}".format(tk.id)
    user_name = request.session['user_name']
    user_obj = auth_db.User.objects.get(user_name=user_name)
    task_obj = log_db.TaskRecord(task_name="安装软件服务", task_id=tk.id, status=tk.state,task_user_id=user_obj.id)
    task_obj.save()
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
        role_id = request.session["role_id"]
        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []
        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id) & Q(role__id=role_id) & Q(hostdetail__host_status="up"))
            if hostinfo_obj:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "false"})
                for j in hostinfo_obj:
                    host_id = j.id
                    host_ip = j.host_ip
                    id = hostgroup_id * 10 + host_id
                    tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})

        znodes_data = json.dumps(tree_info, ensure_ascii=False)
        user_name = request.session['user_name']
        user_obj = auth_db.User.objects.get(user_name=user_name)
        remote_user_list = auth_db.RemoteUser.objects.all()
        return render(request, 'sys/sys_batch.html', locals())


@csrf_exempt
@login_check
@perms_check
def batch_run_cmd(request):
    """批量执行命令"""
    cmd = request.POST.get('cmd')
    ip_list = json.loads(request.POST.get("ip_list"))
    runas = request.session['remote_user']
    if runas:
        ret = ansible_api.run_ansible("shell",cmd,ip_list,runas)
        result = json.loads(ret)
        data_txt = ""
        for ip in result["success"].keys():
            head_txt = '=================== %s (SUCCESS)===================\n' % ip
            result_info = "%sCommand：%s\nOutput：\n%s\n\r" % (head_txt, cmd, result["success"][ip]["stdout"])
            data_txt += result_info
        for ip in result["failed"].keys():
            head_txt = '=================== %s (FAILED)===================\n' % ip
            result_info = "%sCommand：%s\nOutput：\n%s\n\r" % (head_txt, cmd, result["failed"][ip]["stderr"])
            data_txt += result_info
    else:
        data_txt = "远程管理用户未设置，无法执行！"
    return HttpResponse(data_txt)


@csrf_exempt
@login_check
@perms_check
def batch_upload_file(request):
    """批量上传文件"""
    upload_path = request.POST.get('upload_path')
    upload_file = request.FILES.get("upfile")
    ip_list = json.loads(request.POST.get("ip_list"))
    up_file_path = os.path.join(BASE_DIR, 'statics', 'upload')
    if os.path.exists(up_file_path):
        pass
    else:
        os.makedirs(up_file_path)
    file_path = os.path.join(up_file_path, upload_file.name)
    dest = os.path.join(upload_path,upload_file.name)
    if os.path.exists(file_path):
        date_str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        os.rename(file_path, file_path + "_" + date_str)
    else:
        pass
    f = open(file_path, 'wb')
    for chunk in upload_file.chunks():
        f.write(chunk)
    f.close()

    runas = request.session['remote_user']
    if runas:
        module_name = "copy"
        module_arg = "src={} dest={} owner={} group={} backup=yes".format(file_path, dest,runas,runas)
        ret = ansible_api.run_ansible(module_name,module_arg,ip_list,runas)
        data_txt=''
        result = json.loads(ret)
        for ip in result["success"].keys():
            head_txt = '=================== %s (SUCCESS)===================\n' % ip
            result_info = "%s\nOutput：\n%s\n\r" % (head_txt, result["success"][ip]["dest"])
            data_txt += result_info
        for ip in result["failed"].keys():
            head_txt = '=================== %s (FAILED)===================\n' % ip
            result_info = "%s\nOutput：\n%s\n\r" % (head_txt, result["failed"][ip]["msg"])
            data_txt += result_info
    else:
        data_txt = "远程管理用户未设置，无法执行！"

    return HttpResponse(data_txt)


@csrf_exempt
@login_check
@perms_check
def batch_script(request):
    """批量执行脚本"""
    up_script = request.FILES.get("script_file")
    ip_list = json.loads(request.POST.get("ip_list"))
    script_dir = os.path.join(BASE_DIR, 'statics', 'scripts')
    if os.path.exists(script_dir):
        pass
    else:
        os.makedirs(script_dir)
    script_file = os.path.join(script_dir, up_script.name)
    if os.path.exists(script_file):
        date_str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        os.rename(script_file, script_file + "_" + date_str)
    else:
        pass
    f = open(script_file, 'wb')
    for chunk in up_script.chunks():
        f.write(chunk)
    f.close()
    runas = request.session['remote_user']
    if runas:
        "ansible all –m script –a {}".format(script_file)
        ret = ansible_api.run_ansible("script", script_file,ip_list,runas)
        result = json.loads(ret)
        data_txt=''
        for ip in result["success"].keys():
            head_txt = '=================== %s (SUCCESS)===================\n' % ip
            result_info = "%s\nOutput：\n%s\n\r" % (head_txt, result["success"][ip]["stdout"])
            data_txt += result_info
        for ip in result["failed"].keys():
            head_txt = '=================== %s (FAILED)===================\n' % ip
            result_info = "%s\nOutput：\n%s\n\r" % (head_txt, result["failed"][ip]["stdout"])
            data_txt += result_info
    else:
        data_txt = "远程管理用户未设置，无法执行！"

    return HttpResponse(data_txt)


class CronView(View):
    """
    计划任务管理
    """
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(CronView, self).dispatch(request, *args, **kwargs)

    def get(self, request):
        ip_list = json.loads(request.GET.get('ip_list'))
        remote_user = request.GET.get('remote_user')
        cmd = 'crontab -u {} -l'.format(remote_user)
        runas = request.session['remote_user']
        if runas:
            ret = ansible_api.run_ansible("shell",cmd,ip_list,runas)
            result = json.loads(ret)
            data_info = []
            for ip in result["success"].keys():
                data_list = result["success"][ip]["stdout_lines"]
                cron_list = []
                for i in data_list:
                    A = i.split()
                    if A:
                        B = A[0:5]
                        C = A[5:]
                        cmd = " ".join(C)
                        B.append(cmd)
                        cron_list.append(
                            {'m': B[0], 'h': B[1], 'd': B[2], 'M': B[3], 'w': B[4], 'cmd': B[5], 'org_cmd': i})
                data_info.append({"IP": ip, "cron": cron_list})
            for ip in result["failed"].keys():
                cron_list = []
                data_info.append({"IP": ip, "cron": cron_list})
        else:
            cron_list = []
        return render(request, "sys/sys_cron_table.html", locals())

    def post(self, request):
        ip_list = json.loads(request.POST.get('ip_list'))
        remote_user = request.POST.get('remote_user')
        Minute = request.POST.get('Minute')
        Hour = request.POST.get('Hour')
        Day = request.POST.get('Day')
        Month = request.POST.get('Month')
        Week = request.POST.get('Week')
        cron_cmd = request.POST.get('cron_cmd')
        cron_cmd = re.sub(r"\"", "\'", cron_cmd)
        if Minute == '':
            Minute = '*'
        if Hour == '':
            Hour = '*'
        if Day == '':
            Day = '*'
        if Month == '':
            Month = '*'
        if Week == '':
            Week = '*'
        cmd = 'id {} && echo "{} {} {} {} {} {}" >> /var/spool/cron/{} && echo "Crontab added successfully"'.format(remote_user,Minute, Hour, Day, Month, Week, cron_cmd, remote_user)

        runas = request.session['remote_user']
        if runas:
            ret = ansible_api.run_ansible("shell",cmd,ip_list,runas)
            result = json.loads(ret)
            data_txt = ''
            for ip in result["success"].keys():
                head_txt = '=================== %s (SUCCESS)===================\n' % ip
                result_info = "%s\nOutput：\n%s\n\r" % (head_txt, result["success"][ip]["stdout"])
                data_txt += result_info
            for ip in result["failed"].keys():
                head_txt = '=================== %s (FAILED)===================\n' % ip
                result_info = "%s\nOutput：\n%s\n\r" % (head_txt, result["failed"][ip]["stderr"])
                data_txt += result_info
        else:
            data_txt = "远程管理用户未设置，无法执行！"
        return HttpResponse(data_txt)

    def put(self, request):
        del_info = eval(request.body.decode())
        ip = del_info['ip']
        ip_list = [ip]
        remote_user = del_info['remote_user']
        org_cmd = del_info['org_cmd']
        action = del_info['action']
        b = re.sub("\\*", "\*", org_cmd)
        c = re.sub("\/", "\/", b)
        d = re.sub('\"', '\\\"', c)
        d = re.sub("&", "\&", d)
        if action == 'Del':
            cmd = '''sed -i "/%s/d"  /var/spool/cron/%s && echo "Crontab deleted successfully"''' % (d, remote_user)
        elif action == "up":
            e = re.sub("^#", "", d)
            cmd = '''sed -i "s/%s/%s/"  /var/spool/cron/%s && echo "Crontab enabled"''' % (d, e, remote_user)
        elif action == "ban":
            cmd = '''sed -i "s/%s/#%s/"  /var/spool/cron/%s && echo "Crontab disabled"''' % (d, d, remote_user)
        elif action == "edit":
            Minute = del_info['Minute']
            Hour = del_info['Hour']
            Day = del_info['Day']
            Month = del_info['Month']
            Week = del_info['Week']
            cron_cmd = del_info['cron_cmd']
            cron_new = """%s %s %s %s %s %s""" % (Minute, Hour, Day, Month, Week, cron_cmd)
            A = re.sub("\\*", "\*", cron_new)
            B = re.sub("\/", "\/", A)
            C = re.sub('\"', '\\\"', B)
            D = re.sub("&", "\&", C)
            cmd = '''sed -i "s/%s/%s/"  /var/spool/cron/%s''' % (d, D, remote_user)

        f_sed = os.path.join(BASE_DIR, 'statics', 'scripts', 'sed.sh')
        f = open(f_sed, 'w')
        f.write(cmd)
        f.close()

        runas = request.session['remote_user']

        if runas:
            ret = ansible_api.run_ansible("script", f_sed,ip_list,runas)
            result = json.loads(ret)
            if result["success"]:
                data_txt = "SUCCESS：%s" % (result["success"][ip]["stdout"])
            else:
                data_txt = "FAILED：%s" % (result["failed"][ip]["stdout"])
        else:
            data_txt = "远程管理用户未设置，无法执行！"
        return HttpResponse(data_txt)

class FileMG(View):
    """文件管理"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(FileMG,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "文件管理"
        role_id = request.session["role_id"]
        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []
        n = 1
        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id) & Q(role__id=role_id) & Q(hostdetail__host_status="up"))
            if hostinfo_obj:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "true"})
                n += 1
                for j in hostinfo_obj:
                    host_id = j.id
                    host_ip = j.host_ip
                    id = hostgroup_id * 10 + host_id
                    tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})
        znodes_data = json.dumps(tree_info, ensure_ascii=False)
        runas = request.session['remote_user']
        if runas:
            module_name = "shell"
            module_arg = "pwd"
            host_list = [MTROPS_HOST]
            ret = ansible_api.run_ansible(module_name,module_arg,host_list,runas)
            try:
                home_dir = json.loads(ret)['success'][MTROPS_HOST]["stdout"]
                if home_dir:
                    pass
                else:
                    home_dir = "/"
            except:
                home_dir = "/"
            cmd = "cd {} && pwd &&ls -al| grep -v total".format(home_dir)
            ret = ansible_api.run_ansible(module_name,cmd,host_list,runas)
            result = json.loads(ret)
            if result["success"]:
                file_list = []
                dir_list = []
                dir_info = result["success"][MTROPS_HOST]['stdout_lines']
                cur_dir = dir_info[0]
                for i in dir_info[1:]:
                    F = i.split()
                    if re.match(r"-", F[0]):
                        file_list.append(F[8])
                    else:
                        if F[8] == "..":
                            dir = "dir_reback"
                        elif F[8] == ".":
                            dir = "dir_reply"
                        else:
                            dir = F[8]
                        dir_list.append(dir)
            request.session['cur_dir'] = home_dir
            request.session['cur_host'] = MTROPS_HOST
            ip = MTROPS_HOST
            return render(request, 'sys/sys_file.html', locals())
        else:
            return HttpResponse("远程管理用户未配置，无法访问！")

@login_check
def ch_dir(request,ip,ch_dir):
    """点击文件夹加进行跳转"""
    title = "文件管理"
    role_id = request.session["role_id"]
    hostgroup_obj = asset_db.HostGroup.objects.all()
    tree_info = []
    n = 1
    for i in hostgroup_obj:
        hostgroup_id = i.id
        hostgroup_name = i.host_group_name
        hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id) & Q(role__id=role_id))
        tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "true"})
        n += 1
        for j in hostinfo_obj:
            host_id = j.id
            host_ip = j.host_ip
            id = hostgroup_id * 10 + host_id
            tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})
    znodes_data = json.dumps(tree_info, ensure_ascii=False)
    if ch_dir == "dir_reply":
        ch_dir ="."
    elif ch_dir == "dir_reback":
        ch_dir = ".."
    else:
        ch_dir = ch_dir
    cur_dir = request.session['cur_dir']
    dir_path = os.path.join(cur_dir,ch_dir)
    runas = request.session['remote_user']
    cmd = "cd {} && pwd &&ls -al| grep -v total".format(dir_path)
    module_name = 'shell'
    file_list = []
    dir_list = []
    ret = ansible_api.run_ansible(module_name, cmd, [ip], runas)
    result = json.loads(ret)
    if result["success"]:
        file_list = []
        dir_list = []
        dir_info = result["success"][ip]['stdout_lines']
        cur_dir = dir_info[0]
        for i in dir_info[1:]:
            F = i.split()
            if re.match(r"-", F[0]):
                file_list.append(F[8])
            else:
                if F[8] == "..":
                    dir = "dir_reback"
                elif F[8] == ".":
                    dir = "dir_reply"
                else:
                    dir = F[8]
                dir_list.append(dir)
        request.session['cur_dir'] = cur_dir
        request.session['cur_host'] = ip
    return render(request, 'sys/sys_file.html', locals())

@csrf_exempt
@login_check
def cd_dir(request):
    """直接跳转"""
    cd_dir = request.POST.get("cd_dir")
    ip = request.POST.get("ip")
    runas = request.session['remote_user']
    cmd = "cd {} && pwd && ls -al| grep -v total".format(cd_dir)
    file_list = []
    dir_list = []
    module_name = "shell"
    ret = ansible_api.run_ansible(module_name, cmd, [ip], runas)
    result = json.loads(ret)
    if result["success"]:
        file_list = []
        dir_list = []
        dir_info = result["success"][ip]['stdout_lines']
        cur_dir = dir_info[0]
        for i in dir_info[1:]:
            F = i.split()
            if re.match(r"-", F[0]):
                file_list.append(F[8])
            else:
                if F[8] == "..":
                    dir = "dir_reback"
                elif F[8] == ".":
                    dir = "dir_reply"
                else:
                    dir = F[8]
                dir_list.append(dir)
        request.session['cur_dir'] = cur_dir
        request.session['cur_host'] = ip
    return render(request, "sys/sys_file_list.html", locals())


#上传文件
@csrf_exempt
@login_check
def Upfile(request):
    if request.method == "POST":
        path = request.session['cur_dir']
        upfile = request.FILES.get("upfile")
        ip = request.session['cur_host']
        up_file_path = os.path.join(BASE_DIR,'statics', 'upload', ip)
        if os.path.exists(up_file_path):
            pass
        else:
            os.makedirs(up_file_path)
        file_path = os.path.join(up_file_path, upfile.name)
        dest = os.path.join(path,upfile.name)
        if os.path.exists(file_path):
            date_str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
            os.rename(file_path, file_path+"_"+date_str)
        else:
            pass

        with open(file_path,'wb') as f:
            for chunk in upfile.chunks():
                f.write(chunk)

        runas = request.session['remote_user']
        module_name = "copy"
        module_arg = "src={} dest={} owner={} group={} backup=yes".format(file_path,dest,runas,runas)
        result = ansible_api.run_ansible(module_name, module_arg, [ip], runas)
        result = json.loads(result)
        if result['success'][ip]:
            msg = "上传成功"
        else:
            msg = "上传失败"
        return HttpResponse(msg)
    else:
        return HttpResponse("未知请求")


# 下载文件
@csrf_exempt
@login_check
def Downfile(request):
    filename = request.POST.get("filename")
    path = os.path.join(request.session['cur_dir'], filename)
    ip = request.session['cur_host']
    save_path = os.path.join(BASE_DIR, 'statics', 'download')
    runas = request.session['remote_user']
    module_arg = "src={} dest={}".format(path,save_path)
    module_name = "fetch"
    result = ansible_api.run_ansible(module_name, module_arg, [ip], runas)
    result = json.loads(result)
    if result['success'][ip]:
        msg = "http://{}:8080/static/download/{}{}".format(MTROPS_HOST,ip,path)
    else:
        msg = "下载失败，请检查文件是否存在"
    return HttpResponse(msg)


@csrf_exempt
@login_check
@perms_check
def Removefile(request):
    '''文件管理-删除文件'''
    filename = request.POST.get("filename")
    path = os.path.join(request.session['cur_dir'],filename)
    ip = request.session['cur_host']
    runas = request.session['remote_user']
    module_arg = "path={} state=absent".format(path)
    module_name = "file"
    ret = ansible_api.run_ansible(module_name, module_arg, [ip], runas)
    result = json.loads(ret)
    if result['success'][ip]:
        msg = "文件已删除！"
    else:
        msg = ret
    return HttpResponse(msg)

@csrf_exempt
@login_check
@perms_check
def Editfile(request):
    #在线编辑-获取文件内容
    try:
        filename = request.GET.get("filename")
        type = ['\.tgz$','\.gz$','\.tar$','\.bz$','\.rpm$','\.zip$','\.bz2$','\.mp3$','\.mp4$','\.jpg$','\.gif$','\.png$','\.amr$','\.bmp$','\.exe$']
        for i in type:
            type = re.search(i,filename)
            if type:
                return HttpResponse('指定文件不被支持，不能编辑!')
        cd_dir = request.GET.get('cd_dir')
        ip = request.GET.get('ip')
        runas = request.session['remote_user']
        path = os.path.join(cd_dir,filename)
        module_name = "shell"
        module_arg = "du {}".format(path)
        ret = ansible_api.run_ansible(module_name, module_arg, [ip], runas)
        result = json.loads(ret)

        save_path = os.path.join(BASE_DIR, 'statics', 'download')

        if int(result['success'][ip]['stdout'].split("\t")[0]) > 2048:
            return HttpResponse('不能在线编辑大于2MB的文件!')
        else:
            module_name = "fetch"
            module_arg = "src={} dest={}".format(path, save_path)
            fet_ret = ansible_api.run_ansible(module_name, module_arg, [ip], runas)
            result = json.loads(fet_ret)
            if result["success"][ip]:
                save_file = os.path.join(save_path,path)
                fp = open(save_file, 'r')
                fileval = fp.read()
                fp.close()
            else:
                fileval = "获取文件失败，请检查！"
    except Exception as e:
        return HttpResponse(e)
    return render(request, "sys/edit.html", locals())

@csrf_exempt
@login_check
@perms_check
def Savefile(request):
    #在线编辑-保存文件
    try:
        filename = request.POST.get("filename")
        path = request.POST.get('cd_dir')
        ip = request.POST.get('ip')
        save_file = request.POST.get('save_file')
        fileval = request.POST.get("content")
        runas = request.session['remote_user']
        src = save_file
        dest = os.path.join(path,filename)
        fp = open(save_file, 'w+');
        fp.write(fileval)
        fp.close()
        module_name = "copy"
        module_arg = "src={} dest={} owner={} group={} backup=yes".format(src, dest, runas, runas)
        result = ansible_api.run_ansible(module_name, module_arg, [ip], runas)
        result = json.loads(result)

        if result["success"]:
            msg = json.dumps({'msg':'保存成功'})
        else:
            msg = json.dumps({'msg':'保存失败'})
    except Exception as e:
        return HttpResponse(e)
    return HttpResponse(msg)



