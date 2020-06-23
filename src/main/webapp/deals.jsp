<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Happy House</title>
<link href="css/styles.css" rel="stylesheet" />
<link href="css/layout.css" rel="stylesheet" />
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" crossorigin="anonymous" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>	

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

	$(function(){
		// 점수비교 그래프 초기화
		window.myRadar = new Chart(document.getElementById('compareChart'), compareChartConfig);

		// 처음 페이지 로드시 구 리스트 가져오기
		$.ajax({
				type: "GET",
				url: "${root}/dealsearch/getgulist",
				dataType: "json",
				success: function(list){
					let defaultoption = $('<option selected/>').text("[구선택]");
					$("#gu-select").append(defaultoption);
					$(list).each(function(index, element){ // 반드시 add 안에 배열 형태로 줘야 알아먹음....
						let option = $('<option value="' + this.code + '"/>').text(this.name);
						$("#gu-select").append(option);
					});
				}
		});
		
		// 구 선택시, 동 리스트 가져오기
		$('#gu-select').change(function(){
			let code = $(this).val();
			$.ajax({
				type: "GET",
				url: "${root}/dealsearch/getdonglist/" + code,
				dataType: "json",
				success: function(list){
					$("#dong-select").empty();
					let defaultoption = $('<option selected/>').text("[동선택]");
					$("#dong-select").append(defaultoption);

					$(list).each(function(index, element){ // 반드시 add 안에 배열 형태로 줘야 알아먹음....
						let option = $('<option value="' + this + '"/>').text(this);
						$("#dong-select").append(option);
					});
				}
			});
		});
		
		// 동이름으로 검색
		$('#dong-select').change(function(){
			let searchText = $(this).val();
			searchDeal("dong", searchText);
		});
		
		// 검색 버튼 클릭시 => 이제는 아파트이름으로 검색
		$('#dealsearch').click(function(){
			let searchText = $('#searchtext').val();
			searchDeal("apt", searchText);
		});
		
		$('#compare-save').click(function(){
			let left_no = $('#card1-dealno').val();
			let right_no = $('#card2-dealno').val(); 
			compareSave(left_no, right_no);
		});		
		
		$('#range1').change(function(){
			console.log($('#range1').val());
			$("#range1_val").text($('#range1').val());
		});
		$('#range2').change(function(){
			console.log($('#range2').val());
			$("#range2_val").text($('#range2').val());
		});		
		$('#range3').change(function(){
			console.log($('#range3').val());
			$("#range3_val").text($('#range3').val());
		});		
		
	});
	
	function compareSave(left, right){
		let weight = $('#range1').val() + "" + $('#range2').val() + "" + $('#range3').val();
		$.ajax({
			type: "POST",
			url: "${root}/dealsearch/comparesave/" + left + "/" + right + "/" + weight,
			dataType: "json",
			success: function(object){
				console.log(object);
				if (object == "success")
					alert("저장에 성공했습니다. 비교 History 메뉴에서 확인하세요."); // 이거 왜 안뜨지...??
 			}
		});
	}
	
	function searchDeal(searchby, searchText){
		let type = ""
		
		if ($("input:checkbox[value='1']").is(":checked"))
			type += "1 ";
		if ($("input:checkbox[value='2']").is(":checked"))
			type += "2 ";
		if ($("input:checkbox[value='3']").is(":checked"))
			type += "3 ";
		if ($("input:checkbox[value='4']").is(":checked"))
			type += "4 ";
		
		type = $.trim(type);
		
		let weight = $('#range1').val() + "" + $('#range2').val() + "" + $('#range3').val();
		
		console.log("${root}/dealsearch/" + type + "/" + searchby + "/" + searchText + "/" + weight);
		
		$.ajax({
			type: "GET",
			url: "${root}/dealsearch/" + type + "/" + searchby + "/" + searchText + "/" + weight,
			dataType: "json",
			success: function(map){					
				console.log(map); // 가져온 map (array of object)								
				
				list = map.deals;
				infos = map.infos;
				
				infoSearch(infos); //infos에 담긴 마커 찍기
				//drawing_line();
				
				// 예전에 하던것처럼 tbody 밑에 td 엘리먼트 덕지덕지 붙여주는 방법으로는 dataTable 기능이 제대로 안 먹는다
				let table = $('#dataTable').DataTable();
				table.clear();
				
				$(list).each(function(index, element){ // 반드시 add 안에 배열 형태로 줘야 알아먹음....
					let aptlink = '<a href="#" onClick="viewDetail(' + this.no + ')">' + this.aptName + '</a>';
					let btn = '<button type="button" id="comparebtn' + this.no  + '" class="btn btn-secondary" disabled="true" onClick="compare(' + this.no + ')">비교하기</button>'
					table.row.add([this.no, this.dong, aptlink, this.dealAmount, this.type, this.score_avg, btn]);
				});
				table.order([5, 'desc']).draw(); // 기본적으로 점수기준 내림차순 정렬로 보여줌
				
				// 상세정보 보기 부분 초기화
				$("#detailcard > div").empty(); 
				$("#detailcard > ul").empty();
				$("#detailcard2 > div").empty(); 
				$("#detailcard2 > ul").empty();
				
				// compareChart 초기화. 0번 인덱스부터 2개 지운다 -> 다 지운다
				compareChartConfig.data.datasets.splice(0, 2);
				window.myRadar.update();
			}
		});
			
	}
	
	function viewDetail(no){
		let weight = $('#range1').val() + "" + $('#range2').val() + "" + $('#range3').val();
		
		// compareChart 초기화. 0번 인덱스부터 2개 지운다 -> 다 지운다
		compareChartConfig.data.datasets.splice(0, 2);
		window.myRadar.update();
		
		$.ajax({
			type: "GET",
			url: "${root}/dealsearch/detail/" + no + "/" + weight,
			dataType: "json",
			success: function(map){
				console.log(map); 
				
				deal = map.deal;
				info = map.info;
				
				infoSearchDetail(info);
				
				$("#detailcard > div").empty(); 
				$("#detailcard > div").append('<h5 class="card-title">' + deal.aptName + '</h5>');
				
				// 카드엔 안 뜨지만 필요한 정보들 hidden으로 두자
				$("#detailcard > div").append('<input type="hidden" id="card1-dealno" value="' + deal.no + '">');
				$("#detailcard > div").append('<button type="button" class="btn btn-primary" onClick="facilities(info)">편의시설 알아보기</button>');
				
				$("#detailcard > ul").empty();
				
				// 새로 왼쪽카드 정보 선택하면 오른쪽카드 정보는 초기화해주자
				$("#detailcard2 > div").empty(); 
				$("#detailcard2 > ul").empty();
			

				let li1 = $('<li class="list-group-item"/>').html("거래금액: <a href='#' onClick='graphTest(1)'>" + deal.dealAmount + "</a>");
				let li2 = $('<li class="list-group-item"/>').text("월세금액: " + "-");
				let li3 = $('<li class="list-group-item"/>').text("건축연도: " + deal.buildYear);
				let li4 = $('<li class="list-group-item"/>').text("전용면적: " + deal.area);
				let li5 = $('<li class="list-group-item"/>').text("거래일: " + deal.dealYear + "/" + deal.dealMonth + "/" + deal.dealDay);
				let li6 = $('<li class="list-group-item"/>').text("법정동: " + deal.dong);
				let li7 = $('<li class="list-group-item"/>').text("지번: " + deal.jibun);
				let li8 = $('<li class="list-group-item"/>').text("추천점수: " + deal.score_avg);
			
				$("#detailcard > ul").append(li1, li2, li3, li4, li5, li6, li7, li8);
				
				// 비교버튼 활성화
				$(".btn-secondary").removeClass('btn-secondary').addClass('btn-warning').attr('disabled', false);
				// 지금 선택한 항목은 빼고.
				$("#comparebtn" + deal.no).removeClass('btn-warning').addClass('btn-secondary').attr('disabled', true);
				
				// 왼쪽만 그래프 그리기
				compareRadarGraphAdd(deal, 'rgb(51, 51, 204)', 'rgba(51, 51, 204, 0.2)');
				
				/*여기에 위도 경도 추가 */
				
			}
		});

	}


	//왼쪽 dong, aptname으로 houseinfo의 위도 경도 추출하는 함수
	 function getData(dong, aptName,info) {
		  return new Promise(function(resolve, reject) {
		    $.get(	"${root}/dealsearch/detail_info/"+dong+"/"+aptName, function(response) {
		      if (response) {
		        resolve(response);
		      }
		      reject(new Error("데이터 가져오기 실패"));
		    })
 		    .then(function(data) {
 		    	infoSearchCompare(data,info);
			})/* 
			.catch(function(err) {
		  		console.error(err); 
			});  */
		  });
		} 
	
	function compare(no){
		//alert(no);
		
		// 차트의 1번 인덱스 데이터 제거. 즉 현재 비교중인 거 있음 지운다.
		compareChartConfig.data.datasets.splice(1, 1);
		window.myRadar.update();
		
		let weight = $('#range1').val() + "" + $('#range2').val() + "" + $('#range3').val();
		$.ajax({
			type: "GET",
			url: "${root}/dealsearch/detail/" + no + "/" + weight,
			dataType: "json",
			success: function(object){
				console.log(object);  
				deal = object.deal;
				info = object.info;				
				
				$("#detailcard2 > div").empty(); 
				$("#detailcard2 > div").append('<h5 class="card-title">' + deal.aptName + '</h5>')
				
				$("#detailcard2 > div").append('<input type="hidden" id="card2-dealno" value="' + deal.no + '">');
				
				$("#detailcard2 > ul").empty(); 
				let li1 = $('<li class="list-group-item"/>').html("거래금액: <a href='#' onClick='graphTest(2)'>" + deal.dealAmount + "</a>");
				let li2 = $('<li class="list-group-item"/>').text("월세금액: " + "-");
				let li3 = $('<li class="list-group-item"/>').text("건축연도: " + deal.buildYear);
				let li4 = $('<li class="list-group-item"/>').text("전용면적: " + deal.area);
				let li5 = $('<li class="list-group-item"/>').text("거래일: " + deal.dealYear + "/" + deal.dealMonth + "/" + deal.dealDay);
				let li6 = $('<li class="list-group-item"/>').text("법정동: " + deal.dong);
				let li7 = $('<li class="list-group-item"/>').text("지번: " + deal.jibun);
				let li8 = $('<li class="list-group-item"/>').text("추천점수: " + deal.score_avg);
				
				//$("#detailcard > ul").append(li1, li2, li3, li4, li5, li6, li7, li8);
				
				// 왼쪽 박스에 써있는 정보들 가져오기
				let left1 = $("#detailcard > ul > li:nth-child(1)").text().split(":")[1].trim().replace(",", "");
				let left2 = $("#detailcard > ul > li:nth-child(2)").text().split(":")[1].trim();
				let left3 = $("#detailcard > ul > li:nth-child(3)").text().split(":")[1].trim();
				let left4 = $("#detailcard > ul > li:nth-child(4)").text().split(":")[1].trim();
				let left5 = $("#detailcard > ul > li:nth-child(8)").text().split(":")[1].trim();
				
				// 오른쪽 박스 정보들 가공처리
				let right1 = deal.dealAmount.trim().replace(",", "");
				let right2;
				if (deal.rentMoney != null)
					right2 = deal.rentMoney.trim().replace(",", "");
				
				let right3 = deal.buildYear;
				let right4 = deal.area;
				let right5 = deal.score_avg;

				// 비교 & 색깔 칠하기
				compare_coloring($("#detailcard > ul > li:nth-child(1)"), li1, left1, right1, 0);
				if (deal.rentMoney != null)
					compare_coloring($("#detailcard > ul > li:nth-child(2)"), li2, left2, right2, 0);
				compare_coloring($("#detailcard > ul > li:nth-child(3)"), li3, left3, right3, 1);
				compare_coloring($("#detailcard > ul > li:nth-child(4)"), li4, left4, right4, 1);
				compare_coloring($("#detailcard > ul > li:nth-child(8)"), li8, left5, right5, 1);
				
				$("#detailcard2 > ul").append(li1, li2, li3, li4, li5, li6, li7, li8);
			
				let data_aptname = $("#detailcard > div > h5").text().trim();
				let data_dong= $("#detailcard > ul > li:nth-child(6)").text().split(":")[1].trim();
				
				getData(data_dong,data_aptname,info);
				window.scrollTo(0,0);
				
				$("#compare-save").removeClass('btn-dark').addClass('btn-success').attr('disabled', false);
				
				compareRadarGraphAdd(deal, 'rgb(230, 115, 0)', 'rgba(230, 115, 0, 0.2)');
			}
		});

	}
	
	function compare_coloring(leftelem, rightelem, leftval, rightval, flag){
		let diff = rightval - leftval;
		
		if (diff % 1 !== 0){ // 정수가 아닌 경우 (면적)
			diff = diff.toFixed(2);
		}
		
		// 어떤 요소는 높을수록 좋은거고 어떤 요소는 낮을수록 좋은 것
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
	
	function graphTest(type){
		// 비동기 요청 보내서 아파트이름, 동이름, 면적 같은 데이터들 가져오기 -> 모달창 띄우기 -> 그래프 띄우기
		// type=1: 왼쪽 카드에서 클릭시, type=2: 오른쪽 카드에서 클릭시
		let aptName, dong, area;
		if (type == 1){
			aptName = $("#detailcard > div > h5").text();
			dong = $("#detailcard > ul > li:nth-child(6)").text().split(":")[1];
			area = $("#detailcard > ul > li:nth-child(4)").text().split(":")[1];
		}
		else {
			aptName = $("#detailcard2 > div > h5").text();
			dong = $("#detailcard2 > ul > li:nth-child(6)").text().split(":")[1].split(" (")[0];
			area = $("#detailcard2 > ul > li:nth-child(4)").text().split(":")[1].split(" (")[0];
		}
		
		// 이렇게 쿼리스트링을 덕지덕지 붙이는게 맞는 걸까? 그렇다고 GET방식에 body를 넣어서 보내면 또 안되고...
		$.ajax({
			type: "GET",
			url: "${root}/dealsearch/drawgraph/" + dong + "/" + aptName + "/" + area,
			success: function(list){
				//alert("success");
				console.log(list);
				$(".modal-body > p").text(dong + " / " + aptName + " / 전용면적 " + area + " 의 실거래가 변동 그래프입니다.");
				graphDraw(list);
			}
		});
	}
	
	var myChart = null; // 차트를 전역변수로 두고, 이미 있으면 destroy 호출해줘야 했다. 안그러면 기존 데이터가 자꾸 남아있음
	var myChart2 = null;
	
	function graphDraw(list){
		$("#myModal").modal();
		
		var ctx = document.getElementById('myChart').getContext('2d');
		
		let x_labels = [];
		let datas = [];
		
		$(list).each(function(index, element){
			let dealDate = this.dealYear + "/" + this.dealMonth + "/" + this.dealDay;
			x_labels.push(dealDate);
			datas.push(this.dealAmount.replace(",", ""));
		});
		
		if (myChart != null){
			console.log("차트 삭제");
			myChart.destroy();
		}
		
		myChart = new Chart(ctx, {
		    type: 'line',
		    data: {		    	
		        labels: x_labels,
		        datasets: [{
		        	label: "실거래가",
		            data: datas,
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255, 99, 132, 1)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: false
		                }
		            }]
		        }
		    }
		});
	}
	
	function compareRadarGraphAdd(deal, color, bgcolor){
		var newDataset = {
			label: deal.aptName,
			borderColor: color,
			backgroundColor: bgcolor,
			pointBackgroundColor: color,
			data: [deal.score_dealAmount, deal.score_buildYear, deal.score_area]
		};
		compareChartConfig.data.datasets.push(newDataset);
		window.myRadar.update();
	}
	
	
	
</script>


</head>
<body class="sb-nav-fixed">
	<%@include file="menubar.jsp"%>
	<div id="layoutSidenav_content">
		<div class="row cover"><!--지도/거래 비교 -->
			<div class="col-md-6 col-xs-12 cover-i2 card" id = map><!--지도-->
	<!-- 		<div class ="card" id="map"></div> -->
			</div>
			<div class="col-md-6 col-xs-12 row"><!--거래 비교-->
			
				<div id="detailcard" class="card col-md-5 col-sm-5 cover-i2">
				  <header class="row cover">						  
				   <img class="card-img-top pic" src="img/blue.png"style="witdh:2px;height:35px" alt="image"> 
				
				  	<strong>선택한 거래내역 상세정보</strong>
				  </header>
				  <div id="cardtitle1" class="card-body">
				    <h5 class="card-title">${deal.aptName}</h5>
				  	검색을 통해 상세정보를 확인하고 싶은 거래내역을 클릭해 주세요!
				  </div>
				  <ul class="list-group list-group-flush">
				    
				  </ul>
				</div>
				
				<div id="detailcard2" class="card col-md-5 col-sm-5 cover-i2">
				<header class="row cover">
				   <img class="card-img-top pic" src="img/green.png"style="witdh:2px;height:35px" alt="image"> 
			
				   <strong>비교대상 거래내역 상세정보</strong>
				  </header>
				   
				   
				  <div id="cardtitle2" class="card-body">
				    <h5 class="card-title">${deal.aptName}</h5>
				     비교하고자 하는 거래내역의 상세정보를 확인할 수 있습니다. '비교하기' 버튼 클릭 시 활성화됩니다.
				  </div>
				  <ul class="list-group list-group-flush">
				       
				  </ul>
				</div>						
	
			</div>
			</div> <!--지도/거래 비교 끝 -->

		<div class="row cover"> <!-- 검색 조건-->  
		<div class="cover-i2 col-md-12">
		<form>
		<!-- 
		<div class="form-group row">
			<div class="col-md-3">
			<canvas id="compareChart" width="100" height="100"></canvas>
			</div>
			<div class="col-md-6"></div>
			<div class="col-md-2"><button id="compare-save" class="btn btn-dark" disabled="true">비교데이터 저장하기</button></div>
		</div>
		-->
		
		<div class="form-group row">
			<div class="col-md-4 slidecontainer">
			    <label class="col-md-12"><strong>검색 우선순위 (가중치) 설정:</strong></label>
			     <label class="col-md-6">가격:</label>
				 <input class="slider" type="range" min="1" max="5" value="3" id="range1">
				 <label id="range1_val">3</label><br>
				 <label class="col-md-6">건축연도:</label>
				 <input type="range" min="1" max="5" value="3" class="slider" id="range2">
				 <label id="range2_val">3</label><br>
				 <label class="col-md-6">면적:</label>
				 <input type="range" min="1" max="5" value="3" class="slider" id="range3">
				 <label id="range3_val">3</label><br>
				 
				<div class="form-group row">
				    <label class="col-md-12 col-form-label"><strong>법정동으로 검색:</strong></label>
				    <div class="col-md-6">
				      	<select id="gu-select" class="custom-select">
					  
						</select>
				    </div>
				    <div class="col-md-6">
				      	<select id="dong-select" class="custom-select">
					  		<option selected>[동선택]</option>
						</select>
				    </div>
				</div>
				 
				<div class="form-group row">
				    <label class="col-md-12 col-sm-12 col-form-label"><strong>아파트명으로 검색:</strong></label>
				    <div class="col-md-6 col-sm-8">
				      <input type="text" class="form-control" id="searchtext">
				    </div>
				  	<div class="col-md-4 col-sm-4">
				       <button type="button" id="dealsearch" class="btn btn-primary">검색</button>
				    </div>
				  </div>

				 
			</div>
			<div class="col-md-2"></div>
			<div class="col-md-3">
				<label>추천점수 기준별 비교 그래프</label>
				 <canvas id="compareChart" width="100" height="100"></canvas>
			</div>
		    <div class="col-md-2">
		      	<button id="compare-save" class="btn btn-dark" disabled="true">비교데이터 저장하기</button>
		    </div>
		</div>
		
		<!-- 
		<div class="form-group row">
		    <label class="col-md-2 col-form-label"><strong>법정동으로 검색:</strong></label>
		    <div class="col-md-2">
		      	<select id="gu-select" class="custom-select">
			  
				</select>
		    </div>
		    <div class="col-md-2">
		      	<select id="dong-select" class="custom-select">
			  		<option selected>[동선택]</option>
				</select>
		    </div>
		</div>
		
		  <div class="form-group row">
		    <label class="col-md-2 col-sm-2 col-form-label"><strong>아파트명으로 검색:</strong></label>
		    <div class="col-md-3 col-sm-5">
		      <input type="text" class="form-control" id="searchtext">
		    </div>
		  	<div class="col-md-2 col-sm-2">
		       <button type="button" id="dealsearch" class="btn btn-primary">검색</button>
		    </div>
		  </div>
		  -->

<!-- 
		  <fieldset class="form-group">		    	    
		    <div class="row">
		      <legend class="col-form-label col-md-2 pt-0">검색 기준</legend>
 		      <div class="col-sm-10"> 
		        <div class="form-check col-md-2">
		          <input class="form-check-input" type="radio" name="searchby" id="searchby1" value="all" ${selectedall}>
		          <label class="form-check-label" for="searchby1">
		            	전체
		          </label>
		        </div>
		        <div class="form-check col-md-2">
		          <input class="form-check-input" type="radio" name="searchby" id="searchby2" value="dong" ${selecteddong}>
		          <label class="form-check-label" for="searchby2">
		            	동 기준
		          </label>
		        </div>
		        <div class="form-check col-md-2">
		          <input class="form-check-input" type="radio" name="searchby" id="searchby3" value="apt" ${selectedapt}>
		          <label class="form-check-label" for="searchby3">
		         		이름 기준
		          </label>
		        </div> 
		      </div>
		    </div>
		  </fieldset>
-->
		  
		  <div class="form-group row">
		    <div class="col-md-2"><strong>거래 종류:</strong></div>
		      <div class="form-check col-md-2 ">
		        <input class="form-check-input" type="checkbox" name="type" value="1" checked>
		        <label class="form-check-label" for="gridCheck1">
		          아파트 매매
		        </label>
		      </div>
		    <div class="form-check col-md-2">
		        <input class="form-check-input" type="checkbox" name="type" value="2">
		        <label class="form-check-label" for="gridCheck2">
		          아파트 전월세
		        </label>
		      </div>
		    <div class="form-check col-md-2">
		        <input class="form-check-input" type="checkbox" name="type" value="3">
		        <label class="form-check-label" for="gridCheck3">
		          연립/주택 매매
		        </label>
		      </div>
		    <div class="form-check col-md-2">
		        <input class="form-check-input" type="checkbox" name="type" value="4">
		        <label class="form-check-label" for="gridCheck4">
		          연립/주택 전월세
		        </label>
		  </div> 
		  </div>


<!-- 
		  <div class = "row">
		  		<label class="col-md-2"><input type="radio" name="orderby" value="no"
			${byno}>거래번호로</label> <label  class="col-md-2"><input type="radio"
			name="orderby" value="dong" ${bydong}>법정동으로</label> <label  class="col-md-2"><input
			type="radio" name="orderby" value="apt" ${byapt}>아파트 이름으로</label> <label  class="col-md-2"><input
			type="radio" name="orderby" value="dealAmount" ${bydealAmount}>거래금액으로</label>
		<input type="submit" class="btn btn-primary col-md-1 col-sm-1" value="정렬"
			formaction="${root}/sort">
			</div>
-->
	 
		</form> </div>
		</div> <!--검색조건 끝 -->
		
		<div class="row cover">   <!--리스트-->	 
                <div class="card col-md-12">
                   <div class="card-header"><i class="fas fa-table mr-1"></i>거래 내역 목록</div>
                   <div class="card-body">
                       <div class="table-responsive">
                           <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                               <thead>
                                   <tr>
                                       <th>거래 번호</th>
                                       <th>법정동</th>
                                       <th>아파트 이름</th>
                                       <th>거래 금액</th>
                                       <th>거래 종류</th>
                                       <th>추천 점수</th>
                                       <th>(비교버튼)</th>
                                   </tr>
                               </thead>
                               <tbody>
<!--  
			<c:forEach items="${deals}" var="deal">
				<tr>
					<td>${deal.no}</td>
					<td>${deal.dong}</td>
					<td><a href="#" onClick="viewDetail(${deal.no})">${deal.aptName}</a></td>
					<td>${deal.dealAmount}</td>
					<td>${deal.type}</td>
					<td><button type="button" id="comparebtn${deal.no}" class="btn btn-secondary" onClick="compare(${deal.no})" disabled="true">비교하기</button></td>
					
				</tr>
			</c:forEach>
-->
                               </tbody>
                           </table>
                       </div>
                   </div>
               </div>
    
		</div>		 <!--리스트 끝 --> 
	
		
      <!-- 모달창 파트 -->
		<div class="modal fade" id="myModal" role="dialog">
    		<div class="modal-dialog">

      		<div class="modal-content">
		        <div class="modal-header">
		         <h4 class="modal-title">실거래가 변동 추이</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		          <p>(아파트이름) 의 실거래가 변동 그래프입니다.</p>
		          <canvas id="myChart" width="400" height="400"></canvas>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
	      	</div>
	      
	  	  </div>
	  	</div>
		
		
		
	<!-- 지도 모달 창-->
		<div class="modal fade" id="mapmyModal" role="dialog" >
    		<div class="modal-dialog">

      		<div class="modal-content">
		        <div class="modal-header">
		         <h4 class="modal-title">편의 시설 검색</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body" >
	
		        
  	<div class="map_wrap" style="width:420px;height:480px"> 
  <div id="map2" style="align:center;width:100%;height:100%;position:relative;overflow:hidden;"></div>
  
 <!-- <div id="map2" class = "map"  "></div>
  -->   <ul id="category">
        <li id="BK9" data-order="0"> 
            <span class="category_bg bank"></span>
            은행
        </li>       
        <li id="MT1" data-order="1"> 
            <span class="category_bg mart"></span>
            마트
        </li>  
        <li id="PM9" data-order="2"> 
            <span class="category_bg pharmacy"></span>
            약국
        </li>  
        <li id="OL7" data-order="3"> 
            <span class="category_bg oil"></span>
            주유소
        </li>  
        <li id="CE7" data-order="4"> 
            <span class="category_bg cafe"></span>
            카페
        </li>  
        <li id="CS2" data-order="5"> 
            <span class="category_bg store"></span>
            편의점
        </li>      
    </ul>
</div>
		         
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
	      	</div>
	      
	  	  </div>
	  	</div>
	
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
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=95b12d9b1cf60cf2a3b48c71ca77e3d8&libraries=services,clusterer,drawing"></script>
		<script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>

		<script src="js/map.js"></script>
		<script>
		var container = document.getElementById('map');	
		var options = {
			//지도 중심 좌표
			center : new kakao.maps.LatLng(37.549693, 127.000847), //서울 위도 경도
			//확대 레벨
			level : 10
		};
		//지도 생성
		var map = new kakao.maps.Map(container, options);		

		</script>
		<script src="js/map2.js"></script>
	</body>
</html>