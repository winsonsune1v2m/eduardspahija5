///////////////////IDC管理////////////////////

//添加IDC
$("#sub-idc").click(function(){
    var idc_name = $("#idc-name").val();
    var idc_msg = $("#idc-msg").val();
    var idc_admin = $("#idc-admin").val();
    var idc_admin_phone = $("#idc-admin-phone").val();
    var idc_admin_email = $("#idc-admin-email").val();
    $.post("/asset/idc/",{'idc_name':idc_name, 'idc_msg':idc_msg,"idc_admin":idc_admin,"idc_admin_phone":idc_admin_phone,"idc_admin_email":idc_admin_email},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#idcModal").modal("hide");
            $("#alert").show();
        }
    })

});

//获取编辑IDC信息
$('td a[name="edit-idc"]').click(function() {
    var idc_id = $(this).attr("idc_id");
    $.ajax({
        url: "/asset/idc/",
        type: "PUT",
        data: JSON.stringify({'idc_id': idc_id}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-idc-name").val(info.idc_name);
                $("#edit-idc-msg").val(info.idc_msg);
                $("#edit-idc-admin").val(info.idc_admin);
                $("#edit-idc-admin-phone").val(info.idc_admin_phone);
                $("#edit-idc-admin-email").val(info.idc_admin_email);
                $("#sub-edit-idc").attr('idc_id',info.idc_id);
                $("#edit-idcModal").modal('show');
            }

        }
    });
});

//修改idc信息
$("#sub-edit-idc").click(function() {
    var idc_id = $(this).attr("idc_id");
    var idc_name = $("#edit-idc-name").val();
    var idc_msg = $("#edit-idc-msg").val();
    var idc_admin = $("#edit-idc-admin").val();
    var idc_admin_phone = $("#edit-idc-admin-phone").val();
    var idc_admin_email = $("#edit-idc-admin-email").val();
    $.ajax({
        url: "/asset/idc/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','idc_id':idc_id,'idc_name':idc_name,'idc_msg':idc_msg,'idc_admin':idc_admin,
            'idc_admin_phone':idc_admin_phone,'idc_admin_email':idc_admin_email}),
        success: function (data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {

                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-idcModal").modal("hide");
                $("#alert").show();
            }
        }
    });
});


//删除IDC
$("td a[name='del-idc']").click(function(){
    var idc_id = $(this).attr('idc_id');
    var statu = confirm("是否确认删除！");
    if (statu==true)
    {
        $.ajax({
            url: "/asset/idc/",
            type: "DELETE",
            data: JSON.stringify({'idc_id':idc_id}),
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

///////////////////分组管理////////////////////

//添加分组
$("#sub-group").click(function(){
    var group_name = $("#group-name").val();
    var group_msg = $("#group-msg").val();
    $.post("/asset/hostgroup/",{'group_name':group_name, 'group_msg':group_msg},function(data){

        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#groupModal").modal("hide");
            $("#alert").show();
        }
    })

});

//获取编辑分组信息
$('td a[name="edit-group"]').click(function() {
    var group_id = $(this).attr("group_id");
    $.ajax({
        url: "/asset/hostgroup/",
        type: "PUT",
        data: JSON.stringify({'group_id': group_id}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else{
            var info = eval('(' + data + ')');
            $("#edit-group-name").val(info.group_name);
            $("#edit-group-msg").val(info.group_msg);
            $("#sub-edit-group").attr('group_id',info.group_id);
            $("#edit-groupModal").modal('show');
            }
        }
    });
});

//修改分组信息
$("#sub-edit-group").click(function() {
    var group_id = $(this).attr("group_id");
    var group_name = $("#edit-group-name").val();
    var group_msg = $("#edit-group-msg").val();
    $.ajax({
        url: "/asset/hostgroup/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','group_id':group_id,'group_name':group_name,'group_msg':group_msg}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {

                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-groupModal").modal("hide");
                $("#alert").show();
            }
        }
    });
});


//删除分组
$("td a[name='del-group']").click(function(){
    var group_id = $(this).attr('group_id');
    var statu = confirm("是否确认删除！");
    if (statu==true)
    {
        $.ajax({
            url: "/asset/hostgroup/",
            type: "DELETE",
            data: JSON.stringify({'group_id':group_id}),
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


///////////////////供应商管理////////////////////

//添加IDC
$("#sub-supplier").click(function(){
    var supplier = $("#supplier").val();
    var supplier_head = $("#supplier-head").val();
    var supplier_head_phone = $("#supplier-head-phone").val();
    var supplier_head_email = $("#supplier-head-email").val();
    $.post("/asset/supplier/",{'supplier':supplier,"supplier_head":supplier_head,"supplier_head_phone":supplier_head_phone,"supplier_head_email":supplier_head_email},function(data){

        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#supplierModal").modal("hide");
            $("#alert").show();
        }
    })

});

//获取编辑supplier信息
$('td a[name="edit-supplier"]').click(function() {
    var supplier_id = $(this).attr("supplier_id");
    $.ajax({
        url: "/asset/supplier/",
        type: "PUT",
        data: JSON.stringify({'supplier_id': supplier_id}),
        success: function (data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                var info = eval('(' + data + ')');
                $("#edit-supplier").val(info.supplier);
                $("#edit-supplier-head").val(info.supplier_head);
                $("#edit-supplier-head-phone").val(info.supplier_head_phone);
                $("#edit-supplier-head-email").val(info.supplier_head_email);
                $("#sub-edit-supplier").attr('supplier_id', info.supplier_id);
                $("#edit-supplierModal").modal('show');
            }
        }
    });
});

//修改supplier信息
$("#sub-edit-supplier").click(function() {
    var supplier_id = $(this).attr("supplier_id");
    var supplier = $("#edit-supplier").val();
    var supplier_head = $("#edit-supplier-head").val();
    var supplier_head_phone = $("#edit-supplier-head-phone").val();
    var supplier_head_email = $("#edit-supplier-head-email").val();
    $.ajax({
        url: "/asset/supplier/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','supplier_id':supplier_id,'supplier':supplier,'supplier_head':supplier_head,
            'supplier_head_phone':supplier_head_phone,'supplier_head_email':supplier_head_email}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {

                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-supplierModal").modal("hide");
                $("#alert").show();
            }
        }
    });
});


//删除supplier
$("td a[name='del-supplier']").click(function(){
    var supplier_id = $(this).attr('supplier_id');
    var statu = confirm("是否确认删除！");
    if (statu==true)
    {
        $.ajax({
            url: "/asset/supplier/",
            type: "DELETE",
            data: JSON.stringify({'supplier_id':supplier_id}),
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

/////////////////////////服务器管理/////////////////////////////
//添加服务器
$("#sub-host").click(function(){
    var host_ip = $("#host-ip").val();
    var host_remove_port = $("#host-remove-port").val();
    var host_user = $("#host-user").val();
    var host_passwd = $("#host-passwd").val();
    var host_type = $("#host-type").val();
    var host_group = $("#host-group").val();
    var host_idc = $("#host-idc").val();
    var host_supplier = $("#host-supplier").val();
    var host_msg = $("#host-msg").val();
    var serial_num = $("#host-serial-num").val();
    var purchase_date = $("#host-purchase-date").val();
    var overdue_date = $("#host-overdue-date").val();
    $.post("/asset/host/",{'host_ip':host_ip,"host_remove_port":host_remove_port,"host_user":host_user,"host_passwd":host_passwd,
            "host_type":host_type,"host_group":host_group,"host_idc":host_idc,"host_supplier":host_supplier,"host_msg":host_msg,
            "serial_num":serial_num,"purchase_date":purchase_date,"overdue_date":overdue_date},function(data){

        if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#hostModal").modal("hide");
            $("#alert").show();
        }
    })

});

//获取编辑host信息
$('td a[name="edit-host"]').click(function() {
    var host_id = $(this).attr("host_id");
    $.ajax({
        url: "/asset/host/",
        type: "PUT",
        data: JSON.stringify({'host_id': host_id}),
        success: function (data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {


            var info = eval('(' + data + ')');
            $("#edit-host-ip").val(info.host_ip);
            $("#edit-host-remove-port").val(info.host_remove_port);
            $("#edit-host-user").val(info.host_user);
            $("#edit-host-passwd").val(info.host_passwd);
            $("#edit-host-type").val(info.host_type);
            $("#edit-host-group").val(info.host_group);
            $("#edit-host-idc").val(info.host_idc);
            $("#edit-host-supplier").val(info.host_supplier);
            $("#edit-host-msg").val(info.host_msg);
            $("#edit-host-serial-num").val(info.serial_num);
            $("#edit-host-purchase-date").val(info.purchase_date);
            $("#edit-host-overdue-date").val(info.overdue_date);
            $("#sub-edit-host").attr('host_id',info.host_id);
            $("#edit-hostModal").modal('show');

            }
        }
    });
});


//修改服务器信息
$("#sub-edit-host").click(function() {
    var host_id = $(this).attr("host_id");
    var host_ip = $("#edit-host-ip").val();
    var host_remove_port = $("#edit-host-remove-port").val();
    var host_user = $("#edit-host-user").val();
    var host_passwd = $("#edit-host-passwd").val();
    var host_type = $("#edit-host-type").val();
    var host_group = $("#edit-host-group").val();
    var host_idc = $("#edit-host-idc").val();
    var host_supplier = $("#edit-host-supplier").val();
    var host_msg = $("#edit-host-msg").val();
    var serial_num = $("#edit-host-serial-num").val();
    var purchase_date = $("#edit-host-purchase-date").val();
    var overdue_date = $("#edit-host-overdue-date").val();
    $.ajax({
        url: "/asset/host/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','host_id':host_id,'host_ip':host_ip,"host_remove_port":host_remove_port,"host_user":host_user,"host_passwd":host_passwd,
            "host_type":host_type,"host_group":host_group,"host_idc":host_idc,"host_supplier":host_supplier,"host_msg":host_msg,
            "serial_num":serial_num,"purchase_date":purchase_date,"overdue_date":overdue_date}),
        success: function (data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-hostModal").modal("hide");
                $("#alert").show();
            }
        }
    });
});

//删除服务器
$("td a[name='del-host']").click(function(){
    var host_id = $(this).attr('host_id');
    var statu = confirm("是否确认删除！");
    if (statu==true)
    {
        $.ajax({
            url: "/asset/host/",
            type: "DELETE",
            data: JSON.stringify({'host_id':host_id}),
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


/////////////////////////网络设备管理/////////////////////////////
//添加网络设备
$("#sub-netwk").click(function(){
    var netwk_ip = $("#netwk-ip").val();
    var netwk_remove_port = $("#netwk-remove-port").val();
    var netwk_user = $("#netwk-user").val();
    var netwk_passwd = $("#netwk-passwd").val();
    var netwk_type = $("#netwk-type").val();
    var netwk_group = $("#netwk-group").val();
    var netwk_idc = $("#netwk-idc").val();
    var netwk_supplier = $("#netwk-supplier").val();
    var netwk_msg = $("#netwk-msg").val();
    var serial_num = $("#netwk-serial-num").val();
    var purchase_date = $("#netwk-purchase-date").val();
    var overdue_date = $("#netwk-overdue-date").val();
    $.post("/asset/netwk/",{'netwk_ip':netwk_ip,"netwk_remove_port":netwk_remove_port,"netwk_user":netwk_user,"netwk_passwd":netwk_passwd,
            "netwk_type":netwk_type,"netwk_group":netwk_group,"netwk_idc":netwk_idc,"netwk_supplier":netwk_supplier,"netwk_msg":netwk_msg,
            "serial_num":serial_num,"purchase_date":purchase_date,"overdue_date":overdue_date},function(data){

        if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#netwkModal").modal("hide");
            $("#alert").show();
        }
    })

});

//获取修改网络设备的信息
$('td a[name="edit-netwk"]').click(function() {
    var netwk_id = $(this).attr("netwk_id");
    $.ajax({
        url: "/asset/netwk/",
        type: "PUT",
        data: JSON.stringify({'netwk_id': netwk_id}),
        success: function (data) {
            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {

                var info = eval('(' + data + ')');
                $("#edit-netwk-ip").val(info.netwk_ip);
                $("#edit-netwk-remove-port").val(info.netwk_remove_port);
                $("#edit-netwk-user").val(info.netwk_user);
                $("#edit-netwk-passwd").val(info.netwk_passwd);
                $("#edit-netwk-type").val(info.netwk_type);
                $("#edit-netwk-group").val(info.netwk_group);
                $("#edit-netwk-idc").val(info.netwk_idc);
                $("#edit-netwk-supplier").val(info.netwk_supplier);
                $("#edit-netwk-msg").val(info.netwk_msg);
                $("#edit-netwk-serial-num").val(info.serial_num);
                $("#edit-netwk-purchase-date").val(info.purchase_date);
                $("#edit-netwk-overdue-date").val(info.overdue_date);
                $("#sub-edit-netwk").attr('netwk_id', info.netwk_id);
                $("#edit-netwkModal").modal('show');
            }
        }
    });
});


//修改网络设备信息
$("#sub-edit-netwk").click(function() {
    var netwk_id = $(this).attr("netwk_id");
    var netwk_ip = $("#edit-netwk-ip").val();
    var netwk_remove_port = $("#edit-netwk-remove-port").val();
    var netwk_user = $("#edit-netwk-user").val();
    var netwk_passwd = $("#edit-netwk-passwd").val();
    var netwk_type = $("#edit-netwk-type").val();
    var netwk_group = $("#edit-netwk-group").val();
    var netwk_idc = $("#edit-netwk-idc").val();
    var netwk_supplier = $("#edit-netwk-supplier").val();
    var netwk_msg = $("#edit-netwk-msg").val();
    var serial_num = $("#edit-netwk-serial-num").val();
    var purchase_date = $("#edit-netwk-purchase-date").val();
    var overdue_date = $("#edit-netwk-overdue-date").val();
    $.ajax({
        url: "/asset/netwk/",
        type: "PUT",
        data: JSON.stringify({'action':'edit','netwk_id':netwk_id,'netwk_ip':netwk_ip,"netwk_remove_port":netwk_remove_port,"netwk_user":netwk_user,"netwk_passwd":netwk_passwd,
            "netwk_type":netwk_type,"netwk_group":netwk_group,"netwk_idc":netwk_idc,"netwk_supplier":netwk_supplier,"netwk_msg":netwk_msg,
            "serial_num":serial_num,"purchase_date":purchase_date,"overdue_date":overdue_date}),
        success: function (data) {

            if(data=="perms_false"){
                $("#msg-alert").empty();
                $("#msg-alert").append("权限不足，请联系管理员");
                $("#alert").show();
            }else {
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#edit-netwkModal").modal("hide");
                $("#alert").show();
            }
        }
    });
});

//删除网络设备
$("td a[name='del-netwk']").click(function(){
    var netwk_id = $(this).attr('netwk_id');
    var statu = confirm("是否确认删除！");
    if (statu==true)
    {
        $.ajax({
            url: "/asset/netwk/",
            type: "DELETE",
            data: JSON.stringify({'netwk_id':netwk_id}),
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

//////////////////////服务器操作//////////////////////////
//同步服务器信息
$("#synchost").click(function(){
    var ids ='';
    $("input[name='ckb']").each(function(){
        if($(this).is(":checked"))
        {
            ids +=  $(this).attr('id')+",";
        }
    });
    if (ids){
        ids =ids;
    } else{
        ids = 'all';
    }

    $.post("/asset/synchost/",{'ids':ids},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#alert").show();
        }

    });

});


//关键字查询服务器
$("#sub-search").click(function(){
    var search_key= $("#search-key").val();
    $("#select-idc").val("host_idc");
    $("#select-hostgroup").val("host_group");
    $("#select-device").val("host_type");
    $.post('/asset/searchhost/',{'search_key':search_key},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#host-info").empty();
            $("#host-info").append(data);
        }
    });
});


//通过设备类型查询
$("#select-device").change(function(){
    var host_type= $("#select-device").val();
    $("#select-idc").val("host_idc");
    $("#select-hostgroup").val("host_group");
    $.post('/asset/searchhost/',{'host_type':host_type},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#host-info").empty();
            $("#host-info").append(data);
        }
    });
});

//通过分组查询
$("#select-hostgroup").change(function(){
    var hostgroup_id = $("#select-hostgroup").val();
    $("#select-idc").val("host_idc");
    $("#select-device").val("host_type");
    $.post('/asset/searchhost/',{'hostgroup_id':hostgroup_id},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#host-info").empty();
            $("#host-info").append(data);
        }
    });
});

//通过机房查询
$("#select-idc").change(function(){
    var idc_id = $("#select-idc").val();
    $("#select-hostgroup").val("host_group");
    $("#select-device").val("host_type");
    $.post('/asset/searchhost/',{'idc_id':idc_id},function(data){
        if(data=="perms_false"){
            $("#msg-alert").empty();
            $("#msg-alert").append("权限不足，请联系管理员");
            $("#alert").show();
        }else {
            $("#host-info").empty();
            $("#host-info").append(data);
        }
    });
});


//批量删除服务器
$("#delhost").click(function(){
    var ids ='';
    $("input[name='ckb']").each(function(){
        if($(this).is(":checked"))
        {
            ids +=  $(this).attr('id')+",";
        }
    });

   if (ids){
       var statu = confirm("是否确认删除！");
       if (statu==true)
        {
            $.post("/asset/delhost/",{'ids':ids},function(data){
                if(data=="perms_false"){
                    $("#msg-alert").empty();
                    $("#msg-alert").append("权限不足，请联系管理员");
                    $("#alert").show();
                }else {
                    $("#msg-alert").empty();
                    $("#msg-alert").append(data);
                    $("#alert").show();
                }
            })

        }

    } else{

        alert('至少选择一个删除目标！')
    }

});

//连接服务器
$("td a[name='connect-host']").click(function(){
    var host_id = $(this).attr('host_id');

    $.ajax({
        url: "/asset/connecthost/",
        type: "POST",
        data: JSON.stringify({'host_id':host_id}),
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

});

//导出服务器信息
$("#export-host").click(function(){
    $.get('/asset/exporthost',{},function(data){
		if(data=="perms_false"){
			$("#msg-alert").empty();
			$("#msg-alert").append("权限不足，请联系管理员");
			$("#alert").show();
		}else {
			if(data.code == 1){
				$("#exportModal").modal();
            }else {
	
				$("#msg-alert").empty();
				$("#msg-alert").append(data.message);
				$("#alert").show();
				
			}
		}
    });
});



