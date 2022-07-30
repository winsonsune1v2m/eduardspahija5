import json
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_auth.views import login_check,perms_check
from app_log import models as log_db
from app_auth import  models as auth_db
from saltops_v2 import celery_app as app
from celery.result import AsyncResult
from django.core.paginator import Paginator,PageNotAnInteger,EmptyPage
from statics.scripts import page as pg

# Create your views here.

class OpsLog(View):
    """操作日志"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(OpsLog,self).dispatch(request,*args, **kwargs)

    def get(self,request,page=1):
        title = "操作日志"
        audit_obj = log_db.OpsLog.objects.all().order_by("-start_time")
        pagesize = 13
        paginator = Paginator(audit_obj, pagesize)
        # 从前端获取当前的页码数,默认为1
        # 把当前的页码数转换成整数类型
        currentPage = int(page)
        page_nums = paginator.num_pages
        page_list = pg.control(currentPage, page_nums)
        try:
            audit_list = paginator.page(page)  # 获取当前页码的记录
        except PageNotAnInteger:
            audit_list = paginator.page(1)  # 如果用户输入的页码不是整数时,显示第1页的内容
        except EmptyPage:
            audit_list = paginator.page(paginator.num_pages)

        return render(request, 'log/log_opslog.html', locals())
    def post(self,request):
        audit_id = request.POST.get('audit_id')
        audit_obj = log_db.OpsLog.objects.get(id=audit_id)
        audit_log = audit_obj.audit_log
        return HttpResponse(audit_log)



class UserLog(View):
    """用户日志"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(UserLog,self).dispatch(request,*args, **kwargs)

    def get(self,request,page=1):
        title = "用户日志"
        userlog_obj = log_db.UserLog.objects.all().order_by("-create_time")
        # 生成paginator对象,定义每页显示13条记录
        pagesize = 13
        paginator = Paginator(userlog_obj,pagesize)
        # 从前端获取当前的页码数,默认为1
        # 把当前的页码数转换成整数类型
        currentPage = int(page)
        page_nums = paginator.num_pages
        page_list = pg.control(currentPage, page_nums)
        try:
            userlog_list = paginator.page(page)  # 获取当前页码的记录
        except PageNotAnInteger:
            userlog_list = paginator.page(1)  # 如果用户输入的页码不是整数时,显示第1页的内容
        except EmptyPage:
            userlog_list = paginator.page(paginator.num_pages)

        return render(request, 'log/log_userlog.html', locals())



class TaskRecord(View):
    """任务日志"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(TaskRecord,self).dispatch(request,*args, **kwargs)

    def get(self,request,page=1):
        title = "任务中心"

        role_id = request.session["role_id"]
        role_type = auth_db.Role.objects.get(id=role_id).role_title

        if role_type == "administrator":
            task_obj = log_db.TaskRecord.objects.all().order_by("-create_time")
        else:
            user_obj = auth_db.User.objects.get(user_name=request.session['user_name'])
            task_obj = log_db.TaskRecord.objects.filter(task_user_id=user_obj.id).order_by("-create_time")

        pagesize = 13
        paginator = Paginator(task_obj, pagesize)
        # 从前端获取当前的页码数,默认为1
        # 把当前的页码数转换成整数类型
        currentPage = int(page)
        page_nums = paginator.num_pages
        page_list = pg.control(currentPage, page_nums)
        try:
            task_list = paginator.page(page)  # 获取当前页码的记录
        except PageNotAnInteger:
            task_list = paginator.page(1)  # 如果用户输入的页码不是整数时,显示第1页的内容
        except EmptyPage:
            task_list = paginator.page(paginator.num_pages)

        task_info_list = []
        for i in  task_list:
            if i.status == "SUCCESS" or i.status == 'FAILURE':
                status = i.status
                result = i.task_result
            else:
                async = AsyncResult(id=i.task_id, app=app)
                status = async.state
                if status == 'SUCCESS':
                    result = async.get()
                    i.task_result = result
                elif  status == 'FAILURE':
                    result = async.traceback
                    i.task_result = result
                else:
                    result = None

                i.status = status
                i.save()

            task_info_list.append({'id':i.id,'task_name':i.task_name,'task_id':i.task_id,'status':status,'create_time':i.create_time,'task_result':result,"task_user":i.task_user.user_name})

        return render(request, 'log/log_taskrecord.html', locals())


    def post(self,request):
        task_id = request.POST.get('task_id')
        task_obj = log_db.TaskRecord.objects.get(id=task_id)
        task_result = task_obj.task_result
        return HttpResponse(task_result)


