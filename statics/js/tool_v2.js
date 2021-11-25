
$(document).ready(function(){
    $('#btn-upfile').click(function(){
        var path = $("#up-path").val();
        var ip = $("#cur-host").text();
        var formData = new FormData();
        formData.append("path", path);
        formData.append("ip", ip);
        upfile = $("#upfile").get(0).files[0];
        if(upfile){
            formData.append("upfile",upfile);
            $.ajax({
                 url: "/tool/upfile/",
                 type: "POST",
                 processData: false,
                 contentType: false,
                 data: formData,
                 success: function(msg) {
                     alert(msg);
                 }
            });
        }else{
            alert("请选择上传文件")
        }

    });
});


$(document).ready(function(){
    $('#btn-downfile').click(function(){

        var path = $("#down-path").val();

        var ip = $("#cur-host").text();

        var formData = new FormData();

        formData.append("path", path);
        formData.append("ip", ip);

        if(path){
            $.ajax({
                 url: "/tool/downfile/",
                 type: "POST",
                 processData: false,
                 contentType: false,
                 data: formData,
                 success: function(msg) {
                    window.location.href=msg
                 }
            });
        }else{
            alert("文件路径不能为空")
        }

    });

});
