import pymysql


def connet(host_ip,db_port,db_user,db_passwd,db_name):
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
        db.close()
        result = "success"
    except Exception as e:
        result = e

    return result

if __name__ == "__main__":
    host_ip = "192.168.1.126"
    db_port = 6669
    db_user = ""
    db_passwd = ""
    db_name = ""
    result = connet(host_ip, db_port, db_user, db_passwd, db_name)
    print(result)