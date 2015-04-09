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
		Date.prototype.pattern = function(fmt) {
			var o = {
				"M+" : this.getMonth() + 1, //月份           
				"d+" : this.getDate(), //日           
				"h+" : this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时           
				"H+" : this.getHours(), //小时           
				"m+" : this.getMinutes(), //分           
				"s+" : this.getSeconds(), //秒           
				"q+" : Math.floor((this.getMonth() + 3) / 3), //季度           
				"S" : this.getMilliseconds()
			//毫秒           
			};
			var week = {
				"0" : "/u65e5",
				"1" : "/u4e00",
				"2" : "/u4e8c",
				"3" : "/u4e09",
				"4" : "/u56db",
				"5" : "/u4e94",
				"6" : "/u516d"
			};
			if (/(y+)/.test(fmt)) {
				fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
						.substr(4 - RegExp.$1.length));
			}
			if (/(E+)/.test(fmt)) {
				fmt = fmt
						.replace(
								RegExp.$1,
								((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f"
										: "/u5468")
										: "")
										+ week[this.getDay() + ""]);
			}
			for ( var k in o) {
				if (new RegExp("(" + k + ")").test(fmt)) {
					fmt = fmt.replace(RegExp.$1,
							(RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k])
									.substr(("" + o[k]).length)));
				}
			}
			return fmt;
		};

		$(function() {
			var numTrendChart;
			var percentChart;
			$(document).ready(
					function() {
						$.ajax({
							type : "post",
							url : "${ctx}/total",
							dataType : "json",
							contentType : "application/json;charset=utf-8",
							success : function(data) {
								var day = new Array();
								var jiji = new Array();
								var xiaoji = new Array();
								for (var i = 0; i < data.length; ++i) {
									var result = data[i];
									var unixTimestamp = new Date(result.day);
									var commonTime = unixTimestamp
											.pattern("yyyy-MM-dd");
									day.push(commonTime);
									jiji.push(result.positive);
									xiaoji.push(result.negative);
								}
								setTrendChart(day, jiji, xiaoji);
							}
						});
					});
		});

		function setTrendChart(day, jiji, xiaoji) {
			numTrendChart = new Highcharts.Chart({
				chart : {
					renderTo : 'numTrendContainer',
					type : 'line',
					marginRight : 130,
					marginBottom : 40
				},
				title : {
					text : '微博情感权值变化图',
					x : -30
				},
				xAxis : {
					categories : day
				},
				yAxis : {
					title : {
						text : '情感权值'
					},
					plotLines : [ {
						value : 0,
						width : 1,
						color : '#808080'
					} ]
				},
				tooltip : {
					formatter : function() {
						return '<b>' + this.x + ' ' + this.series.name + ': '
								+ this.y + '</b><br/>';
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
				series : [ {
					name : '积极情感的情感权值',
					data : jiji
				}, {
					name : '消极情感的情感权值',
					data : xiaoji
				} ]
			});
		}
	</script>
</body>