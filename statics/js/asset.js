///////////////////IDC管理////////////////////

//添加IDC
$("#sub-idc").click(function(){
    var idc_name = $("#idc-name").val();
    var idc_msg = $("#idc-msg").val();
    var idc_admin = $("#idc-admin").val();
    var idc_admin_phone = $("#idc-admin-phone").val();
    var idc_admin_email = $("#idc-admin-email").val();
    $.post("/asset/idc/",{'idc_name':idc_name, 'idc_msg':idc_msg,"idc_admin":idc_admin,"idc_admin_phone":idc_admin_phone,"idc_admin_email":idc_admin_email},function(data){
        $("#msg-alert").empty();
        $("#msg-alert").append(data);
        $("#idcModal").modal("hide");
        $("#alert").show();
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
            var info = eval('(' + data + ')');
            $("#edit-idc-name").val(info.idc_name);
            $("#edit-idc-msg").val(info.idc_msg);
            $("#edit-idc-admin").val(info.idc_admin);
            $("#edit-idc-admin-phone").val(info.idc_admin_phone);
            $("#edit-idc-admin-email").val(info.idc_admin_email);
            $("#sub-edit-idc").attr('idc_id',info.idc_id);
            $("#edit-idcModal").modal('show');
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
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#edit-idcModal").modal("hide");
            $("#alert").show();
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
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#alert").show();
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
        $("#msg-alert").empty();
        $("#msg-alert").append(data);
        $("#groupModal").modal("hide");
        $("#alert").show();
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
            var info = eval('(' + data + ')');
            $("#edit-group-name").val(info.group_name);
            $("#edit-group-msg").val(info.group_msg);
            $("#sub-edit-group").attr('group_id',info.group_id);
            $("#edit-groupModal").modal('show');
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
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#edit-groupModal").modal("hide");
            $("#alert").show();
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
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#alert").show();
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
        $("#msg-alert").empty();
        $("#msg-alert").append(data);
        $("#supplierModal").modal("hide");
        $("#alert").show();
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
            var info = eval('(' + data + ')');
            $("#edit-supplier").val(info.supplier);
            $("#edit-supplier-head").val(info.supplier_head);
            $("#edit-supplier-head-phone").val(info.supplier_head_phone);
            $("#edit-supplier-head-email").val(info.supplier_head_email);
            $("#sub-edit-supplier").attr('supplier_id',info.supplier_id);
            $("#edit-supplierModal").modal('show');
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
            $("#msg-alert").empty();
            $("#msg-alert").append(data);
            $("#edit-supplierModal").modal("hide");
            $("#alert").show();
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
                $("#msg-alert").empty();
                $("#msg-alert").append(data);
                $("#alert").show();
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
        $("#msg-alert").empty();
        $("#msg-alert").append(data);
        $("#hostModal").modal("hide");
        $("#alert").show();
    })

});