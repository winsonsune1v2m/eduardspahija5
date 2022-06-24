import pymysql
import json


def inception(connstr_target,operation,connstr_inception,sql):
    # inception格式化
    prefix_format = "/*--user={};--password={};--host={};{};--port={};*/ ".format(connstr_target['user'],
                                                                                          connstr_target['password'],
                                                                                          connstr_target['host'],
                                                                                          operation,
                                                                                          connstr_target['port']) \
                    + '\n' \
                    + "inception_magic_start;"
    suffix_format = "inception_magic_commit;"
    try:
        # 将待执行的sql语句组合成inception识别的格式
        sql_demo1_with_format = prefix_format + "\n" + sql + "\n" + suffix_format

        # 连接至inception 服务器
        conn_inception = pymysql.connect(host=connstr_inception['host'],
                                          port=connstr_inception['port'],
                                          user=connstr_inception['user'],
                                          password=connstr_inception['password'],
                                          charset=connstr_inception['charset'],
                                          use_unicode=True
                                         )
        cur = conn_inception.cursor()
        cur.execute(sql_demo1_with_format)
        result = cur.fetchall()
        num_fields = len(cur.description)
        field_names = [i[0] for i in cur.description]
        data = []
        for row in result:
            info = {}
            for i in range(11):
                info[str(field_names[i])] = str(row[i])
            data.append(info)
        cur.close()
        conn_inception.close()
        return data
    except Exception as err:
        return err


if __name__ == "__main__":
    #operation = '--enable-check'
    operation = '--enable-execute'
    # 发布目标服务器
    connstr_target = {'host': '127.0.0.1', 'port': 3306, 'user': 'root', 'password': 'mysql', 'db': '192_168_1_126_3306_mtrops_v2', 'charset': 'utf8mb4'}
    # inception server
    connstr_inception = {'host': '192.168.1.126', 'port': 6669, 'user': '', 'password': '', 'db': '', 'charset': 'utf8'}

    use_sql = "use 192_168_1_126_3306_mtrops_v2;\n"

    sql = """SELECT * from $_$Inception_backup_information$_$ where sql_statement="insert into test_t(id,test) values(1,'test-1')" or sql_statement="update test_t set test='test-2' where id=2";
"""

    exec_sql = use_sql + sql
    result = inception(connstr_target,operation,connstr_inception,exec_sql)
    print(json.dumps(result,indent=True))

