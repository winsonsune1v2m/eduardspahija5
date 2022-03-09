from __future__ import absolute_import, unicode_literals
from statics.scripts import get_software_info, get_host_info
from mtrops_v2 import celery_app
from celery import shared_task
import json
from mtrops_v2.settings import SERVER_TAG,SALT_API
from app_asset import models  as asset_db
from django.db.models import Q




@shared_task
def sync_host(ips,SALT_API,SERVER_TAG):
    ips = json.loads(ips)
    SALT_API = json.loads(SALT_API)
    SERVER_TAG = json.loads(SERVER_TAG)

    salt_url=SALT_API['url']
    salt_user = SALT_API['user']
    salt_passwd = SALT_API['passwd']

    data = get_host_info.main(salt_url,salt_user,salt_passwd,ips)

    software_data = get_software_info.get_sofeware(salt_url,salt_user,salt_passwd,ips, SERVER_TAG)

    for ip in data.keys():
        host_obj = asset_db.Host.objects.get(host_ip=ip)
        host_id = host_obj.id
        info = data[ip]
        try:
            host_detail_obj = asset_db.HostDetail.objects.get(host_id=host_id)

            host_detail_obj.host_name = info['localhost']
            host_detail_obj.os_type = info['kernel']
            host_detail_obj.product_name = info['productname']
            host_detail_obj.os_version = info['os'] + ' ' + info['osrelease']
            host_detail_obj.mem_size = info['mem_total']
            host_detail_obj.swap_size = info['SwapTotal']
            host_detail_obj.cpu_model = info['cpu_model']
            host_detail_obj.cpu_nums = info['num_cpus']
            host_detail_obj.disk_info = json.dumps(info['disk_info'])
            host_detail_obj.interface = json.dumps(info['interface'])
            host_detail_obj.kernel_version = info['kernel'] + ' ' + info['kernelrelease']
            host_detail_obj.save()
        except:
            kernel_version = "%s %s" % (info['kernel'], info['kernelrelease'])
            os_version = "%s %s" % (info['os'], info['osrelease'])
            host_detail_obj = asset_db.HostDetail(host_id=host_id, host_name=info['localhost'], os_type=info['kernel'],
                                                  product_name=info['productname'],
                                                  os_version=os_version, mem_size=info['mem_total'],
                                                  swap_size=info['SwapTotal'],
                                                  cpu_model=info['cpu_model'], cpu_nums=info['num_cpus'],
                                                  disk_info=json.dumps(info['disk_info']),
                                                  interface=json.dumps(info['interface']),
                                                  kernel_version=kernel_version)

            host_detail_obj.save()

        host_obj.host_status = 'up'
        host_obj.save()

    for ip in software_data.keys():

        host_obj = asset_db.Host.objects.get(host_ip=ip)
        host_id = host_obj.id
        software_info = software_data[ip]
        try:
            for i in software_info.keys():
                software_obj = asset_db.software.objects.filter(Q(host_id=host_id) & Q(server_name=software_info[i]['name'])).first()
                software_obj.host_id = host_obj.id
                software_obj.server_name = software_info[i]['name']
                software_obj.server_version = software_info[i]['version']
                software_obj.server_port = software_info[i]['port']
                software_obj.save()
        except:
            for i in software_info.keys():
                software_obj = asset_db.software(host_id=host_obj.id, server_name=software_info[i]['name'],
                                                 server_version=software_info[i]['version'],
                                                 server_port=software_info[i]['port'])
                software_obj.save()

    return True


@shared_task
def add(x,y):
    return x+y
