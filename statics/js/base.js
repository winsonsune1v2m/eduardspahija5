
/*左侧导航栏缩进功能*/
$(".left-main .sidebar-fold").click(function(){

	if($(this).parent().attr('class')=="left-main left-full")
	{
		$(this).parent().removeClass("left-full");
		$(this).parent().addClass("left-off");

		$(this).parent().parent().find(".right-product").removeClass("right-full");
		$(this).parent().parent().find(".right-product").addClass("right-off");


		$(this).siblings().find(".fa-angle-down").addClass("hiden")
		$(this).siblings().find(".nav-text").addClass("hiden")

        $(this).siblings().find(".nav-item").find(".nav-ul").css("display",'none')
        $(this).siblings().children().children().find(".nav-ul").addClass("nav-li-ul")

		}
	else
	{
		$(this).parent().removeClass("left-off");
		$(this).parent().addClass("left-full");

		$(this).parent().parent().find(".right-product").removeClass("right-off");
		$(this).parent().parent().find(".right-product").addClass("right-full");

        $(this).siblings().children().find(".fa-angle-down").removeClass("hiden")
        $(this).siblings().children().find(".nav-text").removeClass("hiden")

        $(this).siblings().children().children().find(".nav-ul").removeClass("nav-li-ul")

		}
})


//左侧菜单
$(function(){
    // nav收缩展开
    $('.nav-item>a').on('click',function(){
        if (!$('.nav').hasClass('nav-mini')) {
            if ($(this).next().css('display') == "none") {
                //展开未展开
                $('.nav-item').children('ul').slideUp(300);
                $(this).next('ul').slideDown(300);
                $(this).parent('li').addClass('nav-show').siblings('li').removeClass('nav-show');
            }else{
                //收缩已展开
                $(this).next('ul').slideUp(300);
                $('.nav-item.nav-show').removeClass('nav-show');
            }
        }
    });
});





