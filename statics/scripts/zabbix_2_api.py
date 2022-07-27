# -*- coding: utf-8 -*-

# @Time    : 2019-01-09 10:24
# @Author  : 小贰
# @FileName: zabbix_2_api.py
# @function: zabbix api for python 2.x

import json
import urllib2
from urllib2 import URLError
import sys, argparse


class zabbix_api:
    def __init__(self,url,user,passwd):
        self.url = url
        self.user = user
        self.passwd = passwd
        self.header = {"Content-Type": "application/json"}

    def user_login(self):
        data = json.dumps({
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": {
                "user": self.user,  # 修改用户名
                "password": self.passwd  # 修改密码
            },
            "id": 0
        })
        request = urllib2.Request(self.url, data)
        for key in self.header:
            request.add_header(key, self.header[key])
        try:
            result = urllib2.urlopen(request)
        except URLError as e:
            print("\033[041m 用户认证失败，请检查 !\033[0m", e.code)
        else:
            response = json.loads(result.read())
            result.close()
            self.authID = response['result']
            return self.authID

    def main(self,method,params):
        data = json.dumps({
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "auth": self.user_login(),
            "id": 1
        })
        request = urllib2.Request(self.url, data)
        for key in self.header:
            request.add_header(key, self.header[key])

        try:
            result = urllib2.urlopen(request)
        except URLError as e:
            if hasattr(e, 'reason'):
                print('We failed to reach a server.')
                print('Reason: ', e.reason)
            elif hasattr(e, 'code'):
                print('The server could not fulfill the request.')
                print('Error code: ', e.code)
        else:
            response = json.loads(result.read())
            # print response
            for host in response['result']:
                print ("HostID : %s\t HostName : %s\t" % (host['hostid'], host['name']))
            result.close()
            # print "主机数量: \033[31m%s\033[0m"%(len(response['result']))


if __name__ == "__main__":
    url = 'http://192.168.1.218/zabbix/api_jsonrpc.php'
    user = "admin"
    passwd = "zabbix"
    zabbix = zabbix_api(url,user,passwd)
    method = "host.get"
    params = {
        "output": ["hostid", "name"],
        "templateids": ["10105"]
    }
    zabbix.main(method,params)

