////////////////////////////项目管理/////////////////////////////////

//添加项目
$("#sub-project").click(function(){
    var project_name = $("#project-name").val();
    var project_msg = $("#project-msg").val();

    $.post('/code/addproject/',{'project_name':project_name,'project_msg':project_msg},function(data){
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



//编辑项目信息填充内容
$('td a[name="edit-project"]').click(function(){
    var project_id = $(this).attr("project_id");
    $.post("/code/editproject/",{'project_id':project_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');
        $("#edit-project-name").val(info.project_name);
        $("#edit-project-msg").val(info.project_msg);
        $("#sub-edit-project").attr('project_id',info.project_id);
        $("#edit-projectModal").modal('show');
        }
    })
});



//修改项目
$("#sub-edit-project").click(function(){
    var project_name = $("#edit-project-name").val();
    var project_msg = $("#edit-project-msg").val();
    var project_id = $(this).attr("project_id");
    $.post("/code/editproject/",{'action':'edit','project_name':project_name, 'project_msg':project_msg,'project_id':project_id},function(data){
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


//删除项目
$("td a[name='del-project']").click(function(){
   var project_id = $(this).attr('project_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/code/delproject/",{'project_id':project_id},function(data){
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


////////////////////////////站点管理////////////////////////////////

//添加站点
$("#sub-site").click(function(){
    var site_name = $("#site-name").val();
    var site_msg = $("#site-msg").val();
    var site_project = $("#site-project").val();
    var site_url = $("#site-url").val();
    $.post('/code/addsite/',{'site_name':site_name,'site_msg':site_msg,'site_project':site_project,'site_url':site_url},function(data){
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


//编辑站点信息填充内容
$('td a[name="edit-site"]').click(function(){
    var site_id = $(this).attr("site_id");
    $.post("/code/editsite/",{'site_id':site_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        var info = eval('(' + data + ')');
        $("#edit-site-name").val(info.site_name);
        $("#edit-site-msg").val(info.site_msg);
        $("#edit-site-project").val(info.site_project);
        $("#edit-site-url").val(info.site_url);

        $("#sub-edit-site").attr('site_id',info.site_id);
        $("#edit-siteModal").modal('show');
        }
    })
});



//修改站点
$("#sub-edit-site").click(function(){
    var site_id = $(this).attr('site_id');
    var site_name = $("#edit-site-name").val();
    var site_msg = $("#edit-site-msg").val();
    var site_project = $("#edit-site-project").val();
    var site_url = $("#edit-site-url").val();

    $.post('/code/editsite/',{'action':'edit','site_name':site_name,'site_id':site_id,'site_msg':site_msg,'site_project':site_project,'site_url':site_url},function(data){
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




//删除站点
$("td a[name='del-site']").click(function(){
   var site_id = $(this).attr('site_id');
   var statu = confirm("是否确认删除！");
   if (statu==true)
    {
    $.post("/code/delsite/",{'site_id':site_id},function(data){
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


//////////////////代码发布//////////////////////

//新建发布
$("#sub-post").click(function(){
    var site_name = $("#site-name").val();
    var ips = $("#post-ip").val();
    var post_ip = JSON.stringify(ips);
    var site_dir = $("#site-path").val();
    var postsite_msg = $("#postsite-msg").val();
    $.post('/code/addpost/',{'site_name':site_name,'post_ip':post_ip,'site_dir':site_dir,'postsite_msg':postsite_msg},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        alert(data);
        if (data == "发布成功"){
            location.reload();
        }
        }
    });
});



//删除已发布站点
$("td a[name='delcode']").click(function(){
   var post_id = $(this).attr('post_id');

   var statu = confirm("是否确认删除！");

   if (statu==true)
    {
        $.post("/code/delpost/",{'post_id':post_id},function(data){
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



//全站更新
$("a[name='upcode']").click(function(){

    var post_id = $(this).attr("post_id");
    $.post('/code/upcode/',{'post_id':post_id},function(data){
    if (data == "权限不足"){
        alert("权限不足，请联系管理员！");
    }else{
        alert(data);
        //location.reload();
        }
    });
});



 //版本回滚
$("a[name='record_rollback']").click(function(){
    console.log(23213);
    var record_id = $(this).attr("record_id");

    var statu = confirm("是否回滚！");

    if (statu==true) {

        $.post('/code/rollback/', {'record_id': record_id}, function (data) {
            if (data == "权限不足") {
                alert("权限不足，请联系管理员！");
            } else {

                alert(data);
                //location.reload();
            }
        });
    }

});


$(function () {
  $('[data-toggle="tooltip"]').tooltip()
});



////////////////////站点查询//////////////////////////

//通过站点名称查询
$("#select-site").change(function(){
    var site_id = $("#select-site").val();
    $("#select-project").val(0);
    $("#select-ip").val(0);
    $.post('/code/filtersite/',{'site_id':site_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        $("#site-info").empty();
        $("#site-info").append(data);
        }
    })
});



//通过项目查询
$("#select-project").change(function(){

    var project_id= $("#select-project").val();

    $("#select-site").val(0);
    $("#select-ip").val(0);
    $.post('/code/filtersite/',{'project_id':project_id},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        $("#site-info").empty();
        $("#site-info").append(data);
        }
    })
});



//通过设备类型查询
$("#select-ip").change(function(){
    var ip = $("#select-ip").val();
    $("#select-project").val(0);
    $("#select-site").val(0);

    $.post('/code/filtersite/',{'ip':ip},function(data){
    if (data == "权限不足"){
            alert("权限不足，请联系管理员！");
        }else{

        $("#site-info").empty();
        $("#site-info").append(data);
        }
    })
});



//指定更新
$("a[name='upfile']").click(function(){
    var post_id = $(this).attr("post_id");


    $("#file-path").val("");

    $("#sub-upfile").click(function(){

        var file_path = $("#file-path").val();

        if (post_id){
            if (file_path){
                $.post('/code/upfile/',{'post_id':post_id,"file_path":file_path},function(data){
                    if (data == "权限不足"){
                        alert("权限不足，请联系管理员！");
                    }else{

                        alert(data);
                        post_id=undefined;
                        $("#upfileModal").modal("hide");
                        }
                    });
            }else{

                alert("更新路径不能为空");
            }

        }
    })

});


//查询版本信息
$("#sub-getlog").click(function () {
    var site_name = $("#site-name").val();
    var file_path = $("#file-path").val();

    if(file_path){
        $.post('/code/getversion/',{'site_name':site_name,'file_path':file_path},function (data) {

        if (data !="Error"){
            var infos = eval('(' + data + ')');

            var html_str = '';
            for( i=0;i<infos.length;i++){

                tr_str ="<tr>" +
                    "<td name='site_name'>"+
                    infos[i].site_name +
                    "</td>" +
                    "<td name='ip'>"+
                    infos[i].ip+
                    "</td>" +
                    "<td>"+
                    infos[i].author+

                    "</td>" +
                    "<td name='file_path'>"+
                    infos[i].file_path+
                    "</td>" +
                    "<td name='version_id'>"+
                    infos[i].version_id+

                    '</td>' +
                    '<td><div style="max-width:120px;white-space:nowrap;overflow:hidden;text-overflow: ellipsis;">'+
                    infos[i].version_info +
                    '</div>' +
                    '</td>' +
                    '<td><div style="max-width:150px;white-space:nowrap;overflow:hidden;text-overflow: ellipsis;">'+
                    infos[i].update_time+
                    '</div>' +
                    '</td>' +
                    '<td style="padding-left:5px;"><a href="#" name="rollback" style="text-decoration:none;" >'+
                    '<span class="fa fa-rotate-left" data-toggle="tooltip" data-placement="right" title="回滚"></span></a>&nbsp</td></tr>';
                html_str += tr_str;

            }

            js_html = `
            <script type="text/javascript">
                $("a[name='rollback']").click(function () {
                    var tr_obj = $(this).parent().parent();
                    var site_name = tr_obj.find("td[name='site_name']").html()
                    var ip = tr_obj.find("td[name='ip']").html()
                    var file_path = tr_obj.find("td[name='file_path']").html()
                    var version_id = tr_obj.find("td[name='version_id']").html()
                    var statu = confirm("是否回滚！");
    
                    if (statu==true) {

                        $.post("/code/filerollback/",{"site_name":site_name,"ip":ip,"file_path":file_path,"version_id":version_id},function (data) {
                            alert(data);
                        });
                    }
                });
            </script>
            `;
            html_str +=js_html;
            $("#log-table").empty();
            $("#log-table").append(html_str);
        }else {
            alert("信息同步异常，请检查！")
            }

        });

    }else {

        alert("文件路径不能为空！")
    }

});


