from __future__ import absolute_import, unicode_literals
from celery import shared_task
import json,os
from app_code import models  as code_db
from app_asset import models  as asset_db
from statics.scripts import encryption,salt_api

@shared_task
def install_server(ip_list,script_file,SALT_API):
    ip_list = json.loads(ip_list)
    SALT_API = json.loads(SALT_API)


    salt_url = SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']
    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)

    hosts = ",".join(ip_list)
    script_file = "salt://%s" % script_file
    data = salt.salt_run_arg(hosts, "cmd.script", script_file)

    return json.dumps({"result":data},ensure_ascii=False,indent=True)
