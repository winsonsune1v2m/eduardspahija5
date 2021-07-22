#!/usr/bin/python
# coding:utf-8

import os

def git_clone(site_dir,site_url):
    if os.path.exists(site_dir):
        pass
    else:
        os.makedirs(site_dir)

    com_env = "kill -9 `ps -e | grep ssh-agent |awk '{print $1}'` >& /dev/null && eval `ssh-agent` && ssh-add /home/www/.ssh/id_rsa"

    cmd = "%s;cd %s && git clone %s" % (com_env, site_dir, site_url)
    os.system(cmd)

    cmd_chown="chown -R www.www %s" % site_dir

    os.system(cmd_chown)

if __name__ == "__main__":
    site_dir = '/'
    site_url = 'ssh://git@gitee.com:12x/mtrops_v2.git'
    git_clone(site_dir, site_url)
