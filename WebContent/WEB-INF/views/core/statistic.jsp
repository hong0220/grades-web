<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>话题情感倾向统计</title>
<script src="${ctx}/static/jquery/1.7.2/jquery.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/highcharts/highcharts.js"
	type="text/javascript"></script>
<script src="${ctx}/static/highcharts/modules/exporting.js"
	type="text/javascript"></script>
</head>

<body>
	<div id="percentContainer"
		style="min-width: 400px; height: 400px; margin: 0 auto"></div>
	<div id="numTrendContainer"
		style="min-width: 400px; height: 400px; margin: 0 auto"></div>

	<script>
		$(function() {
			var numTrendChart;
			var percentChart;
			$(document).ready(
				function() {
					
					
					
					
					var day = ["3月1号", "3月2号", "3月3号", "3月4号", "3月5号",
						"3月6号", "3月7号", "3月8号", "3月9号", "3月10号", "3月11号", "3月12号",
						"3月1号", "3月2号", "3月3号", "3月4号", "3月5号", "3月6号", "3月7号", "3月8号",
						"3月9号", "3月10号", "3月11号", "3月12号" ];
					var jiji = [ 0.9, 0.6, 3.5, 8.4, 13.5,
								17.0, 18.6, 17.9, 14.3, 9.0,
								3.9, 1.0, 0.9, 0.6, 3.5, 8.4,
								13.5, 17.0, 18.6, 17.9, 14.3,
								9.0, 3.9, 1.0 ];
					var xiaoji =[ 3.9, 4.2, 5.7, 8.5, 11.9,
								15.2, 17.0, 16.6, 14.2, 10.3,
								6.6, 4.8, 3.9, 4.2, 5.7, 8.5,
								11.9, 15.2, 17.0, 16.6, 94.2,
								10.3, 6.6, 4.8 ];
					var zhongxing = [ 4.9, 5.2, 6.7, 8.5, 11.9,
									15.2, 17.0, 9.6, 3.2, 3.3, 6.6,
									8.8, 4.9, 5.2, 6.7, 8.5, 11.9,
									15.2, 17.0, 9.6, 3.2, 3.3, 6.6,
									8.8 ];
					setTrendChart(day,jiji,xiaoji,zhongxing);
				}
			);
		});
		
		function setTrendChart(day,jiji,xiaoji,zhongxing) {
			numTrendChart = new Highcharts.Chart({
				chart : {
					renderTo : 'numTrendContainer',
					type : 'line',
					marginRight : 130,
					marginBottom : 25
				},
				title : {
					text : '主观微博的数量变化图',
					x : -30
				},
				xAxis : {
					categories : day
				},
				yAxis : {
					title : {
						text : '微博数量'
					},
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#808080'
					} ]
				},
				tooltip : {
					formatter : function() {
						return '<b>' + this.series.name
								+ '</b><br/>' + this.x + ': '
								+ this.y + '条';
					}
				},
				legend : {
					layout : 'vertical',
					align : 'right',
					verticalAlign : 'top',
					x : -10,
					y : 100,
					borderWidth : 0
				},
				series : [
						{
							name : '积极情感的微博数量增量',
							data : jiji
						},
						{
							name : '消极情感的微博数量增量',
							data : xiaoji
						},
						{
							name : '中性情感的微博数量增量',
							data : zhongxing
						} ]
			});
		}
	</script>
</body>