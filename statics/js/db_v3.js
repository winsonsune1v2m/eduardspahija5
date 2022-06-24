$("#db-name").blur(function () {
    var db_name = $(this).val();
    if(db_name==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});

$("#db-port").blur(function () {
    var db_port = $(this).val();
    if(db_port==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});


$("#db-user").blur(function () {
    var db_user = $(this).val();
    if(db_user==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});


$("#db-passwd").blur(function () {
    var db_passwd = $(this).val();
    if(db_passwd==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});



$("#test-con").click(function () {
    var db_host = $("#db-host").select2('val')[0];
    var db_name = $("#db-name").val();
    var db_port = $("#db-port").val();
    var db_user = $("#db-user").val();
    var db_passwd = $("#db-passwd").val();

    if(db_name==''){
        $("#db-name").css("border","1px solid orangered");
    }else{
        $("#db-name").css("border","1px solid green");
    }

    if(db_port==''){
        $("#db-port").css("border","1px solid orangered");
    }else{
        $("#db-port").css("border","1px solid green");
    }


    if(db_user==''){
        $("#db-user").css("border","1px solid orangered");
    }else{
        $("#db-user").css("border","1px solid green");
    }

    if(db_passwd==''){
        $("#db-passwd").css("border","1px solid orangered");
    }else{
        $("#db-passwd").css("border","1px solid green");
    }

    if(db_host&&db_name&&db_port&&db_user&&db_passwd){
        $.post('/db/list/',{"action":"test_con",'db_host':db_host,"db_name":db_name,"db_port":db_port,"db_user":db_user,"db_passwd":db_passwd},function (data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else{

                $("#test-con-msg").empty();
                $("#test-con-msg").append('<span style="color: orangered">'+data+"</span>");

            }
        });
    }else{
        $("#test-con-msg").empty();
        $("#test-con-msg").append('<span style="color: orangered">'+"带 * 的信息不能为空"+"</span>");
    }

});


//添加数据库
$("#sub-dblist").click(function () {
    var db_host = $("#db-host").select2('val')[0];
    var db_name = $("#db-name").val();
    var db_port = $("#db-port").val();
    var db_user = $("#db-user").val();
    var db_passwd = $("#db-passwd").val();
    var db_env = $("#db-env").val();
    var db_msg = $("#db-msg").val();
    var user_id = $("#user").val();

    if(db_name==''){
        $("#db-name").css("border","1px solid orangered");
    }else{
        $("#db-name").css("border","1px solid green");
    }

    if(db_port==''){
        $("#db-port").css("border","1px solid orangered");
    }else{
        $("#db-port").css("border","1px solid green");
    }

    if(db_user==''){
        $("#db-user").css("border","1px solid orangered");
    }else{
        $("#db-user").css("border","1px solid green");
    }

    if(db_passwd==''){
        $("#db-passwd").css("border","1px solid orangered");
    }else{
        $("#db-passwd").css("border","1px solid green");
    }

    if(db_host&&db_name&&db_port&&db_user&&db_passwd){
        $.post('/db/list/',{"action":"add",'db_host':db_host,"db_name":db_name,"db_port":db_port,
            "db_user":db_user,"db_passwd":db_passwd,"db_env":db_env,"user_id":user_id,'db_msg':db_msg},function (data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else{
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#dblistModal").modal("hide");
                $("#alert").show();
            }
        });
    }else{
        $("#test-con-msg").empty();
        $("#test-con-msg").append('<span style="color: orangered">'+"带 * 的信息不能为空"+"</span>");
    }

});

//测试数据库状态
$('td a[name="con-check"]').click(function () {
    var db_id = $(this).attr("db_id");
    $.ajax({
        url: "/db/list/",
        type: "PUT",
        data: JSON.stringify({'db_id': db_id,"action":"con_check"}),
        success: function (data) {
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
});


//获取数据库修改信息
$('td a[name="edit-db"]').click(function () {
    var db_id = $(this).attr("db_id");
    $.ajax({
        url: "/db/list/",
        type: "PUT",
        data: JSON.stringify({'db_id': db_id,"action":"get"}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-db-host").val(info.db_host).trigger("change"); //select2 默认选中
                $("#edit-db-name").val(info.db_name);
                $("#edit-db-port").val(info.db_port);
                $("#edit-db-user").val(info.db_user);
                $("#edit-db-passwd").val(info.db_passwd);
                $("#edit-db-env").val(info.db_env);
                $("#edit-db-msg").val(info.db_msg);
                $("#edit-user").val(info.user);
                $("#sub-edit-dblist").attr('db_id',info.db_id);
                $("#edit-dblistModal").modal('show');
            }
        }
    });
});


$("#edit-db-name").blur(function () {
    var db_name = $(this).val();
    if(db_name==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});

$("#edit-db-port").blur(function () {
    var db_port = $(this).val();
    if(db_port==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});


$("#edit-db-user").blur(function () {
    var db_user = $(this).val();
    if(db_user==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});


$("#edit-db-passwd").blur(function () {
    var db_passwd = $(this).val();
    if(db_passwd==''){
        $(this).css("border","1px solid orangered");
    }else{
        $(this).css("border","1px solid green");
    }
});



$("#edit-test-con").click(function () {
    var db_host = $("#edit-db-host").select2('val')[0];
    var db_name = $("#edit-db-name").val();
    var db_port = $("#edit-db-port").val();
    var db_user = $("#edit-db-user").val();
    var db_passwd = $("#edit-db-passwd").val();

    if(db_name==''){
        $("#edit-db-name").css("border","1px solid orangered");
    }else{
        $("#edit-db-name").css("border","1px solid green");
    }

    if(db_port==''){
        $("#edit-db-port").css("border","1px solid orangered");
    }else{
        $("#edit-db-port").css("border","1px solid green");
    }


    if(db_user==''){
        $("#edit-db-user").css("border","1px solid orangered");
    }else{
        $("#edit-db-user").css("border","1px solid green");
    }

    if(db_passwd==''){
        $("#edit-db-passwd").css("border","1px solid orangered");
    }else{
        $("#edit-db-passwd").css("border","1px solid green");
    }

    if(db_host&&db_name&&db_port&&db_user&&db_passwd){
        $.ajax({
            url:'/db/list/',
            type:"PUT",
            data: JSON.stringify({"action":"edit_test_con",'db_host':db_host,"db_name":db_name,"db_port":db_port,"db_user":db_user,"db_passwd":db_passwd}),
            success: function (data) {

                if(data=="perms_false"){
                    $("#msg-alert").empty();
                    $("#msg-alert").append("权限不足，请联系管理员");
                    $("#alert").show();
                }else{

                    $("#edit-test-con-msg").empty();
                    $("#edit-test-con-msg").append('<span style="color: orangered">'+data+"</span>");

                }
            }
        });
    }else{
        $("#edit-test-con-msg").empty();
        $("#edit-test-con-msg").append('<span style="color: orangered">'+"带 * 的信息不能为空"+"</span>");
    }
});


//修改数据库
$("#sub-edit-dblist").click(function () {
    var db_host = $("#edit-db-host").select2('val')[0];
    var db_name = $("#edit-db-name").val();
    var db_port = $("#edit-db-port").val();
    var db_user = $("#edit-db-user").val();
    var db_passwd = $("#edit-db-passwd").val();
    var db_env = $("#edit-db-env").val();
    var db_msg = $("#edit-db-msg").val();
    var user_id = $("#edit-user").val();

    var db_id = $(this).attr('db_id');
    if(db_name==''){
        $("#edit-db-name").css("border","1px solid orangered");
    }else{
        $("#edit-db-name").css("border","1px solid green");
    }

    if(db_port==''){
        $("#edit-db-port").css("border","1px solid orangered");
    }else{
        $("#edit-db-port").css("border","1px solid green");
    }

    if(db_user==''){
        $("#edit-db-user").css("border","1px solid orangered");
    }else{
        $("#edit-db-user").css("border","1px solid green");
    }

    if(db_passwd==''){
        $("#edit-db-passwd").css("border","1px solid orangered");
    }else{
        $("#edit-db-passwd").css("border","1px solid green");
    }

    if(db_host&&db_name&&db_port&&db_user&&db_passwd){
        $.ajax({
            url:'/db/list/',
            type:"PUT",
            data:JSON.stringify({"action":"put","db_id":db_id,'db_host':db_host,"db_name":db_name,"db_port":db_port, "db_user":db_user,"db_passwd":db_passwd,"db_env":db_env,"user_id":user_id,'db_msg':db_msg}),
            success:function (data) {
                if(data=="perms_false"){
                    $("#msg-alert").empty();
                    $("#msg-alert").append("权限不足，请联系管理员");
                    $("#alert").show();
                }else{
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#edit-dblistModal").modal("hide");
                    $("#alert").show();
                }
            }

        });
    }else{
        $("#edit-test-con-msg").empty();
        $("#edit-test-con-msg").append('<span style="color: orangered">'+"带 * 的信息不能为空"+"</span>");
    }

});


//删除IDC
$("td a[name='del-db']").click(function(){
    var db_id = $(this).attr('db_id');
    var statu = confirm("是否确认删除！");
    if (statu==true)
    {
        $.ajax({
            url: "/db/list/",
            type: "DELETE",
            data: JSON.stringify({'db_id':db_id}),
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

//测试inception是否能正常访问
$("#check-inc").click(function () {
   var inc_ip = $("#inc-ip").val();
   var inc_port = $("#inc-port").val();
   if(inc_ip&&inc_port){
       $.post("/db/inc/",{"action":"check_inc","inc_ip":inc_ip,"inc_port":inc_port},function (data) {
           if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else{
                $("#check-inc-msg").empty();
                $("#check-inc-msg").append('<span style="color: green">'+data+"</span>");
            }
       })
   }else{
       alert("带※选项不能为空！")
   }
});

//添加inception
$("#save-inc").click(function () {
   var inc_ip = $("#inc-ip").val();
   var inc_port = $("#inc-port").val();
   if(inc_ip&&inc_port){
       $.post("/db/inc/",{"action":"add_inc","inc_ip":inc_ip,"inc_port":inc_port},function (data) {
           if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else{
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#alert").show();
            }
       })
   }else{
       alert("带※选项不能为空！")
   }
});


//测试inception 备份数据库是否能正常访问
$("#check-backdb").click(function () {
   var backdb_ip = $("#backdb-ip").val();
   var backdb_port = $("#backdb-port").val();
   var backdb_user = $("#backdb-user").val();
   var backdb_passwd = $("#backdb-passwd").val();
   if(backdb_ip&&backdb_port&&backdb_user&&backdb_passwd){
       $.post("/db/inc/",{"action":"check_backdb","backdb_ip":backdb_ip,"backdb_port":backdb_port,"backdb_user":backdb_user,"backdb_passwd":backdb_passwd},function (data) {
           if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else{
                $("#check-inc-msg").empty();
                $("#check-inc-msg").append('<span style="color: green">'+data+"</span>");
            }
       })
   }else{
       alert("带※选项不能为空！")
   }
});



