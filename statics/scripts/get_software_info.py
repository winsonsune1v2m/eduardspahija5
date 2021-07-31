#!/usr/bin/python2.7
# conding:utf-8


import re

def Client(tgt, module, argv):
    import salt.client
    local = salt.client.LocalClient()
    if argv:
        result = local.cmd(tgt, module, [argv], tgt_type='list')
    else:
        result = local.cmd(tgt, module, tgt_type='list')
    return result


def main(tgt, tag):
    module = 'cmd.run'
    n_tag = "|".join(tag)
    argv = "netstat -tnlp | grep -E  '%s' |awk '{print $4,$7}'|sed -s 's/:\{1,3\}/\//' |sed -s 's/ /\//' | awk -F '/' '{print $2,$3,$NF}'" % n_tag
    result = Client(tgt, module, argv)

    info_ditc = {}
    for i in result.keys():

        if re.search("\d+", result[i]):
            infos = result[i].split("\n")
            n_infos = []

            for j in infos:
                b = j.split()
                n_infos.append({"port": b[0], "pid": b[1], "name": b[2].strip(":")})
            info_ditc[i] = n_infos
        else:
            pass
    data = {}
    for i in info_ditc.keys():
        info = {}
        for j in info_ditc[i]:
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
            argv = "find  /usr/ -name %s | grep -E '/sbin|/bin|/src'" % k
            result = Client([i], module, argv)
            cmd = result[i].split("\n")[0]
            argv = "%s --version ||%s -version ||%s -v||%s -V||%s version" % (cmd, cmd, cmd, cmd, cmd)

            result = Client([i], module, argv)
            version_infos = result[i]
            if re.search("\d+.\d+.\d+", version_infos):
                info[k]["version"] = re.search("\d+.\d+.\d+", version_infos).group()
            else:
                info[k]["version"] = "Unkonwn"

        argv = "php --version"
        result = Client([i], module, argv)
        version_infos = result[i]
        if re.search("\d+.\d+.\d+", version_infos):
            info["php"] = {}
            info["php"]["version"] = re.search("\d+.\d+.\d+", version_infos).group()
            info["php"]["name"] = "php"
            info["php"]["port"] = "None"

        data[i] = info

    return data


if __name__ == "__main__":
    tgt = ["192.168.1.218"]
    tag = ['php', 'nginx', 'redis', 'mysql', 'python', 'java']
    result = main(tgt, tag)
    print (result)
