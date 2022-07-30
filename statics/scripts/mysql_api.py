# -*- coding: utf-8 -*-

# @Time    : 2019-01-03 09:54
# @Author  : 小贰
# @FileName: mysql_api.py
# @function: 作者比较懒什么都没写


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
    host_ip = "192.168.1.126"
    db_port = 3306
    db_user = "root"
    db_passwd = "mysql"
    db_name = "saltops_v2"
    sql ="show databases"
    result = connet(host_ip, db_port, db_user, db_passwd, db_name,sql)
    print(result)



