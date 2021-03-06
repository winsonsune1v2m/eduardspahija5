"""saltops_v2 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from app_log import views
from django.urls import path,include,re_path



urlpatterns = [
    path("opslog/",views.OpsLog.as_view()),
    path("opslog/<int:page>/",views.OpsLog.as_view()),
    path("userlog/",views.UserLog.as_view()),
    path("userlog/<int:page>/",views.UserLog.as_view()),
    path("tasklog/",views.TaskRecord.as_view()),
    path("tasklog/<int:page>/",views.TaskRecord.as_view()),
]
