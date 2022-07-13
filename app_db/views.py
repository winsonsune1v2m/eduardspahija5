import json,re
from django.shortcuts import render,HttpResponse
from django.views import View
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from app_auth.views import login_check,perms_check
from app_db import models as db
from app_auth import models as auth_db
from app_asset import models as asset_db
from django.db.models import Q
from statics.scripts import sql_test_con,encryption,inception
from mtrops_v2.settings import SECRET_KEY,BACKDB_PASSWD
import pymysql
from binlog2sql.binlog2sql.binlog2sql import Binlog2sql
from binlog2sql.binlog2sql.binlog2sql_util import command_line_args



class DBList(View):
    """数据库资产"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(DBList,self).dispatch(request,*args,**kwargs)

    def get(self,request):
        title = "数据库"
        role_id = request.session['role_id']
        host_obj = asset_db.Host.objects.filter(Q(role__id=role_id) & Q(hostdetail__host_status="up"))
        user_name = request.session['user_name']
        user = auth_db.User.objects.get(user_name=user_name)

        db_obj = db.DB.objects.all()
        user_obj = auth_db.User.objects.all()

        return render(request,'db_list.html', locals())

    def post(self,request):
        action = request.POST.get('action')
        db_name = request.POST.get('db_name')
        db_host = request.POST.get('db_host')
        db_port = request.POST.get('db_port')
        db_user = request.POST.get('db_user')
        db_passwd = request.POST.get('db_passwd')
        user_id = request.POST.get('user_id')
        db_msg = request.POST.get('db_msg')
        host_ip = asset_db.Host.objects.get(id=db_host).host_ip
        if action=="test_con":
            result = sql_test_con.connet(host_ip,db_port,db_user,db_passwd,db_name)
            return HttpResponse(result)
        else:
            # 加密密码
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)  # 初始化密钥
            aes_passwd = pc.encrypt(db_passwd)
            status = sql_test_con.connet(host_ip, db_port, db_user, db_passwd, db_name)
            if status=="success":
                db_status="up"
            else:
                db_status = "down"
            db_obj = db.DB(db_name=db_name,db_host_id=db_host,db_port=db_port,db_user=db_user,db_passwd=aes_passwd,user_id=user_id,db_msg=db_msg,db_status=db_status)
            db_obj.save()
            result="数据库添加成功，请刷新查看！"
            return HttpResponse(result)

    def put(self,request):
        req_info = eval(request.body.decode())
        action = req_info.get('action')
        db_name = req_info.get('db_name')
        db_host = req_info.get('db_host')
        db_port = req_info.get('db_port')
        db_user = req_info.get('db_user')
        db_passwd = req_info.get('db_passwd')
        user_id = req_info.get('user_id')
        db_msg = req_info.get('db_msg')
        db_id = req_info.get('db_id')
        try:
            host_ip = asset_db.Host.objects.get(id=db_host).host_ip
        except:
            pass
        if action == "con_check":
            db_obj = db.DB.objects.get(id=db_id)
            db_passwd = db_obj.db_passwd
            # 密码解密
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)
            passwd = db_passwd.strip("b").strip("'").encode(encoding="utf-8")
            de_passwd = pc.decrypt(passwd).decode()
            status = sql_test_con.connet(db_obj.db_host.host_ip, db_obj.db_port, db_obj.db_user, de_passwd, db_obj.db_name)
            if status=="success":
                db_status="up"
                data = "数据库连接成功，已更新状态！"
            else:
                db_status = "down"
                data = "数据库连接失败，请检查！"
            db_obj.db_status = db_status
            db_obj.save()
        elif action =="put":
            """修改数据库信息"""
            # 加密密码
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)  # 初始化密钥
            aes_passwd = pc.encrypt(db_passwd)
            db_obj = db.DB.objects.get(id=db_id)
            db_obj.db_name = db_name
            db_obj.db_host_id = db_host
            db_obj.db_port = db_port
            db_obj.db_user = db_user
            db_obj.db_passwd = aes_passwd
            db_obj.user_id = user_id
            db_obj.db_msg = db_msg
            status = sql_test_con.connet(host_ip, db_port, db_user, db_passwd, db_name)
            if status == "success":
                db_status = "up"
            else:
                db_status = "down"
            db_obj.db_status = db_status
            db_obj.save()
            data = "数据库信息已修改，请刷新查看！"
        elif action =="edit_test_con":
            data = sql_test_con.connet(host_ip, db_port, db_user, db_passwd, db_name)
        else:
            """获取修改信息"""
            db_info = db.DB.objects.get(id=db_id)
            # 密码解密
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)
            passwd = db_info.db_passwd.strip("b").strip("'").encode(encoding="utf-8")
            de_passwd = pc.decrypt(passwd).decode()
            info_json = {'db_id': db_info.id, 'db_name': db_info.db_name,
                         'db_host': db_info.db_host_id,'db_port': db_info.db_port,
                         'db_user': db_info.db_user,'db_passwd': de_passwd,
                         'db_msg': db_info.db_msg, 'user': db_info.user_id,'db_env': db_info.db_env}
            data = json.dumps(info_json, ensure_ascii=False)
        return HttpResponse(data)

    def delete(self,request):
        """删除数据库"""
        req_info = eval(request.body.decode())
        db_id = req_info.get("db_id")
        db.DB.objects.get(id=db_id).delete()
        data = "数据库资产已删除,数据库仍保留在服务器上，如要彻底删除，请登录服务器手动执行！(删库有风险，操作需谨慎！)"
        return HttpResponse(data)

class Inception(View):
    """inception设置"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(Inception,self).dispatch(request,*args,**kwargs)

    def get(self,request):
        title = "Inception"
        inc_obj = db.Inception.objects.all()
        incdb_obj = db.IncDB.objects.first()
        backdb_obj = db.BackDb.objects.first()
        return render(request,'db_inc.html', locals())

    def post(self,request):
        action = request.POST.get("action")
        inc_ip = request.POST.get("inc_ip")
        inc_port = request.POST.get("inc_port")
        if action == "check_inc":
            data = sql_test_con.connet(inc_ip,inc_port,"","","")
        elif action == "add_inc":
            try:
                dbckdb_obj = db.IncDB.objects.first().delete()
                dbckdb_obj.save()
            except:
                dbckdb_obj = db.IncDB(inc_ip=inc_ip,inc_port=inc_port)
                dbckdb_obj.save()
                data = "Inception 已设置！"
            db_port = int(inc_port)
            con = pymysql.connect(host=inc_ip,port=db_port,user="",passwd="",db="",charset='utf8')
            cur = con.cursor()
            cur.execute("inception get variables")
            cur.close()
            con.close()
            request = cur.fetchall()
            inc_option ={}
            for i,j in request:
                inc_option[i] = j
            try:
                dbckdb_obj = db.BackDb.objects.first().delete()
                dbckdb_obj.save()
            except:
                dbckdb_obj = db.BackDb(back_db_ip=inc_option['inception_remote_backup_host'], back_db_port=inc_option['inception_remote_backup_port'],back_db_user=inc_option['inception_remote_system_user'],back_db_passwd=inc_option['inception_remote_system_password'])
                dbckdb_obj.save()
            inc_obj = db.Inception.objects.all()
            for i in inc_obj:
                i.inc_value = inc_option[i.inc_title]
                i.save()
        return HttpResponse(data)

    def put(self,request):
        #修改incepition参数
        req_info = eval(request.body.decode())
        inc_id = req_info.get("inc_id")
        status = req_info.get("status")
        inc_obj = db.Inception.objects.get(id=inc_id)
        inc_obj.inc_value = status
        inc_obj.save()
        incdb_obj = db.IncDB.objects.first()
        db_port = int(incdb_obj.inc_port)
        con = pymysql.connect(host=incdb_obj.inc_ip, port=db_port, user="", passwd="", db="", charset='utf8')
        cur = con.cursor()
        cur.execute("inception set %s='%s'" % (inc_obj.inc_title,status))
        cur.close()
        con.close()
        return HttpResponse("已更新")


class WorkOrder(View):
    """inception设置"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(WorkOrder,self).dispatch(request,*args,**kwargs)

    def get(self,request):
        title = "SQL工单"
        user_name = request.session['user_name']
        user = auth_db.User.objects.get(user_name=user_name)
        user_obj = auth_db.User.objects.all()
        db_obj = db.DB.objects.all()
        return render(request,'db_order.html', locals())

    def post(self,request):
        action = request.POST.get('action')
        db_id = request.POST.get('db_id')
        sql = request.POST.get('sql')
        msg = request.POST.get('msg')
        review_user_id = request.POST.get('review_user_id')
        if action == "check_sql":
            db_obj = db.DB.objects.get(id=db_id)
            db_host = db_obj.db_host.host_ip
            db_name = db_obj.db_name
            db_port = db_obj.db_port
            db_user = db_obj.db_user
            db_passwd = db_obj.db_passwd
            # 密码解密
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)
            passwd = db_passwd.strip("b").strip("'").encode(encoding="utf-8")
            de_passwd = pc.decrypt(passwd).decode()
            incdb_obj = db.IncDB.objects.first()
            operation = '--enable-check'
            # 发布目标服务器
            connstr_target = {'host': db_host, 'port': int(db_port), 'user': db_user, 'password': de_passwd,'db': db_name,'charset': 'utf8'}
            # inception server
            connstr_inception = {'host': incdb_obj.inc_ip, 'port': int(incdb_obj.inc_port), 'user': '', 'password': '', 'db': '','charset': 'utf8'}
            use_sql = "use %s;\n" % db_name
            exec_sql = use_sql+sql
            result = inception.inception(connstr_target, operation, connstr_inception,exec_sql)
            try:
                return HttpResponse(json.dumps(result))
            except:
                return HttpResponse(result)
        else:
            db_obj = db.DB.objects.get(id=db_id)
            db_host = db_obj.db_host.host_ip
            db_name = db_obj.db_name
            db_port = db_obj.db_port
            db_user = db_obj.db_user
            db_passwd = db_obj.db_passwd
            # 密码解密
            key = SECRET_KEY[2:18]
            pc = encryption.prpcrypt(key)
            passwd = db_passwd.strip("b").strip("'").encode(encoding="utf-8")
            de_passwd = pc.decrypt(passwd).decode()
            incdb_obj = db.IncDB.objects.first()
            #inc执行参数，仅检查不执行语句
            operation = '--enable-check'
            # 发布目标服务器
            connstr_target = {'host': db_host, 'port': int(db_port), 'user': db_user, 'password': de_passwd,
                              'db': db_name, 'charset': 'utf8'}
            # inception server
            connstr_inception = {'host': incdb_obj.inc_ip, 'port': int(incdb_obj.inc_port), 'user': '', 'password': '',
                                 'db': '', 'charset': 'utf8'}
            use_sql = "use %s;\n" % db_name
            exec_sql = use_sql + sql
            #执行检查
            result = inception.inception(connstr_target, operation, connstr_inception, exec_sql)
            user_name = request.session['username']
            try:
                inc_status = json.dumps(result)
            except:
                inc_status = result

            #添加工单
            work_obj = db.WorkOrderLog(db_id=db_id,sql=sql,msg=msg,review_user_id=review_user_id,from_user=user_name,status="待执行",inc_status=inc_status)
            work_obj.save()
            return HttpResponse("工单已提交，等待审核！")

class OrderLog(View):
    """inception设置"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(OrderLog,self).dispatch(request,*args,**kwargs)

    def get(self,request):
        title = "工单处理"
        log_obj = db.WorkOrderLog.objects.all().order_by("-create_time")
        log_list = []
        for i in log_obj:
            try:
                inc_status = json.loads(i.inc_status)
                error_count = 0
                for j in inc_status:
                    error_count += int(j['errlevel'])
            except:
                error_count = 9999
            log_list.append({'id':i.id,'create_time':i.create_time,'from_user':i.from_user,'db_env':i.db.db_env,
                             'host_ip':i.db.db_host.host_ip,'db_name':i.db.db_name,'sql':i.sql,'inc_status':i.inc_status,
                             'msg':i.msg,'status':i.status,'ready_name':i.review_user.ready_name,'error_count':error_count})
        return render(request,'db_orderlog.html', locals())

    def post(self,request):
        order_id=request.POST.get('order_id')
        action = request.POST.get('action')
        user_name = request.session['username']
        order_obj = db.WorkOrderLog.objects.get(id=order_id)
        if action == 'exec':
            if user_name == order_obj.review_user.ready_name:
                if order_obj.status == "待执行":
                    db_host = order_obj.db.db_host.host_ip
                    db_name = order_obj.db.db_name
                    db_port = order_obj.db.db_port
                    db_user = order_obj.db.db_user
                    db_passwd = order_obj.db.db_passwd
                    # 密码解密
                    key = SECRET_KEY[2:18]
                    pc = encryption.prpcrypt(key)
                    passwd = db_passwd.strip("b").strip("'").encode(encoding="utf-8")
                    de_passwd = pc.decrypt(passwd).decode()
                    #inception
                    incdb_obj = db.IncDB.objects.first()
                    # inc执行参数，执行SQL语句并且备份
                    operation = '--enable-execute;--enable-ignore-warnings;--enable-remote-backup'
                    # 目标服务器
                    connstr_target = {'host': db_host, 'port': int(db_port), 'user': db_user, 'password': de_passwd,
                                      'db': db_name, 'charset': 'utf8'}
                    # inception 服务器信息
                    connstr_inception = {'host': incdb_obj.inc_ip, 'port': int(incdb_obj.inc_port), 'user': '',
                                         'password': '',
                                         'db': '', 'charset': 'utf8'}
                    #inception 执行的语句
                    use_sql = "use %s;\n" % db_name
                    exec_sql = use_sql + order_obj.sql
                    # 执行检查
                    result = inception.inception(connstr_target, operation, connstr_inception, exec_sql)

                    try:
                        exec_status = json.dumps(result)
                    except:
                        exec_status = result
                    #更新工单状态，保存执行结果
                    order_obj.status = "已执行"
                    order_obj.exec_result = exec_status
                    order_obj.save()
                    data = '该工单已执行！'
                else:
                    data = '工单状态异常，无法执行！'
            else:
                data = '您不是该工单审核人，无法操作！'

        elif action == 'giveup':
            order_obj.status = "已放弃"
            order_obj.save()
            data = '该工单已放弃，请重新提交工单！'
        else:
            dbckdb_obj = db.BackDb.objects.first()
            db_name = re.sub("\.","_",order_obj.db.db_host.host_ip+"_"+str(order_obj.db.db_port)+"_"+order_obj.db.db_name)
            if order_obj.status == "已执行":
                key = SECRET_KEY[2:18]
                pc = encryption.prpcrypt(key)
                passwd = order_obj.db.db_passwd.strip("b").strip("'").encode(encoding="utf-8")
                de_passwd = pc.decrypt(passwd).decode()

                #获取工单执行过得SQL、语句
                sql_list = order_obj.sql.strip("\n").strip('\r').split('\n')

                #生成查询过滤条件
                sql_where = " or ".join(map(lambda x: "sql_statement='%s'" % re.sub("\'","\\'",x.strip("\r").strip(';')),sql_list))
                #查询工单备份信息
                sql = "SELECT * from `$_$Inception_backup_information$_$` where " + sql_where
                #连接inception 备份数据库
                con = pymysql.connect(host=dbckdb_obj.back_db_ip, port=int(dbckdb_obj.back_db_port), user=dbckdb_obj.back_db_user, passwd=BACKDB_PASSWD,
                                      db=db_name, charset='utf8')
                cur = con.cursor()
                cur.execute(sql)
                data = cur.fetchall()
                rollbacl_sql_list = []
                for i in data:
                    opid_time = i[0]
                    start_binlog_file = i[1]
                    start_binlog_pos = i[2]
                    end_binlog_file = i[3]
                    end_binlog_pos = i[4]
                    dbname = i[7]
                    tablename = i[8]
                    if start_binlog_file:
                        """如果有二进制文件测通过二进制文件回滚"""
                        #通过binlog2sql生成回滚sql语句
                        args = command_line_args(['--flashback', '-h'+order_obj.db.db_host.host_ip, '-P'+str(order_obj.db.db_port), '-u'+order_obj.db.db_user,
                             '-p'+de_passwd, '-d'+dbname, '-t'+tablename,'--start-file='+start_binlog_file,'--start-file='+end_binlog_file,
                             '--start-position='+str(start_binlog_pos), '--stop-position='+str(end_binlog_pos)])
                        conn_setting = {'host': args.host, 'port': args.port, 'user': args.user,
                                        'passwd': args.password, 'charset': 'utf8'}
                        binlog2sql = Binlog2sql(connection_settings=conn_setting, start_file=args.start_file,
                                                start_pos=args.start_pos,
                                                end_file=args.end_file, end_pos=args.end_pos,
                                                start_time=args.start_time,
                                                stop_time=args.stop_time, only_schemas=args.databases,
                                                only_tables=args.tables,
                                                no_pk=args.no_pk, flashback=args.flashback, stop_never=args.stop_never,
                                                back_interval=args.back_interval, only_dml=args.only_dml,
                                                sql_type=args.sql_type)
                        rollbacl_sql = binlog2sql.process_binlog()

                    else:
                        """如果没有二进制文件测通过inception 生成的回滚语句执行回滚"""
                        cur.execute("select rollback_statement from %s where opid_time='%s'" % (tablename,opid_time))
                        rollbacl_sql =cur.fetchall()[0][0].strip(";")
                    rollbacl_sql_list.append(rollbacl_sql.split(";")[0])
                cur.close()
                con.close()
                #执行回滚sql语句

                sql = ";\n".join(rollbacl_sql_list)+";"

                incdb_obj = db.IncDB.objects.first()
                # inc执行参数，执行SQL语句并且备份
                operation = '--enable-execute;--enable-ignore-warnings;--enable-remote-backup'
                # 目标服务器
                connstr_target = {'host': order_obj.db.db_host.host_ip, 'port': int(order_obj.db.db_port), 'user': order_obj.db.db_user, 'password': de_passwd,
                                  'db': order_obj.db.db_name, 'charset': 'utf8'}
                # inception 服务器信息
                connstr_inception = {'host': incdb_obj.inc_ip, 'port': int(incdb_obj.inc_port), 'user': '',
                                     'password': '',
                                     'db': '', 'charset': 'utf8'}
                # inception 执行的语句
                use_sql = "use %s;\n" % order_obj.db.db_name
                exec_sql = use_sql + sql
                # 执行检查

                result = inception.inception(connstr_target, operation, connstr_inception, exec_sql)

                try:
                    rollback_status = json.dumps(result)
                    order_obj.status = "已回滚"
                    order_obj.rollback_status = rollback_status
                    order_obj.save()
                    data = "该工单已回滚，请检查！"
                except:
                    rollback_status = result
                    order_obj.status = "回滚失败"
                    order_obj.rollback_status = rollback_status
                    order_obj.save()
                    data = "该工单回滚失败，请检查！"
            else:
                data = '工单状态异常，无法执行！'
        return HttpResponse(data)


@login_check
@perms_check
def order_detail(request,id):
    """工单详细信息"""
    title = "工单处理"
    order_obj = db.WorkOrderLog.objects.get(id=id)
    try:
        inc_status = json.loads(order_obj.inc_status)[1:]
    except:
        inc_status =[order_obj.inc_status]
    if order_obj.status == "待执行":
        rollbacl_sql = "工单未执行，无法生成回滚语句！"
    else:
        dbckdb_obj = db.BackDb.objects.first()
        db_name = re.sub("\.", "_",order_obj.db.db_host.host_ip + "_" + str(order_obj.db.db_port) + "_" + order_obj.db.db_name)
        key = SECRET_KEY[2:18]
        pc = encryption.prpcrypt(key)
        passwd = order_obj.db.db_passwd.strip("b").strip("'").encode(encoding="utf-8")
        de_passwd = pc.decrypt(passwd).decode()

        # 获取工单执行过得SQL、语句
        sql_list = order_obj.sql.strip("\n").strip('\r').split('\n')

        # 生成查询过滤条件
        sql_where = " or ".join(
            map(lambda x: "sql_statement='%s'" % re.sub("\'", "\\'", x.strip("\r").strip(';')), sql_list))
        # 查询工单备份信息
        sql = "SELECT * from `$_$Inception_backup_information$_$` where " + sql_where
        # 连接inception 备份数据库
        con = pymysql.connect(host=dbckdb_obj.back_db_ip, port=int(dbckdb_obj.back_db_port),
                              user=dbckdb_obj.back_db_user, passwd=BACKDB_PASSWD,
                              db=db_name, charset='utf8')
        cur = con.cursor()
        cur.execute(sql)
        data = cur.fetchall()
        rollbacl_sql_list = []
        for i in data:
            opid_time = i[0]
            start_binlog_file = i[1]
            start_binlog_pos = i[2]
            end_binlog_file = i[3]
            end_binlog_pos = i[4]
            dbname = i[7]
            tablename = i[8]
            if start_binlog_file:
                """如果有二进制文件测通过二进制文件回滚"""
                # 通过binlog2sql生成回滚sql语句
                args = command_line_args(
                    ['--flashback', '-h' + order_obj.db.db_host.host_ip, '-P' + str(order_obj.db.db_port),
                     '-u' + order_obj.db.db_user,
                     '-p' + de_passwd, '-d' + dbname, '-t' + tablename, '--start-file=' + start_binlog_file,
                     '--start-file=' + end_binlog_file,
                     '--start-position=' + str(start_binlog_pos), '--stop-position=' + str(end_binlog_pos)])
                conn_setting = {'host': args.host, 'port': args.port, 'user': args.user,
                                'passwd': args.password, 'charset': 'utf8'}
                binlog2sql = Binlog2sql(connection_settings=conn_setting, start_file=args.start_file,
                                        start_pos=args.start_pos,
                                        end_file=args.end_file, end_pos=args.end_pos,
                                        start_time=args.start_time,
                                        stop_time=args.stop_time, only_schemas=args.databases,
                                        only_tables=args.tables,
                                        no_pk=args.no_pk, flashback=args.flashback, stop_never=args.stop_never,
                                        back_interval=args.back_interval, only_dml=args.only_dml,
                                        sql_type=args.sql_type)
                rollbacl_sql = binlog2sql.process_binlog()

            else:
                """如果没有二进制文件测通过inception 生成的回滚语句执行回滚"""
                cur.execute("select rollback_statement from %s where opid_time='%s'" % (tablename, opid_time))
                rollbacl_sql = cur.fetchall()[0][0].strip(";")
            rollbacl_sql_list.append(rollbacl_sql.split(";")[0])
        cur.close()
        con.close()
        # 执行回滚sql语句
        rollbacl_sql = ";\n".join(rollbacl_sql_list)+";"
    return render(request,"db_order_detail.html",locals())