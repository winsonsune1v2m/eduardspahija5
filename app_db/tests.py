
import pymysql

sql = "SELECT * from $_$Inception_backup_information$_$ where sql_statement=\"insert into test_t(id,test) values(1,'test-1')\" or sql_statement=\"update test_t set test='test-2' where id=2\""

con = pymysql.connect(host='192.168.1.126', port=3306, user="root", passwd="mysql", db="192_168_1_126_3306_mtrops_v2", charset='utf8')
cur = con.cursor()
cur.execute(sql)
data = cur.fetchall()
print(data)
cur.close()
con.close()