
$("#perms-type").change(function(){
    var menu_level = $(this).val();
    if (menu_level == '一级菜单'){
        $("#pmenu-div").css("display",'none')
    }else if(menu_level == '二级菜单' ){


        $("#pmenu-id option").each(function(){
            var pmenu_id = $(this).attr("pmenu_id")
            if (pmenu_id==0){

                $(this).css("display",'block')
            }else{

                $(this).css("display",'none')
            }
        })

        $("#pmenu-div").css("display",'block')
    }
    else{

        $("#pmenu-id option").each(function(){
            var pmenu_id = $(this).attr("pmenu_id")
            if (pmenu_id==0){

                $(this).css("display",'none')
            }else{

                $(this).css("display",'block')
            }
        })

        $("#pmenu-div").css("display",'block')
    }

});



$("#edit-perms-type").change(function(){
    var menu_level = $(this).val();
    if (menu_level == '一级菜单'){
        $("#edit-pmenu-div").css("display",'none')
    }else if(menu_level == '二级菜单' ){


        $("#edit-pmenu-id option").each(function(){
            var pmenu_id = $(this).attr("pmenu_id")
            if (pmenu_id==0){

                $(this).css("display",'block')
            }else{

                $(this).css("display",'none')
            }
        })

        $("#edit-pmenu-div").css("display",'block')
    }
    else{

        $("#edit-pmenu-id option").each(function(){
            var pmenu_id = $(this).attr("pmenu_id")
            if (pmenu_id==0){

                $(this).css("display",'none')
            }else{

                $(this).css("display",'block')
            }
        })

        $("#edit-pmenu-div").css("display",'block')
    }

});



$("#sub-perms").click(function(){
    var perms_title = $("#perms-title").val();
    var perms_type = $("#perms-type").val();
    var perms_url = $("#perms-url").val();
    var pmenu_id = $("#pmenu-id").val();
    var perms_icon = $("#menu-icon-input").val();
    $.post("/rbac/addperms/",{'perms_title':perms_title, 'perms_url':perms_url,'perms_type':perms_type,'pmenu_id':pmenu_id,'perms_icon':perms_icon},function(data){

        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

            alert(data);

            if (data == "权限已添加"){
                location.reload();
            }
        }
    })

});


//编辑权限填充内容
$('td a[name="edit-perms"]').click(function(){
    var perms_id = $(this).attr("perms_id");
    $.post("/rbac/editperms/",{'perms_id':perms_id},function(data){

        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');

        $("#edit-perms-title").val(info.perms_title);
        $("#edit-perms-type").val(info.perms_type);
        $("#edit-perms-url").val(info.perms_url);
        $("#edit-pmenu-id").val(info.pmenu_id);

        $("#edit-menu-icon-input").val(info.perms_icon);

        $("#sub-edit-perms").attr('perms_id',info.perms_id);

        if (info.perms_type == '一级菜单'){

            $("#edit-pmenu-div").css("display",'none')
            $("#edit-icon-div").css("display",'block')

        }

        else if(info.perms_type == '二级菜单' ){

            $("#edit-pmenu-id option").each(function(){
                var pmenu_id = $(this).attr("pmenu_id")

                if (pmenu_id==0){

                    $(this).css("display",'block')
                }else{

                    $(this).css("display",'none')
                }
            })
            $("#edit-icon-div").css("display",'none')
            $("#edit-pmenu-div").css("display",'block')
            }
        else{

            $("#edit-pmenu-id option").each(function(){
                var pmenu_id = $(this).attr("pmenu_id")

                if (pmenu_id==0){

                        $(this).css("display",'none')
                    }else{

                        $(this).css("display",'block')
                    }
                })
                $("#edit-icon-div").css("display",'none')
                $("#edit-pmenu-div").css("display",'block')
            }

        $("#edit-permsModal").modal('show');

        }
    })

});



//修改角色信息
$("#sub-edit-perms").click(function(){
    var perms_id = $(this).attr('perms_id');
    var perms_title = $("#edit-perms-title").val();
    var perms_type = $("#edit-perms-type").val();
    var perms_url = $("#edit-perms-url").val();
    var pmenu_id = $("#edit-pmenu-id").val();
    var perms_icon = $("#edit-menu-icon-input").val();

    $.post('/rbac/editperms/',{'action':'edit','perms_title':perms_title, 'perms_url':perms_url,'perms_type':perms_type,'pmenu_id':pmenu_id,'perms_icon':perms_icon,'perms_id':perms_id},function(data){
        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "修改成功"){
            location.reload();
        }
       }
    });
});




//删除角色
$("td a[name='del-perms']").click(function(){
   var perms_id = $(this).attr('perms_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/rbac/delperms/",{'perms_id':perms_id},function(data){

        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        if (data == "已删除"){
            location.reload();
        }
        }
    })

    }
});



////////////////////////角色管理////////////////////////////
///添加角色
$("#sub-role").click(function(){
    var role_title = $("#role-title").val();
    var role_msg = $("#role-msg").val();
    $.post("/auth/role/",{'role_title':role_title, 'role_msg':role_msg},function(data){
        $("#msg-alert").empty();
        $("#msg-alert").append(data);
        $("#msg-alert").show();


    });
});



//编辑角色填充内容
$('td a[name="edit-role"]').click(function(){
    var role_id = $(this).attr("role_id");
    $.post("/rbac/editrole/",{'role_id':role_id},function(data){
        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');
        $("#edit-role-title").val(info.role_title);
        $("#edit-role-msg").val(info.role_msg);
        $("#sub-edit-role").attr('role_id',info.role_id);
        $("#edit-roleModal").modal('show');
    }
    })
});



//修改角色信息
$("#sub-edit-role").click(function(){
    var role_id = $(this).attr('role_id');
    var role_title = $("#edit-role-title").val();
    var role_msg = $("#edit-role-msg").val();

    $.post('/rbac/editrole/',{'action':'edit','role_title':role_title, 'role_msg':role_msg,'role_id':role_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "修改成功"){
            location.reload();
        }
        }
    });
});




//删除角色
$("td a[name='del-role']").click(function(){
   var role_id = $(this).attr('role_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/rbac/delrole/",{'role_id':role_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        if (data == "已删除"){
            location.reload();
        }
    }
    })

    }
});



///////////////////////用户管理///////////////////////////////

//添加用户
$("#sub-user").click(function(){
    var name = $("#name").val();
    var username = $("#username").val();
    var passwd = $("#passwd").val();
    var repasswd = $("#repasswd").val();
    var role = $("#role").val();
    var phone = $("#phone").val();
    var email = $("#email").val();
    $.post("/rbac/adduser/",{'name':name, 'username':username,'passwd':passwd,'role':role,'phone':phone,'email':email},function(data){

    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "用户添加成功"){
            location.reload();
        }
    }
    })
});





//编辑用户填充内容
$('td a[name="edit-user"]').click(function(){
    var user_id = $(this).attr("user_id");

    $.post("/rbac/edituser/",{'user_id':user_id},function(data){

        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{
            var info = eval('(' + data + ')');
            $("#edit-name").val(info.name);
            $("#edit-username").val(info.username);
            $("#edit-repasswd").val(info.passwd);
            $("#edit-role").val(info.role);
            $("#edit-phone").val(info.phone);
            $("#edit-email").val(info.email);
            $("#sub-edit-user").attr('user_id',info.user_id);
            $("#edit-userModal").modal('show');
        }
    })
});






//修改用户信息
$("#sub-edit-user").click(function(){
    var user_id = $(this).attr('user_id');
    var name = $("#edit-name").val();
    var username = $("#edit-username").val();
    var role = $("#edit-role").val();
    var phone = $("#edit-phone").val();
    var email = $("#edit-email").val();
    $.post('/rbac/edituser/',{'action':'edit','name':name, 'username':username,'role':role,'phone':phone,'email':email,'user_id':user_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "修改成功"){
            location.reload();
        }
        }
    });
});




//删除用户
$("td a[name='del-user']").click(function(){
   var user_id = $(this).attr('user_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/rbac/deluser/",{'user_id':user_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        if (data == "已删除"){
            location.reload();
        }
    }
    })

    }
});






