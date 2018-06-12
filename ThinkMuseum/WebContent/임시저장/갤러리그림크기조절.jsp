<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
* {
    margin: 0px;
    padding: 0px;
    border: 1px solid red;
}
div {
    width: 150px;
    height: 200px;
    float: left;
    margin: 30px;
}


</style>
<script src="../js/jquery-3.2.1.min.js"></script>
<script>
$(window).on('load', function () {
	$('img').each(function () {
		if (this.naturalWidth > this.naturalHeight) {
			$(this).css('width', '100%');
			
			var afterHeight = $(this).height();
			if (afterHeight > 200) {
				$(this).css('height', '200px');
			}
			
		} else {
			$(this).css('height', '100%');
			
			var afterWidth = $(this).width();
            if (afterWidth > 150) {
                $(this).css('width', '150px');
            }
		}
	});
});

// window.onload = function () {
// 	alert('cc');
// }
</script>
</head>
<body>
<div><img src="../jq1/apple.jpg"></div>
<div><img src="../jq1/banana.jpg"></div>
<div><img src="../jq1/cherry.jpg"></div>
<div><img src="../jq1/kiwi.jpg"></div>
<div><img src="../jq1/mango.jpg"></div>
</body>
</html>