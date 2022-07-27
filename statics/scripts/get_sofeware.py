# -*- coding: utf-8 -*-

# @Time    : 2019-01-15 10:55
# @Author  : 小贰
# @FileName: get_sofeware.py
# @function: 通过ansible api 获取服务器运行中服务软件版本

import re
import json
from statics.scripts import ansible_api


def get_sofeware(host_list, option_dict, tag):
    """
    :param host_list:['127.0.0.1']
    :param option_dict:{"become": True, "remote_user": "opadmin"}
    :param tag: ['php', 'nginx', 'redis', 'mysql', 'python', 'java', "sshd"]
    """
    module_name = 'shell'
    n_tag = "|".join(tag)
    module_args = "netstat -tnlp | grep -E  '%s' |awk '{print $4,$7}'|sed -s 's/:\{1,3\}/\//' |sed -s 's/ /\//' | awk -F '/' '{print $2,$3,$NF}'" % n_tag

    n_result = ansible_api.run_ansible(module_name, module_args, host_list, option_dict)

    # 获取正在运行中的服务
    service_ditc = {}
    result = json.loads(n_result)['success']
    for i in result.keys():
        n_infos = []
        for j in result[i]['stdout_lines']:
            b = j.split()
            port = b[0]
            pid = b[1]
            service_name = b[2].strip(":")
            n_infos.append({"port": port, "pid": pid, "name": service_name})

        service_ditc[i] = n_infos

    data = {}
    for i in service_ditc.keys():
        info = {}
        for j in service_ditc[i]:
            key = j['name']

            j['port'] = [j['port']]

            if key in info.keys():
                try:
                    if j['port'][0] not in info[key]['port']:
                        info[key]['port'] = info[key]['port'] + j['port']
                    else:
                        pass
                except:
                    pass
            else:
                info[key] = j

        for k in info.keys():
            if re.search("redis", k):
                K = "redis-cli"
            else:
                K = k
            module_args = "find  /usr/ -name %s|grep -E '/sbin|/bin|/src'" % K
            s_result = ansible_api.run_ansible(module_name, module_args, [i], option_dict)
            cmd = json.loads(s_result)['success'][i]["stdout_lines"][0]
            module_args = "%s --version;%s -version ;%s -v;%s -V;%s version" % (cmd, cmd, cmd, cmd, cmd)
            v_result = ansible_api.run_ansible(module_name, module_args, [i], option_dict)
            v_result = json.loads(v_result)

            version_info = None
            if v_result['success']:
                if v_result['success'][i]["stdout_lines"]:
                    version_info = ",".join(v_result['success'][i]["stdout_lines"])
            elif v_result['failed']:
                if v_result['failed'][i]["stderr_lines"]:
                    version_info = ",".join(v_result['failed'][i]["stderr_lines"])
            if version_info:
                if re.search("\d+\.\d+", version_info):
                    info[k]["version"] = re.search("\d+\.\d+", version_info).group()
                else:
                    info[k]["version"] = "Unkonwn"
            else:
                info[k]["version"] = "Unkonwn"

        module_args = "php --version"
        result = ansible_api.run_ansible(module_name, module_args, [i], option_dict)
        result = json.loads(result)['success']
        if result:
            version_infos = ",".join(result[i]["stdout_lines"])
            if re.search("\d+\.\d+", version_infos):
                info["php"] = {}
                info["php"]["version"] = re.search("\d+\.\d+", version_infos).group()
                info["php"]["name"] = "php"
                info["php"]["port"] = "None"

        data[i] = info

    return data


if __name__ == "__main__":
    option_dict = {"become": True, "remote_user": "opadmin"}
    host_list = ['192.168.1.126']
    tag = ['php', 'nginx', 'redis', 'mysql', 'python', 'java', "sshd"]
    result = get_sofeware(host_list, option_dict, tag)
    print(json.dumps(result, indent=4))
