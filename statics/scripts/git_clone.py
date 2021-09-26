#!/usr/bin/python
# coding:utf-8

import os
import re
import sys
import json


def git_clone(argv):
    git_dir = argv['git_dir']
    git_url = argv['git_url']
    git_user = argv['git_user']
    git_passwd = argv['git_passwd']
    git_sshkey = argv['git_sshkey']
    code_runas = argv['code_runas']

    if os.path.exists(git_dir):
        pass
    else:
        os.makedirs(git_dir)

    if git_sshkey != "None":
        sshkey_dir = os.path.join(git_dir, ".sshkey")

        if os.path.exists(sshkey_dir):
            pass
        else:
            os.makedirs(sshkey_dir)
        ssh_key_file = os.path.join(sshkey_dir, "id_rsa")

        f = open(ssh_key_file, 'w')

        for i in json.dumps(git_sshkey).split(r"\\n"):
            f.write(i.strip("\""))
            f.write("\n")

        f.close()

        cmd_chmod = "chmod 600 %s" % ssh_key_file
        os.system(cmd_chmod)

        com_env = "kill -9 $SSH_AGENT_PID;eval `ssh-agent` && ssh-add %s" % ssh_key_file

        cmd = "%s && cd %s && git clone %s" % (com_env, git_dir, git_url)

    else:
        if git_user and git_passwd:
            lg_info = "%s:%s" % (git_user, git_passwd)
            lg_info = re.sub("@", "%40", lg_info)
            url_list = git_url.split("//")
            new_url = "%s//%s@%s" % (url_list[0], lg_info, url_list[1])
            cmd = "cd %s && git clone %s" % (git_dir, new_url)
        else:
            cmd = "cd %s && git clone %s" % (git_dir, git_url)
    os.system(cmd)

    if code_runas:
        cmd_chown = "chown -R %s.%s %s" % (git_dir, code_runas, code_runas)
        os.system(cmd_chown)


if __name__ == "__main__":
    argv = sys.argv[1:]
    data_key = []
    data_val = []
    n = 1
    for i in argv:
        j = i.strip(',').strip("{}").strip(":")
        if n % 2 == 1:
            data_key.append(j)
        else:
            data_val.append(j)
        n += 1

    data_dict = dict(map(lambda x, y: [x, y], data_key, data_val))
    git_clone(data_dict)
