# -*- coding: utf-8 -*-

# @Time    : 2019-01-15 10:55
# @Author  : 小贰
# @FileName: get_sofeware.py
# @function: 通过ansible setup 模块获取服务器基础信息

import json
from statics.scripts import ansible_api


def get_host_info(host_list, option_dict):
    """
    :param host_list:['127.0.0.1']
    :param option_dict:{"become": True, "remote_user": "opadmin"}
    """
    module_name = 'setup'
    module_args = ""
    result = ansible_api.run_ansible(module_name, module_args, host_list, option_dict)
    result = json.loads(result)['success']
    data = {}
    for i in result.keys():
        info = result[i]['ansible_facts']
        hostname = info['ansible_hostname']
        kernel = info['ansible_system']
        kernelrelease = info['ansible_kernel']
        cpu_model = info['ansible_processor'][2]
        num_cpus = info['ansible_processor_cores']
        productname = info['ansible_product_name']
        os_name = info['ansible_distribution']
        osrelease = info['ansible_distribution_version']
        mem_info = info['ansible_memory_mb']
        disk_info = info['ansible_mounts']
        interfaces = info['ansible_interfaces']
        inter_list = []
        n_disk_info = []
        for k in disk_info:
            n_disk_info.append({"size_total":k['size_total'],"size_available":k['size_available'],"device":k['device'],"mount":k["mount"],"fstype":k["fstype"]})
        for j in interfaces:
            try:
                key = "ansible_%s" % j
                inter_ipv4 = info[key]['ipv4']
                inter_ipv4["label"] = j
                try:
                    inter_ipv4["hwaddr"] = info[key]['macaddress']
                except:
                    inter_ipv4["hwaddr"] = "00:00:00:00:00:00"
                inter_list.append(inter_ipv4)
            except:
                continue
        new_info={"localhost": hostname,"kernel":kernel,"kernelrelease": kernelrelease,
                "cpu_model":cpu_model,"num_cpus": num_cpus,"productname":productname,
                "os": os_name,"osrelease":osrelease ,"mem_info":mem_info["real"],"interface": inter_list,"disk_info":n_disk_info,"swap_info":mem_info["swap"]}
        data[i] = new_info
    return data

if __name__ == "__main__":
    option_dict = {"become": True, "remote_user": "opadmin"}
    host_list = ["192.168.1.126"]
    result = get_host_info(host_list, option_dict)
    print(json.dumps(result,indent=4))