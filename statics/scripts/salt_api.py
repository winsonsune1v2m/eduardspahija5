
import urllib,json
import urllib.request
import urllib.parse
import ssl


# 使用urllib2请求https出错，做的设置
ssl._create_default_https_context = ssl._create_unverified_context


class SaltAPI(object):
    __token_id = ''

    def __init__(self,salt_url,salt_user,salt_passwd):
        self.__url = salt_url
        self.__user = salt_user
        self.__password = salt_passwd

    def token_id(self):
        """
            用户登陆和获取token
        :return:
        """
        params = {'eauth': 'pam', 'username': self.__user, 'password': self.__password}
        encode = urllib.parse.urlencode(params)
        obj = urllib.parse.unquote(encode).encode('utf-8')
        content = self.postRequest(obj, prefix='/login')

        try:
            self.__token_id = content['return'][0]['token']
        except KeyError:
            raise KeyError

        return content['return'][0]['token']

    def postRequest(self,obj,prefix='/'):
        url = self.__url + prefix
        headers = {'X-Auth-Token': self.__token_id}
        req = urllib.request.Request(url, obj, headers)
        opener = urllib.request.urlopen(req)
        content = json.loads(opener.read())
        return content


    def salt_run(self, tgt, fun):
        """
        远程执行模块，无参数
        :param tgt: "host1,host2"
        :param fun: 模块
        :param arg: 参数
        :return: dict, {'minion1': 'ret', 'minion2': 'ret'}
        """
        params = ([('client', 'local'), ('tgt', tgt), ('fun', fun),('expr_form', 'list')])
        obj = urllib.parse.urlencode(params).encode('utf-8')
        self.token_id()
        content = self.postRequest(obj)
        ret = content['return'][0]
        return ret

    def salt_run_arg(self, tgt, fun, arg,runas='root'):
        """
        远程执行模块，有参数
        :param tgt: "host1,host2"
        :param fun: 模块
        :param arg: 参数
        :return: dict, {'minion1': 'ret', 'minion2': 'ret'}
        """
        #添加同名参数
        run_user = 'runas=%s' % runas
        params = ([('client', 'local'), ('tgt', tgt),('fun', fun),('arg',arg),('expr_form','list'),('arg',run_user)])
        obj = urllib.parse.urlencode(params).encode('utf-8')

        self.token_id()
        content = self.postRequest(obj)
        ret = content['return'][0]
        return ret

    def salt_run_script(self, tgt, fun, arg,script_arg,runas='root'):
        """
        远程执行模块，有参数
        :param tgt: "host1,host2"
        :param fun: 模块
        :param arg: 参数
        :return: dict, {'minion1': 'ret', 'minion2': 'ret'}
        """
        #添加同名参数
        run_user = 'runas=%s' % runas
        params = ([('client', 'local'), ('tgt', tgt),('fun', fun),('arg',arg),('arg',script_arg),('arg',run_user),('expr_form','list')])
        obj = urllib.parse.urlencode(params).encode('utf-8')

        self.token_id()
        content = self.postRequest(obj)
        ret = content['return'][0]
        return ret
    def salt_run_upfile(self, tgt, fun,arg_src,arg_dest,runas='root'):
        """
        远程执行模块，有参数
        :param tgt: "host1,host2"
        :param fun: 模块
        :param arg: 参数
        :return: dict, {'minion1': 'ret', 'minion2': 'ret'}
        """
        #添加同名参数
        run_user = 'runas=%s' % runas
        params = ([('client', 'local'), ('tgt', tgt),('fun', fun),('arg',arg_src),('arg',arg_dest),('arg','makedirs=True'),('arg',run_user),('expr_form','list')])
        obj = urllib.parse.urlencode(params).encode('utf-8')

        self.token_id()
        content = self.postRequest(obj)
        ret = content['return'][0]
        return ret

    def salt_run_downfile(self, tgt, fun, arg):
        """
        远程执行模块，有参数
        :param tgt: "host1,host2"
        :param fun: 模块
        :param arg: 参数
        :return: dict, {'minion1': 'ret', 'minion2': 'ret'}
        """
        #添加同名参数
        params = ([('client', 'local'), ('tgt', tgt),('fun', fun),('arg',arg),('expr_form','list')])
        obj = urllib.parse.urlencode(params).encode('utf-8')

        self.token_id()
        content = self.postRequest(obj)
        ret = content['return'][0]
        return ret


if __name__ == '__main__':
    salt_url = "https://192.168.1.126:8081"
    salt_user = "saltapi"
    salt_passwd = "saltapi"
    salt = SaltAPI(salt_url,salt_user,salt_passwd)
    minions = ['192.168.1.216']
    hosts=",".join(minions)
    ret = salt.salt_run_arg(hosts,'cmd.run','ls')
    print(ret)
