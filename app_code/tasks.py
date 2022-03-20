from __future__ import absolute_import, unicode_literals
from celery import shared_task
import json,os
from app_code import models  as code_db
from app_asset import models  as asset_db
from statics.scripts import encryption,salt_api

@shared_task
def code_clone(publist_ip,gitcode_name,publist_dir,publist_msg,SALT_API,SECRET_KEY,CODE_RUNAS,BASE_DIR):
    host_ip_ids = json.loads(publist_ip)
    SALT_API = json.loads(SALT_API)

    minions = []

    for ip_id in host_ip_ids:

        publist_obj = code_db.Publist(gitcode_id=gitcode_name, host_ip_id=ip_id, publist_dir=publist_dir,
                                      publist_msg=publist_msg)
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
            git_user = None
            git_passwd = None

        git_info = {"git_dir": publist_dir, "git_url": git_url, "git_user": git_user, "git_passwd": git_passwd,
                    "git_sshkey": git_sshkey, "code_runas": CODE_RUNAS}

    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)
    hosts = ",".join(minions)

    script_file = os.path.join(BASE_DIR, "statics/scripts/git_clone.py")

    data = salt.salt_run_script(hosts, "cmd.script", script_file, git_info)

    return json.dumps({"result":data},ensure_ascii=False,indent=True)



@shared_task
def add(x,y):
    return x+y
