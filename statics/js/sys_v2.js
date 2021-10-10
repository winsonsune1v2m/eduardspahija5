////////////////环境部署//////////////////

//添加发布环境

$("#sub-sofeware").click(function(){
    var sofeware_name = $("#sofeware-name").val();
    var sofeware_version = $("#sofeware-version").val();
    var install_script = $("#install-script").val();
    $.post('/sys/sofeware/',{'sofeware_name':sofeware_name,'sofeware_version':sofeware_version,'install_script':install_script},function(data){

        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#sofewareModal").modal("hide");
            $("#alert").show();
        }
    });
});


//获取修改环境信息
$('td a[name="edit-sofeware"]').click(function(){
    var sofeware_id = $(this).attr("sofeware_id");

    $.ajax({
        url: "/sys/sofeware/",
        type: "PUT",
        data: JSON.stringify({'sofeware_id':sofeware_id}),
        success: function(data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-sofeware-name").val(info.sofeware_name);
                $("#edit-sofeware-version").val(info.sofeware_version);
                $("#edit-install-script").val(info.install_script);
                $("#sub-edit-sofeware").attr('sofeware_id', info.sofeware_id);

                $("#div-sofeware-name").css('display', 'block');
                $("#div-sofeware-version").css('display', 'block');
                $("#edit-sofewareModal").modal('show');

            }

         }
        });
});


//获取修改环境信息
$('td a[name="edit-sofeware-script"]').click(function(){
    var sofeware_id = $(this).attr("sofeware_id");

    $.ajax({
        url: "/sys/sofeware/",
        type: "PUT",
        data: JSON.stringify({'sofeware_id':sofeware_id}),
        success: function(data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-sofeware-name").val(info.sofeware_name);
                $("#edit-sofeware-version").val(info.sofeware_version);
                $("#edit-install-script").val(info.install_script);
                $("#sub-edit-sofeware").attr('sofeware_id', info.sofeware_id);

                $("#div-sofeware-name").css('display', 'none');
                $("#div-sofeware-version").css('display', 'none');
                $("#edit-sofewareModal").modal('show');

            }

         }
        });
});



//修改环境信息
$("#sub-edit-sofeware").click(function(){
    var sofeware_id = $(this).attr('sofeware_id');
    var sofeware_name = $("#edit-sofeware-name").val();
    var sofeware_version = $("#edit-sofeware-version").val();
    var install_script = $("#edit-install-script").val();
    $.ajax({
        url: "/sys/sofeware/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','sofeware_name':sofeware_name,'sofeware_version':sofeware_version,
            'install_script':install_script,"sofeware_id":sofeware_id}),
        success: function(data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-sofewareModal").modal("hide");
                $("#alert").show();
            }

         }
    });
});


//删除环境
$("td a[name='del-sofeware']").click(function(){
   var sofeware_id = $(this).attr('sofeware_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
        $.ajax({
            url: "/sys/sofeware/",
            type: "DELETE",
            data: JSON.stringify({'sofeware_id':sofeware_id}),
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





