#!/usr/bin/python
# coding:utf-8

import os
import re
import sys
import json


def git_clone(info):
    git_info = json.loads(info)
    git_dir = git_info['git_dir']
    git_url = git_info['git_url']
    git_user = git_info['git_user']
    git_passwd = git_info['git_passwd']
    git_sshkey = git_info['git_sshkey']
    code_runas = git_info['code_runas']

    os.system("echo %s  %s  %s  %s  %s  %s >/home/test.txt" % (git_dir, git_url,git_user,git_passwd,git_sshkey,code_runas))

if __name__ == "__main__":
    info = sys.argv[1]
    git_clone(info)
