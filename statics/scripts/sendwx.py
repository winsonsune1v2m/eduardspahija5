import urllib.request
import json

def get_token(url, corpid, corpsecret):
    token_url = '%s/cgi-bin/gettoken?corpid=%s&corpsecret=%s' % (url, corpid, corpsecret)
    token = json.loads(urllib.request.urlopen(token_url).read().decode())['access_token']
    return token


def params(msg,sendto):
    values = {
        "touser": sendto,
        "toparty":'',
        "msgtype": 'text',
        "agentid": 1000003,
        "text": {'content': msg},
        "safe": 0
        }
    msges=(bytes(json.dumps(values), 'utf-8'))
    return msges

def send_message(url,token, data):
        send_url = '%s/cgi-bin/message/send?access_token=%s' % (url,token)
        respone=urllib.request.urlopen(urllib.request.Request(url=send_url, data=data)).read()
        x = json.loads(respone.decode())['errcode']
        if x == 0:
            return 'Succesfully'
        else:
            return 'Failed'

if __name__ == '__main__':
    msg = 'test'
    sendto='LiZuXiang'
    corpid = 'ww99f*************79e3'
    corpsecret = 'RKBH0ehG*************TnUFznKBQ'
    url = 'https://qyapi.weixin.qq.com'
    msg = 'ID:13******470'

    test_token = get_token(url, corpid, corpsecret)
    msg_data = params(msg,sendto)
    send_message(url, test_token, msg_data)

