////////////////////////角色管理////////////////////////////

///添加角色
$("#sub-role").click(function(){
    var role_title = $("#role-title").val();
    var role_msg = $("#role-msg").val();
    $.post("/auth/role/",{'role_title':role_title, 'role_msg':role_msg},function(data) {
        if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#roleModal").modal("hide");
            $("#alert").show();
        }
    })
});


//获取修改角色信息
$('td a[name="edit-role"]').click(function(){
    var role_id = $(this).attr("role_id");

    $.ajax({
        url: "/auth/role/",
        type: "PUT",
        data: JSON.stringify({'role_id':role_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-role-title").val(info.role_title);
                $("#edit-role-msg").val(info.role_msg);
                $("#sub-edit-role").attr('role_id', info.role_id);
                $("#edit-roleModal").modal('show');
            }

         }
    });
});



//修改角色信息
$("#sub-edit-role").click(function(){
    var role_id = $(this).attr('role_id');
    var role_title = $("#edit-role-title").val();
    var role_msg = $("#edit-role-msg").val();
    $.ajax({
        url: "/auth/role/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','role_title':role_title, 'role_msg':role_msg,'role_id':role_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-roleModal").modal("hide");
                $("#alert").show();
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
        $.ajax({
            url: "/auth/role/",
            type: "DELETE",
            data: JSON.stringify({'role_id':role_id}),
            success: function(data) {
                if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#alert").show();
                }

             }
        });
    }
});

////////////////////////用户管理////////////////////////////

//添加用户
$("#add-user").click(function(){
    var user_name = $("#user-name").val();
    var ready_name = $("#ready-name").val();
    var passwd = $("#passwd").val();
    var repasswd = $("#repasswd").val();
    var role = $("#role").val();
    var phone = $("#phone").val();
    var email = $("#email").val();

    if(passwd==repasswd){
        $.post("/auth/user/",{'user_name':user_name, 'ready_name':ready_name,'passwd':passwd,'role':role,'phone':phone,'email':email},function(data){
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#userModal").modal("hide");
                $("#alert").show();
            }

        })

    }else{
        alert("两次输入密码不一致");
    }

});

//获取用户修改信息
$('td a[name="edit-user"]').click(function(){
    var user_id = $(this).attr("user_id");
        $.ajax({
            url: "/auth/user/",
            type: "PUT",
            data: JSON.stringify({'user_id':user_id}),
            success: function(data) {
                if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {

                    var info = eval('(' + data + ')');
                    $("#edit-ready-name").val(info.ready_name);
                    $("#edit-user-name").val(info.user_name);
                    $("#edit-repasswd").val(info.passwd);

                    var role_info = eval('(' + info.role_info + ')');
                    for (i = 0; i < role_info.length; i++) {

                        $("#edit-role").val(role_info[0].role_id);
                    }

                    $("#edit-phone").val(info.phone);
                    $("#edit-email").val(info.email);
                    $("#sub-edit-user").attr('user_id', info.user_id);
                    $("#edit-userModal").modal('show');
                }

             }
    });
});



//修改用户信息
$("#sub-edit-user").click(function(){
    var user_id = $(this).attr('user_id');
    var ready_name = $("#edit-ready-name").val();
    var user_name = $("#edit-user-name").val();
    var role_id = $("#edit-role").val();
    var phone = $("#edit-phone").val();
    var email = $("#edit-email").val();
     $.ajax({
            url: "/auth/user/",
            type: "PUT",
            data: JSON.stringify({'action':'edit','ready_name':ready_name, 'user_name':user_name,'role_id':role_id,'phone':phone,'email':email,'user_id':user_id}),
            success: function(data) {
                if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#edit-userModal").modal("hide");
                    $("#alert").show();
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
        $.ajax({
            url: "/auth/user/",
            type: "DELETE",
            data: JSON.stringify({'user_id':user_id}),
            success: function(data) {
                if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#alert").show();
                }
             }
        });
    }
});





//修改用户密码
$("td a[name='ch-passwd']").click(function(){
    var user_id = $(this).attr('user_id');
    $("#rbac-new-passwd").val("");
    $("#rbac-rnew-passwd").val("");
    $("#rbac-passwdModal").modal('show');

    //修改密码
    $("#rbac-sub-passwd").click(function(){

       var new_passwd = $("#rbac-new-passwd").val();
       var rnew_passwd = $("#rbac-rnew-passwd").val();

        if(new_passwd==rnew_passwd){

            $.post("/auth/chpasswd/",{"new_passwd":new_passwd,"user_id":user_id},function(data){
                if(data=="perms_false"){
                    $("#msg-alert").empty();
                    $("#msg-alert").append("权限不足，请联系管理员");
                    $("#alert").show();
                }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#rbac-passwdModal").modal("hide");
                    $("#alert").show();
                }
            });

        }else{
            alert("两次输入的密码不一致");
        }
    });
});



//设置远程管理用户
$("td a[name='add-remoteuser']").click(function(){
    var user_id = $(this).attr('user_id');
    $.post("/auth/addremote/",{"user_id":user_id,'action':'get'},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            var info = eval('(' + data + ')');
            console.log(info.lg_user);
            $("#lg-user").val(info.lg_user);
            $("#lg-passwd").val(info.lg_passwd);
            $("#lg-key").val(info.lg_key);
            $("#lg-key-pass").val(info.lg_key_pass);

            $("#sub-remote").attr('lg_id', info.lg_id);
            $("#sub-remote").attr('user_id', user_id);
            $("#rbac-remoteModal").modal('show');

        }
    });
});


//设置远程用户
$("#sub-remote").click(function(){
   var user_id = $(this).attr('user_id');
   var lg_id = $(this).attr('lg_id');
   var lg_user = $("#lg-user").val();
   var lg_passwd = $("#lg-passwd").val();
   var lg_key = $("#lg-key").val();
   var lg_key_pass = $("#lg-key-pass").val();
    $.post("/auth/addremote/",{"lg_id":lg_id,'user_id':user_id,"lg_user":lg_user,"lg_passwd":lg_passwd,"lg_key":lg_key,"lg_key_pass":lg_key_pass},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#rbac-remoteModal").modal("hide");
            $("#alert").show();
        }
    });

});



////////////////////////菜单管理////////////////////////////

//改变菜单类型显示不同的内容
$("#menu-type").change(function(){
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


$("#sub-menu").click(function(){
    var menu_title = $("#menu-title").val();
    var menu_type = $("#menu-type").val();
    var menu_url = $("#menu-url").val();
    var pmenu_id = $("#pmenu-id").val();
    var menu_icon = $("#menu-icon-input").val();
    $.post("/auth/menu/",{'menu_title':menu_title, 'menu_url':menu_url,'menu_type':menu_type,'pmenu_id':pmenu_id,'menu_icon':menu_icon},function(data){
        if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#menuModal").modal("hide");
            $("#alert").show();
        }
    })
});

//获取编辑菜单信息
$('td a[name="edit-menu"]').click(function(){
    var menu_id = $(this).attr("menu_id");

    $.ajax({
        url: "/auth/menu/",
        type: "PUT",
        data: JSON.stringify({'menu_id':menu_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-menu-title").val(info.menu_title);
                $("#edit-menu-type").val(info.menu_type);
                $("#edit-menu-url").val(info.menu_url);
                $("#edit-pmenu-id").val(info.pmenu_id);

                $("#edit-menu-icon-input").val(info.menu_icon);

                $("#sub-edit-menu").attr('menu_id', info.menu_id);

                if (info.menu_type == '一级菜单') {

                    $("#edit-pmenu-div").css("display", 'none')
                    $("#edit-icon-div").css("display", 'block')

                }

                else if (info.menu_type == '二级菜单') {

                    $("#edit-pmenu-id option").each(function () {
                        var pmenu_id = $(this).attr("pmenu_id")

                        if (pmenu_id == 0) {

                            $(this).css("display", 'block')
                        } else {

                            $(this).css("display", 'none')
                        }
                    })
                    $("#edit-icon-div").css("display", 'none')
                    $("#edit-pmenu-div").css("display", 'block')
                }
                else {

                    $("#edit-pmenu-id option").each(function () {
                        var pmenu_id = $(this).attr("pmenu_id")

                        if (pmenu_id == 0) {

                            $(this).css("display", 'none')
                        } else {

                            $(this).css("display", 'block')
                        }
                    })
                    $("#edit-icon-div").css("display", 'none')
                    $("#edit-pmenu-div").css("display", 'block')
                }
                $("#edit-menuModal").modal('show');
            }

        }
    })

});

//改变菜单类型显示不同的内容
$("#edit-menu-type").change(function(){
    var menu_level = $(this).val();
    if (menu_level == '一级菜单'){
        $("#edit-pmenu-div").css("display",'none');
        $("#edit-icon-div").css("display",'block');
    }else if(menu_level == '二级菜单' ){


        $("#edit-pmenu-id option").each(function(){
            var pmenu_id = $(this).attr("pmenu_id");

            if (pmenu_id==0){
                $(this).css("display",'block');
                $("#edit-icon-div").css("display",'none');
            }else{

                $(this).css("display",'none')
            }
        })

        $("#edit-pmenu-div").css("display",'block')
    }
    else{

        $("#edit-pmenu-id option").each(function(){
            var pmenu_id = $(this).attr("pmenu_id");
            if (pmenu_id==0){

                $(this).css("display",'block');
                $("#edit-icon-div").css("display",'none');
            }else{

                $(this).css("display",'block')
            }
        })

        $("#edit-pmenu-div").css("display",'block')
    }
});

//修改菜单信息
$("#sub-edit-menu").click(function(){
    var menu_id = $(this).attr('menu_id');
    var menu_title = $("#edit-menu-title").val();
    var menu_type = $("#edit-menu-type").val();
    var menu_url = $("#edit-menu-url").val();
    var pmenu_id = $("#edit-pmenu-id").val();
    var menu_icon = $("#edit-menu-icon-input").val();
    if(pmenu_id==null){
        pmenu_id = 0
    }
    $.ajax({
        url: "/auth/menu/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','menu_title':menu_title, 'menu_url':menu_url,'menu_type':menu_type,'pmenu_id':pmenu_id,'menu_icon':menu_icon,'menu_id':menu_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-menuModal").modal("hide");
                $("#alert").show();
            }
       }
    });
});

//删除菜单
$("td a[name='del-menu']").click(function(){
    var menu_id = $(this).attr('menu_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
        $.ajax({
            url: "/auth/menu/",
            type: "DELETE",
            data: JSON.stringify({'menu_id':menu_id}),
            success: function(data) {
                if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#alert").show();
                }
             }
        });
    }
});

////////////////////////权限管理////////////////////////////

//添加权限
$("#sub-perms").click(function(){
    var perms_title = $("#perms-title").val();
    var perms_req = $("#perms-req").val();
    var menus_id = $("#menus-id").val();
    var perms_url = $("#perms-url").val();
    $.post("/auth/perms/",{"perms_req":perms_req, "perms_title":perms_title, "menus_id":menus_id,'perms_url':perms_url},function(data){
        if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#permsModal").modal("hide");
            $("#alert").show();
        }

    })
});


//获取编辑权限信息
$('td a[name="edit-perms"]').click(function() {
    var perms_id = $(this).attr("perms_id");
    $.ajax({
        url: "/auth/perms/",
        type: "PUT",
        data: JSON.stringify({'perms_id': perms_id}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-perms-title").val(info.perms_title);
                $("#edit-perms-req").val(info.perms_req);
                $("#edit-perms-url").val(info.perms_url);
                $("#edit-menus-id").val(info.menus_id);
                $("#sub-edit-perms").attr('perms_id', info.perms_id);
                $("#edit-permsModal").modal('show');

                if (info.perms_req == 'other') {
                    $("#edit-div-perms").css("display", 'block')
                }
                else {
                    $("#edit-div-perms").css("display", 'none')
                }
            }

        }
    });
});

//修改权限信息
$("#sub-edit-perms").click(function() {
    var perms_id = $(this).attr("perms_id");
    var perms_title = $("#edit-perms-title").val();
    var perms_req = $("#edit-perms-req").val();
    var perms_url = $("#edit-perms-url").val();
    var menus_id = $("#edit-menus-id").val();
    $.ajax({
        url: "/auth/perms/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','perms_id':perms_id,'perms_title':perms_title,'perms_req':perms_req,'menus_id':menus_id,'perms_url':perms_url}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-permsModal").modal("hide");
                $("#alert").show();
            }
        }
    });
});


//删除权限
$("td a[name='del-perms']").click(function(){
    var perms_id = $(this).attr('perms_id');
    var statu = confirm("是否确认删除！");
    if (statu==true)
    {
        $.ajax({
            url: "/auth/perms/",
            type: "DELETE",
            data: JSON.stringify({'perms_id':perms_id}),
            success: function(data) {
                if(data=="perms_false"){
                    $("#msg-alert").empty();
                    $("#msg-alert").append("权限不足，请联系管理员");
                    $("#alert").show();
                }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#alert").show();
                }
             }
        });
    }
});