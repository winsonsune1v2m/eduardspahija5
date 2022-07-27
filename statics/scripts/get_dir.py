# -*- coding: utf-8 -*-

# @Time    : 2019-01-04 16:18
# @Author  : 小贰
# @FileName: get_dir.py
# @function: 获取服务器目录

import os,json,sys

def get_dir(cur_dir=os.getcwd()):
    file_list = []
    dir_list = []
    for i in os.listdir(cur_dir):
        if os.path.isdir(os.path.join(cur_dir,i)):
            dir_list.append(i)
        else:
            file_list.append(i)
    data= {'dir':dir_list,'file':file_list,'cur_dir':cur_dir}
    return  json.dumps(data,indent=4)

if __name__ == "__main__":
    cur_dir = sys.argv[1]
    ret = get_dir(cur_dir)
    print(ret)