////////////////////项目管理////////////////////////
//添加项目
$("#sub-project").click(function(){
    var project_name = $("#project-name").val();
    var project_msg = $("#project-msg").val();

    $.post('/code/project/',{'project_name':project_name,'project_msg':project_msg},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#projectModal").modal("hide");
            $("#alert").show();
        }
    })
});


//获取修改项目信息
$('td a[name="edit-project"]').click(function(){
    var project_id = $(this).attr("project_id");

    $.ajax({
        url: "/code/project/",
        type: "PUT",
        data: JSON.stringify({'project_id':project_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-project-name").val(info.project_name);
                $("#edit-project-msg").val(info.project_msg);
                $("#sub-edit-project").attr('project_id', info.project_id);
                $("#edit-projectModal").modal('show');
            }

         }
        });
});


//修改项目信息
$("#sub-edit-project").click(function(){
    var project_id = $(this).attr('project_id');
    var project_name = $("#edit-project-name").val();
    var project_msg = $("#edit-project-msg").val();
    $.ajax({
        url: "/code/project/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','project_name':project_name, 'project_msg':project_msg,'project_id':project_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-projectModal").modal("hide");
                $("#alert").show();
            }

         }
    });
});


//删除项目
$("td a[name='del-project']").click(function(){
   var project_id = $(this).attr('project_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
        $.ajax({
            url: "/code/project/",
            type: "DELETE",
            data: JSON.stringify({'project_id':project_id}),
            success: function(data) {
                if(data=="perms_false"){
                    $("#msg-alert").empty();
                    $("#msg-alert").append("权限不足，请联系管理员");
                    $("#alert").show();
                }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#edit-projectModal").modal("hide");
                    $("#alert").show();
                }

             }
        });
    }
});


////////////////////代码管理////////////////////////

//添加代码
$("#sub-git").click(function(){
    var git_name = $("#git-name").val();
    var git_msg = $("#git-msg").val();
    var git_project = $("#git-project").val();
    var git_url = $("#git-url").val();
    var git_user = $("#git-user").val();
    var git_passwd = $("#git-passwd").val();
    var git_sshkey = $("#git-sshkey").val();

    $.post('/code/gitcode/',{'git_name':git_name,'git_msg':git_msg,'git_project':git_project,'git_url':git_url,
                'git_user':git_user,'git_passwd':git_passwd,'git_sshkey':git_sshkey},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#gitModal").modal("hide");
            $("#alert").show();
        }
    })
});


//获取修改代码信息
$('td a[name="edit-git"]').click(function(){
    var git_id = $(this).attr("git_id");

    $.ajax({
        url: "/code/gitcode/",
        type: "PUT",
        data: JSON.stringify({'git_id':git_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {

                var info = eval('(' + data + ')');
                $("#edit-git-name").val(info.git_name);
                $("#edit-git-msg").val(info.git_msg);
                $("#edit-git-project").val(info.git_project);
                $("#edit-git-url").val(info.git_url);
                $("#edit-git-user").val(info.git_user);
                $("#edit-git-passwd").val(info.git_passwd);
                $("#edit-git-sshkey").val(info.git_sshkey);

                $("#sub-edit-git").attr('git_id', info.git_id);
                $("#div-git-name").css('display', 'block');
                $("#div-git-msg").css('display', 'block');
                $("#div-git-project").css('display', 'block');
                $("#div-git-url").css('display', 'block');

                $("#edit-gitModal").modal('show');
            }

         }
        });
});

//获取修改代码信息
$('td a[name="edit-git-user"]').click(function(){
    var git_id = $(this).attr("git_id");

    $.ajax({
        url: "/code/gitcode/",
        type: "PUT",
        data: JSON.stringify({'git_id':git_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {

                var info = eval('(' + data + ')');
                $("#edit-git-name").val(info.git_name);
                $("#edit-git-msg").val(info.git_msg);
                $("#edit-git-project").val(info.git_project);
                $("#edit-git-url").val(info.git_url);

                $("#edit-git-user").val(info.git_user);
                $("#edit-git-passwd").val(info.git_passwd);
                $("#edit-git-sshkey").val(info.git_sshkey);

                $("#sub-edit-git").attr('git_id', info.git_id);

                $("#div-git-name").css('display', 'none');
                $("#div-git-msg").css('display', 'none');
                $("#div-git-project").css('display', 'none');
                $("#div-git-url").css('display', 'none');

                $("#edit-gitModal").modal('show');
            }

         }
        });
});



//修改代码信息
$("#sub-edit-git").click(function(){
    var git_id = $(this).attr('git_id');
    var git_name = $("#edit-git-name").val();
    var git_msg = $("#edit-git-msg").val();
    var git_project = $("#edit-git-project").val();
    var git_url = $("#edit-git-url").val();
    var git_user = $("#edit-git-user").val();
    var git_passwd = $("#edit-git-passwd").val();
    var git_sshkey = $("#edit-git-sshkey").val();

    $.ajax({
        url: "/code/gitcode/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','git_name':git_name, 'git_msg':git_msg,'git_id':git_id,'git_project':git_project,'git_url':git_url,
                        'git_user':git_user,'git_passwd':git_passwd,'git_sshkey':git_sshkey}),
        success: function(data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-gitModal").modal("hide");
                $("#alert").show();
            }

         }
    });
});


//删除代码
$("td a[name='del-git']").click(function(){
   var git_id = $(this).attr('git_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
        $.ajax({
            url: "/code/gitcode/",
            type: "DELETE",
            data: JSON.stringify({'git_id':git_id}),
            success: function(data) {
                if(data=="perms_false"){
                    $("#msg-alert").empty();
                    $("#msg-alert").append("权限不足，请联系管理员");
                    $("#alert").show();
                }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#edit-gitModal").modal("hide");
                    $("#alert").show();
                }

             }
        });
    }
});

////////////////////发布管理////////////////////////

//新建发布
$("#sub-publist").click(function(){
    var gitcode_name = $("#gitcode-name").val();
    var publist_ip = $("#publist-ip").select2('val');
    var publist_dir = $("#publist-dir").val();
    var publist_msg = $("#publist-msg").val();
    console.log(typeof(publist_ip))
    $.post('/code/publist/',{'gitcode_name':gitcode_name,'publist_ip':JSON.stringify(publist_ip),'publist_dir':publist_dir,'publist_msg':publist_msg},function(data){

        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#publistModal").modal("hide");
            $("#alert").show();
        }
    })
});

