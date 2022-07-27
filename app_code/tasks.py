from __future__ import absolute_import, unicode_literals
import json,os,re
from celery import shared_task
from app_code import models  as code_db
from app_asset import models  as asset_db
from statics.scripts import encryption,ansible_api
from multiprocessing import current_process

@shared_task
def code_clone(publist_ip,gitcode_id,publist_dir,publist_msg,SECRET_KEY,CODE_RUNAS,BASE_DIR,ANSIBLE_USER):
    current_process()._config = {'semprefix': '/mp'}

    host_ip_ids = json.loads(publist_ip)
    host_list = []


    for ip_id in host_ip_ids:
        """添加发布记录"""
        publist_obj = code_db.Publist(gitcode_id=gitcode_id, host_ip_id=ip_id, publist_dir=publist_dir,
                                      publist_msg=publist_msg)
        publist_obj.save()
        host_obj = asset_db.Host.objects.get(id=ip_id)
        host_ip = host_obj.host_ip
        host_list.append(host_ip)

    #获取新发布git信息
    gitcode_obj = code_db.GitCode.objects.get(id=gitcode_id)
    git_url = gitcode_obj.git_url
    git_name = gitcode_obj.git_name

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
        git_user = None
        git_passwd = None

    module_name = "shell"
    module_arg = "yum -y install git"
    ansible_api.run_ansible(module_name,module_arg,host_list,ANSIBLE_USER)

    module_name ="file"
    module_arg = "path={} state=directory owner={} mode=777".format(publist_dir,publist_dir)
    ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)

    clone_dir = os.path.join(publist_dir, git_name)

    if git_sshkey:
        if CODE_RUNAS!="root":
            module_name = "shell"
            module_arg = "ls /home/{}/.ssh/ >&/dev/null||useradd {}>&/dev/null;mkdir -p /home/{}/.ssh/".format(CODE_RUNAS,CODE_RUNAS,CODE_RUNAS)
            ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)
            module_arg = "chown -R {}.{} /home/{}/.ssh/".format(CODE_RUNAS, CODE_RUNAS,CODE_RUNAS)
            ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)

        ssh_key_file = "/home/{}/.ssh/id_rsa".format(CODE_RUNAS)
        tmp_ssh_key = os.path.join(BASE_DIR,"id_rsa")
        with open(tmp_ssh_key, 'w') as f:
            f.write(git_sshkey)

        module_name = "copy"
        module_arg = "src={} dest={} owner={} group={} backup=yes mode=600".format(tmp_ssh_key,ssh_key_file,CODE_RUNAS,CODE_RUNAS)
        ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)

        module_name = "git"
        module_arg = "repo={} dest={} key_file={} accept_hostkey=true".format(git_url,clone_dir,ssh_key_file)
        result = ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)

    else:
        if git_user and git_passwd:
            lg_info = "%s:%s" % (git_user, git_passwd)
            lg_info = re.sub("@", "%40", lg_info)
            url_list = git_url.split("//")
            new_url = "%s//%s@%s" % (url_list[0], lg_info, url_list[1])
            module_name = "git"
            module_arg = "repo={} dest={}".format(new_url, clone_dir)
            result =  ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)
        else:
            module_name = "git"
            module_arg = "repo={} dest={}".format(git_url, clone_dir)
            result = ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)

    module_name = "shell"
    module_arg = "chown -R {}.{} {}".format(CODE_RUNAS, CODE_RUNAS, clone_dir)
    ansible_api.run_ansible(module_name, module_arg, host_list, ANSIBLE_USER)

    return result
