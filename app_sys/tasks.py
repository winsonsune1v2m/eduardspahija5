from __future__ import absolute_import, unicode_literals
from celery import shared_task
import json,os
from app_code import models  as code_db
from app_asset import models  as asset_db
from statics.scripts import encryption,ansible_api
from multiprocessing import current_process

@shared_task
def install_server(ip_list,script_file,runas):
    current_process()._config = {'semprefix': '/mp'}
    ip_list = json.loads(ip_list)
    result = ansible_api.run_ansible("script", script_file,ip_list,runas)
    return result
