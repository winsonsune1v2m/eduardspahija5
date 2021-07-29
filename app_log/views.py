import json
from django.shortcuts import render,HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from app_auth.views import login_check,perms_check

# Create your views here.

class UserLog(View):
    """用户日志"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(UserLog,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "用户日志"
        return render(request,'log_userlog.html',locals())


class OpsLog(View):
    """操作日志"""
    @method_decorator(csrf_exempt)
    @method_decorator(login_check)
    @method_decorator(perms_check)
    def dispatch(self, request, *args, **kwargs):
        return super(OpsLog,self).dispatch(request,*args, **kwargs)

    def get(self,request):
        title = "操作日志"
        return render(request,'log_opslog.html',locals())
