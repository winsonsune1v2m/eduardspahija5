# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import ssl
import re
import time
import json
import MySQLdb
import sys,os
import salt_api
import urllib, urllib2
from aliyunsdkcore.client import AcsClient
from aliyunsdkcdn.request.v20141111 import RefreshObjectCachesRequest

import xml.etree.cElementTree as ET
from xml.dom.minidom import parseString
from django.shortcuts import render, HttpResponse, redirect
from wchart import config

reload(sys)
sys.setdefaultencoding("utf-8")

sql_host = '192.168.1.126'
sql_user = 'root'
sql_passwd = 'mysql'
sql_db = 'mtrops_v2'


def mysql_con(host, user, passwd, db, sql):
    # 打开数据库连接
    db = MySQLdb.connect(host, user, passwd, db, charset='utf8')
    # 使用cursor()方法获取操作游标
    cursor = db.cursor()
    # 使用execute方法执行SQL语句
    cursor.execute(sql)
    # 使用 fetchone() 方法获取一条数据
    data = cursor.fetchall()
    db.commit()
    # 关闭数据库连接
    db.close()
    return data


sql = "select git_name from app_code_gitcode"

data = mysql_con(sql_host, sql_user, sql_passwd, sql_db, sql)

site = []
for i in data:
    site.append(i[0])


def ReCDN(site_name, file_path):
    """
    阿里云 CDN 刷新
    """
    region_id = "cn-shenzhen"  # 区域ID

    mtr_access_key_id = config.MTR_ACCESS_KEY_ID  # access_key_id
    mtr_access_key_secret = config.MTR_ACCESS_KEY_SECRET  # access_key_secret

    mty_access_key_id = config.MTY_ACCESS_KEY_ID  # access_key_id
    mty_access_key_secret = config.MTY_ACCESS_KEY_SECRET  # access_key_secret

    if re.search(r'mtrp2p', site_name):
        client = AcsClient(mtr_access_key_id, mtr_access_key_secret, region_id)
    else:
        client = AcsClient(mty_access_key_id, mty_access_key_secret, region_id)

    request = RefreshObjectCachesRequest.RefreshObjectCachesRequest()

    re_url = 'https://%s/%s' % (site_name, file_path)

    url = re.sub("public/", "", re_url)

    request.set_action_name('RefreshObjectCaches')

    request.set_accept_format('json')

    request.set_ObjectPath(url)

    request.set_ObjectType('File')

    response = client.get_response(request)

    return response


def SendMSG(msg, sendto):
    """
    企业微信发送信息

    :param msg: 想要发送的内容
    :param sendto: 发送给谁，多个用户可以用"|" 分割
    :return: 结果
    """
    corpid = config.CORP_ID  # 企业ID

    zabbix_secretid = config.SECRETID  # 应用 Secret ID


    ssl._create_default_https_context = ssl._create_unverified_context

    token_url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s" % (corpid, zabbix_secretid)

    access_token = json.loads(urllib2.urlopen(token_url).read())['access_token']

    send_url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s" % access_token

    data = {
        "touser": sendto,
        "toparty": "",
        "totag": "",
        "msgtype": "text",  # 消息类型可以是文本，图片，视频语音等
        "agentid": config.AGENTID,  # 应用 AgentId
        "text": {
            "content": msg
        },
        "safe": 0
    }
    data = json.dumps(data, ensure_ascii=False)

    result = urllib2.urlopen(url='https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s' % access_token,
                             data=data)
    return result.read()


def handle(request):

    from WXBizMsgCrypt import WXBizMsgCrypt

    sToken = config.TOKEN  # 应用接收消息api Token

    sEncodingAESKey = config.AESKEY  # 应用接收消息api EncodingAESKey

    sCorpID = config.CORP_ID  # 企业ID

    wxcpt = WXBizMsgCrypt(sToken, sEncodingAESKey, sCorpID)

    if request.method == "GET":
        # 服务器url校验
        sVerifyMsgSig = request.GET.get("msg_signature")
        sVerifyTimeStamp = request.GET.get("timestamp")
        sVerifyNonce = request.GET.get("nonce")
        sVerifyEchoStr = request.GET.get("echostr")
        ret, sEchoStr = wxcpt.VerifyURL(sVerifyMsgSig, sVerifyTimeStamp, sVerifyNonce, sVerifyEchoStr)

    else:
        # 接收应用消息
        sReqMsgSig = request.GET.get("msg_signature")
        sReqTimeStamp = request.GET.get("timestamp")
        sReqNonce = request.GET.get("nonce")
        sReqData = request.body

        ret, sEchoStr = wxcpt.DecryptMsg(sReqData, sReqMsgSig, sReqTimeStamp, sReqNonce)

        domtree = parseString(sEchoStr)

        xml = domtree.documentElement

        FromUser = xml.getElementsByTagName('FromUserName')[0].firstChild.data

        CreateTime = xml.getElementsByTagName('CreateTime')[0].firstChild.data

        try:

            Content = xml.getElementsByTagName('Content')[0].firstChild.data
        except:
            Content = None

        AgentID = xml.getElementsByTagName('AgentID')[0].firstChild.data

        UpID = xml.getElementsByTagName('MsgId')[0].firstChild.data

        # 判断是否是来自应用ID 1000003 的消息
        if AgentID == str(config.AGENTID):
            # 如果用户在应用中发送"站点",则返回站点内容
            if Content == "站点":
                sendto = FromUser
                msg = "\n".join(site)
                SendMSG(msg, sendto)

            elif re.search(r"(更新代码|upcode|代码更新)", Content):

                data = Content.split("\n")

                tag = data[0]

                up_data = r"##".join(data[1:])
                try:
                    up_data = re.sub(r"\\", "/", up_data)
                except:
                    pass

                tags = tag.split()

                if len(tags) == 2:

                    if up_data:
                        site_name = tags[1]
                        CreateTime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

                        content = ''
                        for i in up_data.split("##"):
                            if re.search("commit_msg", i):
                                continue
                            else:
                                txt = i + "##"
                                content += txt
                        msg = u"User：%s\nSite：%s\nID：%s\nConnect：\n%s" % (
                            FromUser, site_name, UpID, re.sub(r"##", "\n", content))

                        status = "waiting"

                        sql = "INSERT INTO app_code_wchartlog(site_name, from_user, up_connect, up_id, add_time,status) VALUES ('%s', '%s', '%s', '%s', '%s','%s')" % (
                            site_name, FromUser, up_data, UpID, CreateTime, status)

                        mysql_con(sql_host, sql_user, sql_passwd, sql_db, sql)

                        send_user = config.RESP_USER
                        SendMSG(msg, send_user)
                    else:
                        sendto = FromUser
                        msg = "更新内容不能为空"
                        SendMSG(msg, sendto)
                else:
                    sendto = FromUser
                    msg = "请求不明确"
                    SendMSG(msg, sendto)


            elif re.search("ID：\d+", Content) and FromUser == config.ADMIN_UDSER:

                up_id = int(re.search("\d+", Content).group())
                sql = "SELECT * from app_code_wchartlog where up_id='%d'" % up_id
                data = mysql_con(sql_host, sql_user, sql_passwd, sql_db, sql)
                info = data[0]
                site_name = info[1]
                from_user = info[2]
                up_data = info[3]
                status = info[5]

                if status == "done":

                    SendMSG("请求已执行", config.ADMIN_UDSER)

                elif status == "waiting":

                    sql = "select id from app_code_gitcode where git_name='%s'" % site_name
                    data = mysql_con(sql_host, sql_user, sql_passwd, sql_db, sql)
                    site_id = int(data[0][0])


                    sql = "select host_ip_id,publist_dir from app_code_publist where gitcode_id='%d'" % site_id

                    data = mysql_con(sql_host, sql_user, sql_passwd, sql_db, sql)
                    ips = data

                    for j in ips:
                        host_id = j[0]
                        sql = "select host_ip from app_asset_host where id='%d'" % host_id

                        data = mysql_con(sql_host, sql_user, sql_passwd, sql_db, sql)

                        ip = data[0][0]

                        site_path = j[1]

                        all_up_com = ""

                        for i in up_data.split("##"):
                            if i:
                                if re.search(r"commit_msg", i):
                                    continue
                                else:
                                    up_com = "&& git checkout  origin/master %s" % i

                                all_up_com += up_com

                        code_dir  = os.path.join(site_path,site_name)

                        cmd = "cd %s && git fetch %s" % (code_dir,all_up_com)

                        salt = salt_api.SaltAPI()

                        ret = salt.salt_run_arg(ip,'cmd.run',cmd)

                        msg = "++++++++执行结果+++++++\n%s\n%s" % (ip,ret[ip])
                        resp_user = config.ADMIN_UDSER + "|" + from_user

                        SendMSG(msg, resp_user)

                        sql = "update app_code_wchartlog set status='done' where up_id='%d'" % up_id

                        mysql_con(sql_host, sql_user, sql_passwd, sql_db, sql)

                    for k in up_data.split("##"):
                        if re.search("(\.js$|\.css$|\.jpg$|\.gif$|\.png$)", k):
                            ReCDN(site_name, k)
                        else:
                            pass
                else:
                    pass

            else:
                pass

            return HttpResponse(sEchoStr)



if __name__ == "__main__":
    msg = "test"
    SendMSG(msg)

