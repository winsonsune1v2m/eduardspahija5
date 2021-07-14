////////////////环境部署//////////////////

//添加发布环境

$("#sub-depend").click(function(){
    var depend_name = $("#depend-name").val();
    var depend_version = $("#depend-version").val();

    var install_script = $("#install-script").val();
    $.post('/sys/addepend/',{'depend_name':depend_name,'depend_version':depend_version,'install_script':install_script},function(data){
     if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "添加成功"){
            location.reload();
        }
        }
    });
});




//编辑依赖环境填充内容
$('td a[name="edit-depend"]').click(function(){
    var depend_id = $(this).attr("depend_id");
    $.post("/sys/editdepend/",{'depend_id':depend_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');
        $("#edit-depend-name").val(info.depend_name);
        $("#edit-depend-version").val(info.depend_version);

        $("#edit-install-script").val(info.install_script);
        $("#sub-edit-depend").attr('depend_id',info.depend_id);
        $("#edit-dependModal").modal('show');
        }
    })
});



//修改依赖环境
$("#sub-edit-depend").click(function(){
    var depend_id = $(this).attr('depend_id');
    var depend_name = $("#edit-depend-name").val();
    var depend_version =$("#edit-depend-version").val();

    var install_script = $("#edit-install-script").val();
    $.post('/sys/editdepend/',{'action':'edit','depend_name':depend_name,'depend_id':depend_id,'depend_version':depend_version,'install_script':install_script},function(data){
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




//删除依赖环境
$("td a[name='del-depend']").click(function(){
   var depend_id = $(this).attr('depend_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/sys/deldepend/",{'depend_id':depend_id},function(data){
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









