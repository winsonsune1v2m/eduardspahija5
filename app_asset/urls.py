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

from app_asset import views
from django.urls import path,include


urlpatterns = [
    path("idc/",views.IDC.as_view()),
    path("hostgroup/",views.HostGroup.as_view()),
    path("host/", views.Host.as_view()),
    path("netwk/", views.Netwk.as_view()),
    path("supplier/", views.Supplier.as_view()),
    path("hostdetail/", views.host_detail),
    path("synchost/", views.sync_host_info),
    path("searchhost/", views.search_host),
    path("delhost/",views.del_host),
    path("importhost/",views.import_host),
    path("exporthost/",views.export_host),
]
