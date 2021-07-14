////////////////////////角色管理////////////////////////////

///添加角色
$("#sub-role").click(function(){
    var role_title = $("#role-title").val();
    var role_msg = $("#role-msg").val();
    $.post("/auth/role/",{'role_title':role_title, 'role_msg':role_msg},function(data) {
        $("#msg-alert").empty();
        $("#msg-alert").append(data);
        $("#roleModal").modal("hide");
        $("#alert").show();
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

            var info = eval('(' + data + ')');
            $("#edit-role-title").val(info.role_title);
            $("#edit-role-msg").val(info.role_msg);
            $("#sub-edit-role").attr('role_id',info.role_id);
            $("#edit-roleModal").modal('show');

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

            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#edit-roleModal").modal("hide");
            $("#alert").show();

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

                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-roleModal").modal("hide");
                $("#alert").show();

             }
        });

    }
});



