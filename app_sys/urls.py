"""mtrops_v2 URL Configuration

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

from app_sys import views
from django.urls import path,include


urlpatterns = [
    path("sofeware/",views.EnvSofeware.as_view()),
    path("install/", views.sofeware_install),
    path("batch/",views.Batch.as_view()),
    path("runcmd/",views.batch_run_cmd),
    path('upfile/',views.batch_upload_file),
    path('script/',views.batch_script),
    path('cron/',views.CronView.as_view()),
    path("filemg/", views.FileMG.as_view()),
    path("chdir/<str:ip>/<str:ch_dir>/", views.ch_dir),
    path("cddir/", views.cd_dir),

    path('pushfile/', views.Upfile),
    path('downfile/', views.Downfile),
    path('removefile/',views.Removefile),

]
