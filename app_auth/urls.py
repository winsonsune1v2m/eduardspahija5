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

from app_auth import views
from django.urls import path,include

urlpatterns = [
    path("role/",views.RoleMG.as_view()),
    path("user/",views.UserMG.as_view()),
    path("menu/",views.MenuMG.as_view()),
    path("perms/",views.PermsMG.as_view()),
    path("login/",views.Login.as_view()),
    path("logout/",views.Logout),
    path("rolemenu/",views.get_role_menu),
    path("addrolemenu/",views.add_role_menu),
    path("roleperms/",views.get_role_perms),
    path("addroleperms/",views.add_role_perms),
    path("roleasset/",views.get_role_asset),
    path("addroleasset/",views.add_role_asset),
    path("roleproject/", views.get_role_project),
    path("addroleproject/", views.add_role_project),
]
