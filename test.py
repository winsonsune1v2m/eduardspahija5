#!/usr/bin/python
#coding:UTF-8


import re
import os

def rename():
    cur_dir = os.getcwd()
    for i in os.listdir(cur_dir):
        if re.match("\d+-\d+-\d+",i):
            j = re.sub("2018","2017",i)
            cmd = "mv %s %s" % (i,j)
            os.system(cmd)
        else:
            pass
    return True


def cp_file(month_list):
    cur_dir = os.getcwd()

    for i in os.listdir(cur_dir):
        if re.match("\d+-\d+-\d+",i):
            for M in  month_list:
                j = re.sub("-03-",M,i)
                cmd = "cp %s %s" % (i,j)
                os.system(cmd)



def sed_file(month_dict):
    cur_dir = os.getcwd()
    for i in os.listdir(cur_dir):
        if re.match("\d+-\d+-\d+", i):
            m = month_dict[i.split('-')[1]]
            cmd ='sed -i "s#Mar/2018#%s/2017#" %s' % (m,i)
            os.system(cmd)


if __name__ == "__main__":
    month_list = ["-06-","-07-","-08-","-09-","-10-","-11-"]
    month_dict = {"01":"Jan","02":"Feb","03":"Mar","04":"Apr","05":"May","06":"Jun","07":"Jul","08":"Aug","09":"Sep","10":"Oct","11":"Nov","12":"Dec"}
    #rename()
    #cp_file(month_list)
    sed_file(month_dict)