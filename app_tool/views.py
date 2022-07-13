import json
import redis
import os
import shutil
import datetime
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_asset import models as asset_db
from app_auth.views import login_check,perms_check
from mtrops_v2.settings import WEBSSH_URL,REDIS_INFO,SALT_API,BASE_DIR,MTROPS_HOST,PHPMYADMIN_URL,REDIS_INFO
from statics.scripts import encryption,salt_api
from django.db.models import Q

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

        role_id = request.session["role_id"]
        hostgroup_obj = asset_db.HostGroup.objects.all()
        tree_info = []

        for i in hostgroup_obj:
            hostgroup_id = i.id
            hostgroup_name = i.host_group_name
            hostinfo_obj = asset_db.Host.objects.filter(Q(group_id=hostgroup_id) & Q(role__id=role_id) & Q(hostdetail__host_status="up"))

            if hostinfo_obj:
                tree_info.append({"id": hostgroup_id, "pId": 0, "name": hostgroup_name, "open": "true"})
                for j in hostinfo_obj:
                    host_id = j.id
                    host_ip = j.host_ip
                    id = hostgroup_id * 10 + host_id
                    tree_info.append({"id": id, "pId": hostgroup_id, "name": host_ip})


        znodes_data = json.dumps(tree_info, ensure_ascii=False)

        webssh_url = WEBSSH_URL

        redis_obj = redis.Redis(host=REDIS_INFO["host"],port=REDIS_INFO["port"])

        try:
            cur_host = json.loads(redis_obj.get('webssh_info'))['hostname']
        except:
            cur_host = "远程管理用户未配置，无法认证！"

        return render(request,'tool_webssh.html',locals())


    def post(self,request):

        hostname = request.POST.get('ip')

        host_obj = asset_db.Host.objects.get(host_ip=hostname)

        redis_obj = redis.Redis(host=REDIS_INFO["host"], port=REDIS_INFO["port"])

        remote_user = request.session['remote_user']
        remote_passwd = request.session['remote_passwd']
        remote_sshkey = request.session['remote_sshkey']
        remote_sshkey_pass = request.session['remote_sshkey_pass']

        if remote_sshkey:
            if remote_sshkey_pass:
                pass
            else:
                remote_sshkey_pass = "None"
        else:
            remote_sshkey = "None"
            remote_sshkey_pass = "None"

        webssh_info = {"username": remote_user, "publickey": remote_sshkey, "password": remote_passwd,
                       "hostname": host_obj.host_ip,"port": host_obj.host_remove_port, "key_pass": remote_sshkey_pass}

        redis_obj.set("webssh_info", json.dumps(webssh_info), ex=5, nx=True)

        return HttpResponse("已连接到服务器")

#上传文件
@csrf_exempt
@login_check
def Upfile(request):

    path = request.POST.get("path")

    upfile = request.FILES.get("upfile")

    ip = request.POST.get("ip")

    up_file_path = os.path.join(BASE_DIR,'statics', 'upload', ip)

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


# 下载文件
@csrf_exempt
@login_check
def Downfile(request):
    ip = request.POST.get("ip")
    file_path = request.POST.get("path")
    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)
    result = salt.salt_run_downfile(ip, "cp.push", file_path)
    if result[ip]:
        salt_file_path = "/var/cache/salt/master/minions/%s/files%s" % (ip,file_path)
        downfile_path = os.path.join(BASE_DIR, 'statics', 'download', ip)
        if os.path.exists(downfile_path):
            pass
        else:
            os.makedirs(downfile_path)
        file_name = file_path.split("/")[-1]
        save_file = downfile_path + "/" + file_name
        if os.path.exists(save_file):
            date_str = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
            os.rename(save_file, save_file + "_" + date_str)
        else:
            pass
        shutil.move(salt_file_path,save_file)
        msg = "http://%s:8080/static/download/%s/%s" % (MTROPS_HOST,ip,file_name)
    else:
        msg = "下载失败，请检查文件是否存在"
    return HttpResponse(msg)



class PhpMyadmin(View):
    """phpMyadmin"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):

        return super(PhpMyadmin,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        r = redis.Redis(host=REDIS_INFO['host'], port=REDIS_INFO['port'], db=0)
        title = "phpMyadmin"
        phpmyadmin_url = PHPMYADMIN_URL
        mysql_host = r.get('mysql_host')
        mysql_user = r.get('mysql_user')
        mysql_passwd = r.get('mysql_passwd')
        mysql_port = r.get('mysql_port')

        if mysql_host:
            mysql_host = mysql_host.decode('utf-8')
            mysql_user = mysql_user.decode('utf-8')
            mysql_passwd = mysql_passwd.decode('utf-8')
            mysql_port = mysql_port.decode('utf-8')
        else:
            mysql_host = ""
            mysql_user = ""
            mysql_passwd = ""
            mysql_port = ""

        return render(request,'tool_phpmyadmin.html',locals())

    def post(self,request):
        r = redis.Redis(host=REDIS_INFO['host'], port=REDIS_INFO['port'])
        db_ip = request.POST.get("db_ip")
        db_user = request.POST.get("db_user")
        db_passwd = request.POST.get("db_passwd")
        db_port = int(request.POST.get("db_port"))
        r.set('mysql_host', db_ip)
        r.set('mysql_user', db_user)
        r.set('mysql_passwd', db_passwd)
        r.set('mysql_port', db_port)

        return HttpResponse("正在连接phpmyadmin！")
