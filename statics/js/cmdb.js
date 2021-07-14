//IP地址检验
$("#IP").blur(function(){
    var IP = $(this).val();
    re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;
    if(re.test(IP)){
        if(RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256){
            $(this).css("border-color","green");
        }else{
        $(this).css("border-color","red");
        }
    }else{
        $(this).css("border-color","red");

    };
});




//端口校验
$("#port").blur(function(){
    var port = $(this).val();
    if(port==""){
        $(this).css("border-color","red");
        }else{
            $(this).css("border-color","green");
        }
});



//添加主机
$("#sub-host").click(function(){
    var IP = $("#IP").val();
    var username = $("#username").val();
    var device_type = $("#device-type").val();
    var idc = $("#idc").val();
    var host_group = $("#host-group").val();
    var msg = $("#msg").val();
    var port = $("#port").val();
    $.post("/cmdb/addhost/",{'IP':IP, 'username':username,'device_type':device_type,'idc':idc,'host_group':host_group,'msg':msg,'port':port},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "设备已添加"){
            location.reload();
        }
    }
    })
});



//添加IDC
$("#sub-idc").click(function(){
    var idc_name = $("#idc-name").val();
    var idc_msg = $("#idc-msg").val();
    $.post("/cmdb/addidc/",{'idc_name':idc_name, 'idc_msg':idc_msg},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "添加成功"){
            location.reload();
        }
    }
    })

});



//编辑IDC信息填充内容
$("td a[name='edit-idc']").click(function(){
    var idc_id = $(this).attr("idc_id");
    $.post("/cmdb/editidc/",{'idc_id':idc_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');
        $("#edit-idc-name").val(info.idc_name);
        $("#edit-idc-msg").val(info.idc_msg);
        $("#sub-edit-idc").attr('idc_id',info.idc_id);
        $("#edit-idcModal").modal('show');
        }
    })
});


//修改IDC
$("#sub-edit-idc").click(function(){
    var idc_name = $("#edit-idc-name").val();
    var idc_msg = $("#edit-idc-msg").val();
    var idc_id = $(this).attr("idc_id");
    $.post("/cmdb/editidc/",{'action':'edit','idc_name':idc_name, 'idc_msg':idc_msg,'idc_id':idc_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "修改成功"){
            location.reload();
        }
    }
    })

});



//删除IDC
$("td a[name='del-idc']").click(function(){
   var idc_id = $(this).attr('idc_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/cmdb/delidc/",{'idc_id':idc_id},function(data){
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




////////////////////////主机组操作//////////////////////////////

//添加主机组
$("#sub-group").click(function(){
    var group_name = $("#group-name").val();
    var group_msg = $("#group-msg").val();
    $.post("/cmdb/addgroup/",{'group_name':group_name, 'group_msg':group_msg},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "添加成功"){
            location.reload();
        }
    }
    })

});



//编辑主机组信息填充内容
$("td a[name='edit-group']").click(function(){
    var group_id = $(this).attr("group_id");
    $.post("/cmdb/editgroup/",{'group_id':group_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');
        $("#edit-group-name").val(info.group_name);
        $("#edit-group-msg").val(info.group_msg);
        $("#sub-edit-group").attr('group_id',info.group_id);
        $("#edit-groupModal").modal('show');
        }
    })
});


//修改主机组
$("#sub-edit-group").click(function(){
    var group_name = $("#edit-group-name").val();
    var group_msg = $("#edit-group-msg").val();
    var group_id = $(this).attr("group_id");
    $.post("/cmdb/editgroup/",{'action':'edit','group_name':group_name, 'group_msg':group_msg,'group_id':group_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "修改成功"){
            location.reload();
        }
    }
    })

});



//删除主机组
$("td a[name='del-group']").click(function(){
   var group_id = $(this).attr('group_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/cmdb/delgroup/",{'group_id':group_id},function(data){

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



//////////////////操作//////////////////////

//同步主机信息
$("#synchost").click(function(){

    var ips ='';

    $("input[name='ckb']").each(function(){
        if($(this).is(":checked"))
        {
            ips +=  $(this).attr('id')+",";
        }
    });


    if (ips){

        ips =ips;
    } else{

        ips = 'all';
    }

    $.post("/cmdb/synchost/",{'ips':ips},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "已同步"){
            location.reload();
        }
    }
    })

});


//批量删除主机
$("#delhost").click(function(){

    var ips ='';

    $("input[name='ckb']").each(function(){
        if($(this).is(":checked"))
        {
            ips +=  $(this).attr('id')+",";
        }
    });

   if (ips){
       var statu = confirm("是否确认删除！");
       if (statu==true)
        {
        $.post("/cmdb/delhost/",{'ips':ips},function(data){
        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

            if (data == "已删除"){
                location.reload();
            }
        }
        })

        }

    } else{

        alert('至少选择一个删除目标！')
    }

});


//删除主机
$("td a[name='del']").click(function(){
   var ip = $(this).attr('ip');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/cmdb/delhost/",{'ips':ip},function(data){

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


//编辑主机信息填充内容
$("td a[name='edit']").click(function(){
    var ip = $(this).attr('ip');
    $.post("/cmdb/edithost/",{'ip':ip},function(data){
        if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');
        $("#edit-IP").val(info.ip);
        $("#edit-username").val(info.username);
        $("#edit-device-type").val(info.device_type);
        $("#edit-idc").val(info.idc);
        $("#edit-port").val(info.port);
        $("#edit-host-group").val(info.host_group);
        $("#edit-msg").val(info.msg);
        $("#sub-edit-host").attr('host_id',info.host_id);
        $("#edit-hostModal").modal('show');
        }
    })
});




//修改主机
$("#sub-edit-host").click(function(){
    var IP = $("#edit-IP").val();
    var username = $("#edit-username").val();

    var device_type = $("#edit-device-type").val();
    var idc = $("#edit-idc").val();
    var host_group = $("#edit-host-group").val();
    var msg = $("#edit-msg").val();
    var port = $("#edit-port").val();
    var action = 'edit';
    var host_id = $(this).attr("host_id");
    $.post("/cmdb/edithost/",{'action':action,'host_id':host_id,'IP':IP, 'username':username,'device_type':device_type,'idc':idc,'host_group':host_group,'msg':msg,'port':port},function(data){
     if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "信息已修改"){
            location.reload();
        }
    }
    })

});





//////////////////查询///////////////////////


$("#ckb_head").click(function(){
   if($(this).prop("checked")){//全选
       $("input[name='ckb']").attr("checked","true");
   }else{//全不选
       $("input[name='ckb']").removeAttr("checked");
   }
});



//导出资产清单
$("#export-cmdb").click(function(){
    var ips = 'all'
    $.post('/cmdb/expcmdb/',{'ips':ips},function(data){

    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{


        window.location.href=data
        }
    })
});


//通过机房查询
$("#select-idc").change(function(){
    var idc_id = $("#select-idc").val();
    var hostgroup_id = $("#select-hostgroup").val();
    var device_type= $("#select-device").val();
    $.post('/cmdb/filterhost/',{'hostgroup_id':hostgroup_id,'idc_id':idc_id,'device_type':device_type},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        $("#host-info").empty();
        $("#host-info").append(data);
        }
    })
});



//通过主机组查询
$("#select-hostgroup").change(function(){
    var idc_id = $("#select-idc").val();
    var hostgroup_id = $("#select-hostgroup").val();
    var device_type= $("#select-device").val();

    $.post('/cmdb/filterhost/',{'hostgroup_id':hostgroup_id,'idc_id':idc_id,'device_type':device_type},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        $("#host-info").empty();
        $("#host-info").append(data);
        }
    })
});


//通过设备类型查询
$("#select-device").change(function(){
    var idc_id = $("#select-idc").val();
    var hostgroup_id = $("#select-hostgroup").val();
    var device_type= $("#select-device").val();

    $.post('/cmdb/filterhost/',{'hostgroup_id':hostgroup_id,'idc_id':idc_id,'device_type':device_type},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        $("#host-info").empty();
        $("#host-info").append(data);
        }
    });
});



//关键字搜索
$("#sub-search").click(function(){
    var info_search= $("#info-search").val();
    var idc_id = $("#select-idc").val();
    var hostgroup_id = $("#select-hostgroup").val();
    var device_type= $("#select-device").val();

    $.post('/cmdb/filterhost/',{'info_search':info_search},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        $("#host-info").empty();
        $("#host-info").append(data);
        }
    });
});









