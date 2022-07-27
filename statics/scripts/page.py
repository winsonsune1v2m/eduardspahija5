# -*- coding: utf-8 -*-

# @Time    : 2019-01-22 10:41
# @Author  : 小贰
# @FileName: page.py
# @function: 作者比较懒什么都没写

def control(current_page,page_nums):

    list_size = 5
    if page_nums<=list_size:
        page_list= list(range(1,page_nums+1))
    else:
        if (page_nums-list_size)<=list_size:
            page_list = list(range(1,page_nums+1))
        else:
            if (page_nums-current_page)<list_size:
                page_list = [1,2,"..."]+list(range(page_nums - 4, page_nums + 1))
            else:
                if current_page>list_size:
                    page_list = list(range(current_page-4, current_page + 1)) + ["...", page_nums - 1, page_nums]
                else:
                    page_list = list(range(1, list_size + 1)) + ["...", page_nums - 1, page_nums]

    return page_list

if __name__ == "__main__":
    current_page=120
    page_nums=200
    print(control(current_page,page_nums))