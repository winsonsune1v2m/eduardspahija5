import json
import re
import os
import datetime
import shutil
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_sys import models as sys_db
from app_asset import models as asset_db
from app_auth import models as auth_db
from app_auth.views import login_check,perms_check
from django.db.models import Q
from mtrops_v2.settings import BASE_DIR,SALT_API,MTROPS_HOST
from statics.scripts import salt_api
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

        role_id = request.session["role_id"]
        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []
        n = 1
        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id)&Q(role__id=role_id))
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
        sys_db.EnvInstall.objects.get(id=sofeware_id).delete()
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



    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

    hosts = ",".join(ip_list)

    script_file = "salt://%s" % script_file

    result = salt.salt_run_arg(hosts, "cmd.script", script_file)

    data = "服务已部署，请检查！"

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
        n = 1
        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id) & Q(role__id=role_id))

            tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "false"})
            n += 1
            for j in hostinfo_obj:
                host_id = j.id
                host_ip = j.host_ip
                id = hostgroup_id * 10 + host_id
                tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})

        znodes_data = json.dumps(tree_info, ensure_ascii=False)

        user_name = request.session['user_name']
        user_obj = auth_db.User.objects.get(user_name=user_name)
        remote_user_list = user_obj.remoteuser_set.all()
        return render(request,'sys_batch.html',locals())


@csrf_exempt
@login_check
@perms_check
def batch_run_cmd(request):
    """批量执行命令"""
    cmd = request.POST.get('cmd')
    ip_list = json.loads(request.POST.get("ip_list"))

    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

    hosts = ",".join(ip_list)

    runas = request.session['remote_user']
    if runas:
        data = salt.salt_run_arg(hosts, "cmd.run", cmd,runas)
        data_txt = ''
        for ip in ip_list:
            head_txt = '=================== %s ===================\n' % ip
            result_info = "%sCommand：%s\nOutput：\n%s\n\r" % (head_txt, cmd, data[ip])
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

    src = "salt://" + file_path

    dest = upload_path.rstrip("/") + "/" + upload_file.name

    if os.path.exists(file_path):
        date_str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        os.rename(file_path, file_path + "_" + date_str)
    else:
        pass

    f = open(file_path, 'wb')

    for chunk in upload_file.chunks():
        f.write(chunk)
    f.close()

    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

    hosts = ",".join(ip_list)

    runas = request.session['remote_user']
    if runas:
        data = salt.salt_run_upfile(hosts, "cp.get_file", src, dest,runas)

        data_txt=''
        for ip in  ip_list:
            head_txt='=================== %s ===================\n' % ip
            result_info = "%sOutput：\n%s\n\r" % (head_txt,data[ip])
            data_txt+=result_info

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

    script_src = "salt://" + script_file


    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']


    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

    hosts = ",".join(ip_list)

    runas = request.session['remote_user']
    if runas:
        data = salt.salt_run_arg(hosts, "cmd.script", script_src,runas)

        data_txt=''
        for ip in  ip_list:
            head_txt='=================== %s ===================\n' % ip
            result_info = "%sOutput：\n%s\n\r" % (head_txt,data[ip]['stdout'])
            data_txt+=result_info
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

        cmd = 'crontab -u %s -l' % remote_user

        salt_url = SALT_API['url']
        salt_user = SALT_API['user']
        salt_passwd = SALT_API['passwd']
        salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

        hosts = ",".join(ip_list)

        runas = request.session['remote_user']
        if runas:

            data = salt.salt_run_arg(hosts, "cmd.run", cmd,runas)

            data_info = []

            for ip in data.keys():

                data_list = data[ip].split('\n')
                cron_list = []
                if re.match('no', data_list[0]) or re.match('crontab', data_list[0]) or re.search('must be privileged', data_list[0]):
                    cron_list = []
                else:
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
        else:

            cron_list = []

        return render(request, "sys_cron_table.html", locals())

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

        cmd = 'echo "%s %s %s %s %s %s" >> /var/spool/cron/%s' % (Minute, Hour, Day, Month, Week, cron_cmd, remote_user)

        salt_url = SALT_API['url']
        salt_user = SALT_API['user']
        salt_passwd = SALT_API['passwd']
        salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

        hosts = ",".join(ip_list)

        runas = request.session['remote_user']
        if runas:


            data = salt.salt_run_arg(hosts, "cmd.run", cmd,runas)

            data_txt = ''

            for ip in ip_list:
                head_txt = '=================== %s ===================\n' % ip
                result_info = "%sOutput：\n%s\n\r" % (head_txt, data[ip])
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
            cmd = '''sed -i "/%s/d"  /var/spool/cron/%s''' % (d, remote_user)
        elif action == "up":
            e = re.sub("^#", "", d)
            cmd = '''sed -i "s/%s/%s/"  /var/spool/cron/%s''' % (d, e, remote_user)
        elif action == "ban":
            cmd = '''sed -i "s/%s/#%s/"  /var/spool/cron/%s''' % (d, d, remote_user)
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

        salt_url = SALT_API['url']
        salt_user = SALT_API['user']
        salt_passwd = SALT_API['passwd']
        salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

        hosts = ",".join(ip_list)
        script_src = "salt://" + f_sed

        runas = request.session['remote_user']
        if runas:

            data = salt.salt_run_arg(hosts, "cmd.script", script_src,runas)
            result = data[ip]

            data_txt = "执行错误：%s\n\r执行结果：%s" % (result['stderr'], result['stdout'])
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
            hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id) & Q(role__id=role_id))


            tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "true"})
            n += 1
            for j in hostinfo_obj:
                host_id = j.id
                host_ip = j.host_ip
                id = hostgroup_id * 10 + host_id
                tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})

        znodes_data = json.dumps(tree_info, ensure_ascii=False)

        salt_url = SALT_API['url']
        salt_user = SALT_API['user']
        salt_passwd = SALT_API['passwd']
        salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)


        home_dir = "~"

        runas = request.session['remote_user']

        file_list = []
        dir_list = []
        ip = MTROPS_HOST
        if runas:

            cmd = "cd %s && pwd && ls -al| grep -v total | awk '{print $1,$9}'" % home_dir
            data = salt.salt_run_arg(ip, "cmd.run",cmd, runas)

            result = data[ip]

            cur_dir = result.split("\n")[0]

            for i in result.split("\n")[1:]:
                F = i.split()
                if re.match(r"-", F[0]):

                    file_list.append(F[1])
                else:
                    if F[1] == "..":
                        dir = "dir_reback"

                    elif F[1] == ".":
                        dir = "dir_reply"

                    else:
                        dir = F[1]

                    dir_list.append(dir)

        request.session['cur_dir'] = home_dir
        request.session['cur_host'] = ip

        return render(request,'sys_file.html',locals())



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


    if ch_dir == "dir_reback":
        ch_dir ="."
    elif ch_dir == "dir_reply":
        ch_dir = ".."
    else:
        ch_dir = ch_dir

    cur_dir = request.session['cur_dir']

    dir_path = os.path.join(cur_dir,ch_dir)

    cmd = "cd %s && pwd && ls -al| grep -v total | awk '{print $1,$9}'" % dir_path

    runas = request.session['remote_user']

    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

    file_list = []
    dir_list = []

    data = salt.salt_run_arg(ip, "cmd.run", cmd, runas)

    result = data[ip]

    cur_dir = result.split("\n")[0]

    request.session['cur_dir'] = cur_dir
    request.session['cur_host'] = ip

    for i in result.split("\n")[1:]:
        F = i.split()
        if re.match(r"-", F[0]):
            file_list.append(F[1])

        else:

            if F[1] == "..":
                dir = "dir_reback"

            elif F[1] == ".":
                dir = "dir_reply"

            else:
                dir = F[1]

            dir_list.append(dir)

    return render(request, 'sys_file.html', locals())


@csrf_exempt
@login_check
#@Perms_required
def cd_dir(request):
    """直接跳转"""
    cd_dir = request.POST.get("cd_dir")

    ip = request.POST.get("ip")

    cmd = "cd %s && pwd && ls -al| grep -v total | awk '{print $1,$9}'" % cd_dir

    runas = request.session['remote_user']

    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

    file_list = []
    dir_list = []

    data = salt.salt_run_arg(ip, "cmd.run", cmd, runas)

    result = data[ip]

    cur_dir = result.split("\n")[0]

    request.session['cur_dir'] = cur_dir
    request.session['cur_host'] = ip

    for i in result.split("\n")[1:]:
        F = i.split()
        if re.match(r"-", F[0]):
            file_list.append(F[1])

        else:

            if F[1] == "..":
                dir = "dir_reback"

            elif F[1] == ".":
                dir = "dir_reply"

            else:
                dir = F[1]

            dir_list.append(dir)

    return render(request, "sys_file_list.html", locals())


#上传文件
@csrf_exempt
@login_check
#@perms_check
def Upfile(request):
    if request.method == "POST":

        path = request.session['cur_dir']

        upfile = request.FILES.get("upfile")

        ip = request.session['cur_host']

        up_file_path = os.path.join(BASE_DIR,'static', 'upload', ip)

        if os.path.exists(up_file_path):
            pass
        else:
            os.makedirs(up_file_path)

        file_path = os.path.join(up_file_path, upfile.name)


        src = "salt://"+file_path

        dest = path.rstrip("/")+"/"+upfile.name


        if os.path.exists(file_path):
            date_str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
            os.rename(file_path, file_path+"_"+date_str)
        else:
            pass

        f = open(file_path,'wb')

        for chunk in upfile.chunks():
            f.write(chunk)
        f.close()

        runas = request.session['remote_user']

        salt_url = SALT_API['url']
        salt_user = SALT_API['user']
        salt_passwd = SALT_API['passwd']
        salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

        result = salt.salt_run_upfile(ip, "cp.get_file", src, dest,runas)

        if result[ip]:
            msg = "上传成功"
        else:
            msg = "上传失败"
        return HttpResponse(msg)
    else:
        return HttpResponse("未知请求")


# 下载文件
@csrf_exempt
@login_check
#@perms_check
def Downfile(request):
    if request.method == "POST":

        filename = request.POST.get("filename")


        path = request.session['cur_dir'] + filename

        ip = request.session['cur_host']

        salt_url = SALT_API['url']
        salt_user = SALT_API['user']
        salt_passwd = SALT_API['passwd']
        salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

        result = salt.salt_run_arg(ip, "cp.push", path, runas)


        if result[ip]:
            salt_file_path = "/var/cache/salt/master/minions/%s/files" % ip

            downfile_path = os.path.join(BASE_DIR, 'static', 'download', ip)

            if os.path.exists(downfile_path):
                pass
            else:
                os.makedirs(downfile_path)


            salt_file = salt_file_path + path

            save_file = downfile_path + "/" + filename


            if os.path.exists(save_file):
                date_str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
                os.rename(save_file, save_file + "_" + date_str)
            else:
                pass

            shutil.move(salt_file,save_file)

            msg = "http://%s:8080/static/download/%s/%s" % (MTROPS_HOST,ip, filename)

        else:
            msg = "下载失败，请检查文件是否存在"

        return HttpResponse(msg)
    else:
        return HttpResponse("未知请求")



@csrf_exempt
@login_check
#@perms_check
def Removefile(request):
    '''文件管理-删除文件'''
    if request.method == "POST":
        filename = request.POST.get("filename")
        path = request.session['cur_dir'] + filename
        ip = request.session['cur_host']
        salt_url = SALT_API['url']
        salt_user = SALT_API['user']
        salt_passwd = SALT_API['passwd']
        salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)
        result = salt.salt_run_arg(ip, "file.remove", path, runas)
        return HttpResponse(result)
    else:
        return HttpResponse("未知请求")



