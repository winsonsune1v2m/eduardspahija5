import json
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_auth.views import login_check,perms_check
from app_log import models as log_db

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



