#!/usr/bin/python
# -*- coding: utf-8 -*-

import re, json
from statics.scripts import salt_api


def get_os_info(salt_url, salt_user, salt_passwd,tgt):
    os_argvs = ['localhost', 'kernel', 'kernelrelease', 'cpu_model', 'num_cpus', 'productname', 'os', 'osrelease',
                'mem_total']

    os_module = 'grains.items'

    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)
    hosts = ",".join(tgt)
    result = salt.salt_run(hosts,os_module)
    interface_module = 'network.interfaces'
    interface_result = salt.salt_run(hosts, interface_module,)

    os_info_dict = {}
    for ip in tgt:
        try:
            host_info = {}
            for i in os_argvs:
                host_info[i] = result[ip][i]

            interface_info = []
            for j in interface_result[ip].keys():
                inter_info = interface_result[ip][j]
                try:
                    interface_info.append({"hwaddr": inter_info['hwaddr'], "ipaddr": inter_info['inet'][0]["address"],
                                               "label": inter_info['inet'][0]["label"],"netmask": inter_info['inet'][0]["netmask"]})
                except:
                    continue

            host_info["interface"] = interface_info
            os_info_dict[ip] = host_info
        except:
            continue

    return os_info_dict


def get_disk_info(salt_url,salt_user,salt_passwd,tgt):
    argv = "fdisk -l | grep -E 'sda:|sdb:|sdc:|vda:|vdb:|vdc:' |awk -F ',' '{print $1}'"
    disk_module = 'cmd.run'

    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)
    hosts = ",".join(tgt)

    result = salt.salt_run_arg(hosts, disk_module, argv)

    disk_dict = {}

    for i in result.keys():
        disk_infos = []

        if re.search("Disk", result[i]):
            disk_infos = result[i].split("\n")
        else:
            disk_module = 'disk.usage'
            result_w = salt.salt_run(i, disk_module, argv)
            for j in result_w.keys():

                for k in result_w[j].keys():
                    disk_size = result_w[j][k]["1K-blocks"]

                    if disk_size:
                        disk = k.strip("\\") + str(disk_size / 1024 / 1024) + " GB"
                        disk_infos.append(disk)
                    else:
                        pass

        disk_info = sorted(disk_infos)
        disk_dict[i] = {"disk_info": disk_info}
    return disk_dict


def get_mem_info(salt_url,salt_user,salt_passwd,tgt):
    module = 'status.meminfo'

    salt = salt_api.SaltAPI(salt_url, salt_user, salt_passwd)
    hosts = ",".join(tgt)

    result = salt.salt_run(hosts, module)
    mem_info = {}
    for ip in tgt:
        try:
            SwapTotal = int(result[ip]['SwapTotal']['value']) / 1024
        except:
            SwapTotal = 0

        mem_info[ip] = {"SwapTotal": SwapTotal}

    return mem_info

def main(salt_url,salt_user,salt_passwd,tgt):
    os_info = get_os_info(salt_url,salt_user,salt_passwd,tgt)
    disk_info = get_disk_info(salt_url,salt_user,salt_passwd,tgt)
    mem_info = get_mem_info(salt_url,salt_user,salt_passwd,tgt)

    data = {}
    for ip in tgt:
        sys_info = {}
        try:
            sys_info.update(os_info[ip])
            sys_info.update(disk_info[ip])
            sys_info.update(mem_info[ip])
            data[ip] = sys_info
        except:
            continue
    return data



if __name__ == "__main__":
    salt_url = "https://192.168.1.126:8081"
    salt_user = "saltapi"
    salt_passwd = "saltapi"
    tgt = ['192.168.1.207']
    result = main(salt_url,salt_user,salt_passwd,tgt)
    print (result)