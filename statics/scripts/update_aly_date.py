# -*- coding: utf-8 -*-

# @Time    : 2019-01-03 10:54
# @Author  : 小贰
# @FileName: update_aly_date.py
# @function: 更新阿里云服务器过期时间，手动执行（个人偷懒使用）

import redis
import json
from mysql_api import connet

conn = redis.Redis(host='192.168.1.218', port=6379)
mtr_data = conn.get('aly_ecs')
wms_data = conn.get('wms_ecs')
mty_data = conn.get('mty_ecs')
for i in json.loads(mtr_data)+json.loads(wms_data)+json.loads(mty_data):
    sql ="update app_asset_host set overdue_date='%s' where host_ip='%s'" % (i["exp_date"].split()[0],i["{#IP}"])
    ret = connet("192.168.1.126", 3306, 'root', 'mysql', 'mtrops_v2', sql)
