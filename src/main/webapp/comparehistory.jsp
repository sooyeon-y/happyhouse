<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>

    
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Happy House</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
    
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>	

	var configs = [];

	$(function(){
		// 페이지 로드시 접속중인 유저의 히스토리 가져오기
		$.ajax({
				type: "GET",
				url: "${root}/dealsearch/gethistory",
				dataType: "json",
				success: function(list){ // hashMap 형태로 [날짜-거래정보 2개] 이렇게 날아옴 
					let area = $("#printArea");
					let tablenum = 1;
					
					for (obj in list){
						console.log(obj);
						console.log(list[obj]);
						console.log(list[obj][0].aptName);
						
						let row = $('<div class="form-group row"/>');
						
						let table = $('<table id="table' + tablenum + '" class="col-md-9 table table-bordered table-condensed"/>');
						
						table.append();
						table.append($('<tr/>').html($('<th colspan="8">저장일시: ' + obj + '</th>')));
						
						let tr = $('<tr class="thead-light"/>');
						tr.append($('<th>거래번호</th>'));
						tr.append($('<th>법정동</th>'));
						tr.append($('<th>아파트 이름</th>'));
						tr.append($('<th>거래금액</th>'));
						tr.append($('<th>월세금액</th>'));
						tr.append($('<th>건축연도</th>'));
						tr.append($('<th>전용면적</th>'));
						tr.append($('<th>추천점수</th>'));
						
						let deal1 = list[obj][0];
						let tr2 = $('<tr/>');
						tr2.append($('<td class="table-primary"/>').text(deal1.no));
						tr2.append($('<td/>').text(deal1.dong));
						tr2.append($('<td/>').text(deal1.aptName));
						tr2.append($('<td/>').text(deal1.dealAmount));
						tr2.append($('<td/>').text(deal1.rentMoney));
						tr2.append($('<td/>').text(deal1.buildYear));
						tr2.append($('<td/>').text(deal1.area));
						tr2.append($('<td/>').text(deal1.score_avg));
						
						let deal2 = list[obj][1];
						let tr3 = $('<tr/>');
						tr3.append($('<td class="table-warning"/>').text(deal2.no));
						tr3.append($('<td/>').text(deal2.dong));
						tr3.append($('<td/>').text(deal2.aptName));
						tr3.append($('<td/>').text(deal2.dealAmount));
						tr3.append($('<td/>').text(deal2.rentMoney));
						tr3.append($('<td/>').text(deal2.buildYear));
						tr3.append($('<td/>').text(deal2.area));
						tr3.append($('<td/>').text(deal2.score_avg));
						
						tr.appendTo(table);
						tr2.appendTo(table);
						tr3.appendTo(table);

						console.log($("#table" + tablenum + " > tr:nth-child(3) > td:nth-child(4)").html());
						
						let divChart = $('<div class="col-md-3"/>');
						let canvas = $('<canvas id="compareChart' + tablenum + '" width="100" height="100"/>');
						
						canvas.appendTo(divChart);
						
						table.appendTo(row);
						divChart.appendTo(row);
						
						row.appendTo(area);
						
						// compare_coloring 부분 위에 있었던걸 밑으로 옮겼다. row가 추가되면서 table이 row에 붙고, row가 area에 붙는 식으로 바꿨는데
						// 그게 다 끝난 다음에야 #table1을 찾을 수가 있나...? 여튼 구조 바꾸고 나니 위에선 셀렉터로 못찾는 것 같았다...
						compare_coloring($("#table" + tablenum + " > tr:nth-child(3) > td:nth-child(4)"),
								$("#table" + tablenum + " > tr:nth-child(4) > td:nth-child(4)"), 
								deal1.dealAmount.trim().replace(",", ""), deal2.dealAmount.trim().replace(",", ""), 0);
						if (deal1.rentMoney != null && deal2.rentMoney != null){
							compare_coloring($("#table" + tablenum + " > tr:nth-child(3) > td:nth-child(5)"),
									$("#table" + tablenum + " > tr:nth-child(4) > td:nth-child(5)"), 
									deal1.rentMoney.trim().replace(",", ""), deal2.rentMoney.trim().replace(",", ""), 0);
						}
						
						compare_coloring($("#table" + tablenum + " > tr:nth-child(3) > td:nth-child(6)"),
								$("#table" + tablenum + " > tr:nth-child(4) > td:nth-child(6)"), 
								deal1.buildYear, deal2.buildYear, 1);
						
						compare_coloring($("#table" + tablenum + " > tr:nth-child(3) > td:nth-child(7)"),
								$("#table" + tablenum + " > tr:nth-child(4) > td:nth-child(7)"),
								deal1.area, deal2.area, 1);
						
						compare_coloring($("#table" + tablenum + " > tr:nth-child(3) > td:nth-child(8)"),
								$("#table" + tablenum + " > tr:nth-child(4) > td:nth-child(8)"), 
								deal1.score_avg, deal2.score_avg, 1);
						
						
						let varname = "radar"+tablenum;
						
						var compareChartConfig = {
							    type: 'radar',
							    data: {		    	
							        labels: ['저렴', '신축', '넓이'],
							        datasets: []
							    },
							    options: {
							        tooltips: {
							            enabled: true
							        },
						    	    scale: {
						    	        angleLines: {
						    	            display: false
						    	        },
						    	        ticks: {
						    	            suggestedMin: 50,
						    	            suggestedMax: 100
						    	        }
						    	    }
							    }
							}; 
						
						configs.push(compareChartConfig);
						
						window[varname] = new Chart(document.getElementById('compareChart' + tablenum), configs[tablenum-1]);
						compareRadarGraphAdd(tablenum, deal1, 'rgb(51, 51, 204)', 'rgba(51, 51, 204, 0.2)');
						compareRadarGraphAdd(tablenum, deal2, 'rgb(230, 115, 0)', 'rgba(230, 115, 0, 0.2)');
						
						tablenum++;
					}
				}
		});
		
	});
	
	function compareRadarGraphAdd(tablenum, deal, color, bgcolor){
		let varname = "radar"+tablenum;
		var newDataset = {
			label: deal.aptName,
			borderColor: color,
			backgroundColor: bgcolor,
			pointBackgroundColor: color,
			data: [deal.score_dealAmount, deal.score_buildYear, deal.score_area]
		};
		configs[tablenum-1].data.datasets.push(newDataset);
		window[varname].update();
	}
	
	function compare_coloring(leftelem, rightelem, leftval, rightval, flag){
		let diff = rightval - leftval;
		
		if (diff % 1 !== 0){ // 정수가 아닌 경우 (면적)
			diff = diff.toFixed(2);
		}
		let color1, color2;
		if (flag == 0){
			color1 = "red";
			color2 = "green";
		}
		else{
			color1 = "green";
			color2 = "red";
		}
		// 색깔 지정
		if (diff > 0){
			rightelem.css("color", color1);
			leftelem.css("color", color2);
			rightelem.html(rightelem.html() + " (+" + diff + ")");
		}
		else if (diff < 0){
			rightelem.css("color", color2);
			leftelem.css("color", color1);
			rightelem.html(rightelem.html() + " (" + diff + ")");
		}
	}
	
</script>
    
    
    
    
    </head>
    <body class="sb-nav-fixed">

<%@include file="menubar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid">

<h3 class="mt-4">거래내역 비교 기록</h3>

<br>

<div id="printArea">

</div>

</div>
</main>
</div>

        <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/datatables-demo.js"></script>

</body>
</html>