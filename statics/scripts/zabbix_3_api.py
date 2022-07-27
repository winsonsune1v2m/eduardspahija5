# -*- coding: utf-8 -*-

# @Time    : 2019-01-09 10:24
# @Author  : 小贰
# @FileName: zabbix_2_api.py
# @function: zabbix api for python 3.x

import json
from urllib import request, parse

class zabbix_api:
    def __init__(self,url,user,passwd):
        self.url = url
        self.user = user
        self.passwd = passwd
        self.header = {"Content-Type": "application/json"}

    def user_login(self):
        data = {
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": {
                "user": self.user,
                "password": self.passwd
            },
            "id": 0
        }
        # 由于API接收的是json字符串，故需要转化一下
        data = json.dumps(data).encode('utf-8')
        # 对请求进行包装
        req = request.Request(url, headers=self.header, data=data)
        try:
            # 打开包装过的url
            result = request.urlopen(req)
        except Exception as e:
            print("Auth Failed, Please Check Your Name And Password:", e)
        else:
            response = result.read()
            # 上面获取的是bytes类型数据，故需要decode转化成字符串
            page = response.decode('utf-8')
            # 将此json字符串转化为python字典
            page = json.loads(page)
            self.authID = page['result']
            result.close()
            return self.authID
    def main(self,method,params):
        data = {
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "auth": self.user_login(),
            "id": 1
        }
        data = json.dumps(data).encode("utf-8")
        req = request.Request(url, headers=self.header, data=data)
        try:
            result = request.urlopen(req)
        except Exception as e:
            print('Error code: ', e)
        else:
            response = result.read()
            # 上面获取的是bytes类型数据，故需要decode转化成字符串
            page = response.decode('utf-8')
            # 将此json字符串转化为python字典
            page = json.loads(page)
            for host in page['result']:
                print ("HostID : %s\t HostName : %s\t" % (host['hostid'], host['name']))
            result.close()
            # print "主机数量: \033[31m%s\033[0m"%(len(response['result']))

if __name__ == "__main__":
    url = 'http://192.168.1.218/zabbix/api_jsonrpc.php'
    user = "admin"
    passwd = "zabbix"
    zabbix = zabbix_api(url, user, passwd)
    method = "host.get"
    params = {
        "output": ["hostid", "name"],
        "templateids": ["10105"]
    }
    zabbix.main(method, params)



