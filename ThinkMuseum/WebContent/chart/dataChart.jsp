<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="dao.PaintingDao"%>
<%@page import="domain.Painting"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">

<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
//구글 시각화 API를 로딩하는 메소드
google.charts.load('current', {packages: ['corechart']});

// 구글 시각화 API가 로딩이 완료되면,
// 인자로 전달된 콜백함수를 내부적으로 호출하여 차트를 그리는 메소드
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	columnChart1();
	pieChart1();
	
}

//묶은 세로 막대형 차트 1
function columnChart1() {
	<%
	PaintingDao dao = PaintingDao.getInstance();
 	JSONArray jsonArray = dao.getLikeCountByTitle();
 	System.out.println("jsonArray : " + jsonArray);
	%>
	var arr = <%=jsonArray%>;
	
	/* var arr = [
		['작품', '좋아요'],
		['카페테라스', 100],
		['별이 빛나는 밤', 117],
		['해바라기', 66],
		['국화꽃', 25]
	]; */
	
	
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	var dataTable = google.visualization.arrayToDataTable(arr);
	// 옵션객체 준비
	var options = {
			title: '좋아요',
			hAxis: {
				title: '작품',
				titleTextStyle: {
					color: 'red'
				}
			}
	};
	// 차트를 그릴 영역인 div 객체를 가져옴 
	var objDiv = document.getElementById('column_chart_div1');
	// 인자로 전달한 div 객체를 컬럼차트객체로 반환하는 메소드
	var chart = new google.visualization.ColumnChart(objDiv);
	// 컬럼차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable, options);
} // drawColumnChart1()의 끝

//원형 차트 1
function pieChart1() {
	<%
//	PaintingDao dao = new PaintingDao();
// 	JSONArray jsonArray = dao.getPaintingCountByArtist();
// 	System.out.println("jsonArray : " + jsonArray);
	%>
<%-- 	var arr = <%=jsonArray %>; --%>
	
// 	var arr = [
// 		['작가명', '작품 수'],
// 		['고흐', 3],
// 		['세잔', 7],
// 		['마그리트', 5],
// 		['뭉크', 2],
// 		['클림트', 1]
// 	];
	
	$.ajax({
		url: 'pieChart_data.jsp',
		success: function (arr) {
			drawPieChart1(arr)
		}
	});
}

function drawPieChart1(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);
	
	var options = { title: '작가별 등록 작품' };
	
	var objDiv = document.getElementById('pie_chart_div1');
	var chart = new google.visualization.PieChart(objDiv);
	chart.draw(dataTable, options);
	
	// select(선택) 이벤트 핸들러(처리)용 함수를 무명함수로 정의
	var selectHandler = function () {
		var selectedItem = chart.getSelection()[0];
        var value = dataTable.getValue(selectedItem.row, 0);
        alert('선택한 항목은 ' + value + ' 입니다.');
	};
//		function selectHandler() {
//			var selectedItem = chart.getSelection()[0];
//	        var value = dataTable.getValue(selectedItem.row, 0);
//	        alert('선택한 항목은 ' + value + ' 입니다.');
//		}
	
	// 적용할 차트, 적용할 이벤트명, 이벤트 핸들러 함수를 인자로 이벤트 리스너에 등록
	google.visualization.events.addListener(chart, 'select', selectHandler);
}

$(document).ready(function () {
	$('button').click(function () {
		drawChart();
	});
});
</script>
</head>
<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<div align="center">
<div id="column_chart_div1" style="width: 900px; height: 500px;"></div>
<div id="pie_chart_div1" style="width: 900px; height: 500px;"></div>
<!-- <button>버튼</button> -->
</div>
<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</body>
</html>