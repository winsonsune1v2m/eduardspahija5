# -*- coding: utf-8 -*-

# @Time    : 2019-01-10 15:22
# @Author  : 小贰
# @FileName: ansible_sync_hosts.py
# @function: sync host to ansible hosts file

import pymysql

def connet(host_ip,db_port,db_user,db_passwd,db_name,sql):
    try:
        db_port = int(db_port)
        db = pymysql.connect(
            host=host_ip,
            port=db_port,
            user=db_user,
            passwd=db_passwd,
            db=db_name,
            charset='utf8'
        )
        cur = db.cursor()
        cur.execute(sql)
        ret = cur.fetchall()
        db.commit()
        cur.close()
        db.close()
        return ret
    except Exception as e:
        result = e
    return result

if __name__ == "__main__":
    mtr_dict = {""}
    host_ip = "192.168.1.126"
    db_port = 3306
    db_user = "root"
    db_passwd = "mysql"
    db_name = "saltops_v2"
    sql ="SELECT host_ip,host_remove_port from app_asset_host A,app_asset_hostdetail B WHERE A.id=B.host_id and  B.os_type='Linux'"
    result = connet(host_ip, db_port, db_user, db_passwd, db_name,sql)
    F = open("/etc/ansible/hosts","w")
    for ip,port in result:
        if port=='22':
            F.write(ip+"\n")
        else:
            F.write(ip,"ansible_ssh_port="+port+"\n")
    F.close()
