from django.db.models import Q
from app_auth import models as auth_db
from app_asset import models as asset_db
from app_code import models as code_db

def menus_list(username):
    '''获取菜单列表'''

    user_obj = auth_db.User.objects.get(Q(user_name=username) | Q(email=username)| Q(phone=username))

    role_id=user_obj.role.all()[0].id

    menu_one = []
    menu_two = []

    role_obj = auth_db.Role.objects.get(id=role_id)

    menu_obj = role_obj.menu.all()

    for menu in menu_obj:
        menu_title = menu.menu_title
        menu_type = menu.menu_type
        menu_url = menu.menu_url
        menu_num = menu.menu_num
        pmenu_id = menu.pmenu_id
        menu_icon = menu.menu_icon

        if menu_type == u'一级菜单':
            menu_one.append(
                {'menu_title': menu_title, 'menu_url': menu_url, 'menu_num': menu_num, 'menu_icon': menu_icon})
        else:
            menu_two.append({'menu_title': menu_title, 'menu_url': menu_url, 'menu_num': menu_num, 'menu_icon': menu_icon,'pmenu_id':pmenu_id})


    # 组成菜单关系列表
    menu_all_list = []
    for i in menu_one:
        menu_num = i['menu_num']
        menu_list = []
        for j in menu_two:
            pmenu_id = j['pmenu_id']
            if pmenu_id == menu_num:
                menu_list.append(j)

        i['menu_two'] = menu_list

        menu_all_list.append(i)

    return menu_all_list


def perms_list(role_id):
    role_obj = auth_db.Role.objects.get(id=role_id)
    perms_obj = role_obj.perms.all()
    menu_urls = []
    perms_urls = {}

    for i in perms_obj:
        if i.perms_req == "other":
            perms_url = i.perms_url
            perms_urls[perms_url] = ['POST', 'DELETE', 'PUT', 'GET']
        else:
            menu_url = i.menus.menu_url
            if menu_url not in menu_urls:
                menu_urls.append(menu_url)

    perms_list = {}
    for i in menu_urls:
        req_method = []
        for j in perms_obj:
            if j.perms_req != "other":
                if i == j.menus.menu_url:
                    req_method.append(j.perms_req.upper())
        perms_list[i] = req_method

    perms_all_list = perms_list.copy()
    perms_all_list.update(perms_urls)

    return perms_all_list