#!/usr/bin/python
# -*- coding: utf-8 -*-

import re, json



def Client(tgt, module, argv):


    local = salt.client.LocalClient()
    if argv:
        result = local.cmd(tgt, module, [argv], tgt_type='list')
    else:
        result = local.cmd(tgt, module, tgt_type='list')
    return result


def get_os_info(tgt):
    os_argvs = ['localhost', 'kernel', 'kernelrelease', 'cpu_model', 'num_cpus', 'productname', 'os', 'osrelease',
                'mem_total']

    os_module = 'grains.items'
    result = Client(tgt, os_module, None)
    interface_module = 'network.interfaces'
    interface_result = Client(tgt, interface_module, None)
    os_info_dict = {}
    for ip in tgt:
        try:
            host_info = {}
            for i in os_argvs:
                host_info[i] = result[ip][i]

            interface_info = []
            for j in interface_result[ip].keys():
                inter_info = interface_result[ip][j]
                interface_info.append({"hwaddr": inter_info['hwaddr'], "ipaddr": inter_info['inet'][0]["address"],
                                           "label": inter_info['inet'][0]["label"],"netmask": inter_info['inet'][0]["netmask"]})

            host_info["interface"] = interface_info
            os_info_dict[ip] = host_info
        except:
            continue

    return os_info_dict


def get_disk_info(tgt):
    argv = "fdisk -l | grep -E 'sda:|sdb:|sdc:|vda:|vdb:|vdc:' |awk -F ',' '{print $1}'"
    disk_module = 'cmd.run'

    result = Client(tgt, disk_module, argv)
    disk_dict = {}

    for i in result.keys():
        disk_infos = []

        if re.search("Disk", result[i]):
            disk_infos = result[i].split("\n")
        else:
            argv = None
            disk_module = 'disk.usage'
            ip_tgt = [i]
            result_w = Client(ip_tgt, disk_module, argv)
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


def get_mem_info(tgt):
    argv = None
    module = 'status.meminfo'
    result = Client(tgt, module, argv)
    mem_info = {}
    for ip in tgt:
        try:
            SwapTotal = int(result[ip]['SwapTotal']['value']) / 1024
        except:
            SwapTotal = 0

        mem_info[ip] = {"SwapTotal": SwapTotal}

    return mem_info

def main(tgt):
    os_info = get_os_info(tgt)
    disk_info = get_disk_info(tgt)
    mem_info = get_mem_info(tgt)
    data = {}
    for ip in tgt:
        try:
            sys_info = dict(os_info[ip].items() + disk_info[ip].items() + mem_info[ip].items())
            data[ip] = sys_info
        except:
            continue
    return data


if __name__ == '__main__':
    tgt = ['192.168.1.196', '192.168.1.199']
    result = main(tgt)
    print (result)
