from __future__ import absolute_import, unicode_literals
import json
from statics.scripts import get_software_info, get_host_info
from mtrops_v2 import celery_app




@celery_app.task()
def sync_host_info(ips,SALT_API,SERVER_TAG):

    print(SALT_API)
    salt_url=SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']

    data = get_host_info.main(salt_url,salt_user,salt_passwd,ips)

    software_data = get_software_info.get_sofeware(salt_url,salt_user,salt_passwd,ips, SERVER_TAG)

    return data


@celery_app.task()
def sync_host_software(ips,SALT_API,SERVER_TAG):

    print(SALT_API)
    salt_url=SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']


    software_data = get_software_info.get_sofeware(salt_url,salt_user,salt_passwd,ips, SERVER_TAG)

    return software_data


@celery_app.task()
def add(x, y):
    return x+y
