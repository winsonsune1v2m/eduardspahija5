import json
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_auth.views import login_check,perms_check
from app_log import models as log_db
from mtrops_v2 import celery_app as app
from celery.result import AsyncResult



# Create your views here.

class OpsLog(View):
    """操作日志"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(OpsLog,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "操作日志"
        audit_list = log_db.OpsLog.objects.all().order_by("-start_time")
        return render(request,'log_opslog.html',locals())
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

    def get(self,request):
        title = "用户日志"
        userlog_list = log_db.UserLog.objects.all().order_by("-create_time")

        return render(request,'log_userlog.html',locals())



class TaskRecord(View):
    """操作日志"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(TaskRecord,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "任务中心"
        task_obj = log_db.TaskRecord.objects.all().order_by("-create_time")
        task_list = []
        for i in  task_obj:
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

            task_list.append({'id':i.id,'task_name':i.task_name,'task_id':i.task_id,'status':status,'create_time':i.create_time,'task_result':result})
        return render(request,'log_taskrecord.html',locals())


    def post(self,request):
        task_id = request.POST.get('task_id')
        task_obj = log_db.TaskRecord.objects.get(id=task_id)
        task_result = task_obj.task_result
        return HttpResponse(task_result)


