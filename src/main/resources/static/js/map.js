function infoSearchDetail(info) {
	/*$("#category").hide();
	*/
	// 마커가 표시될 위치
	var markerPosition = new kakao.maps.LatLng(info.lat, info.lng);

	// 마커를 생성
	var marker = new kakao.maps.Marker({
		position : markerPosition
	});

	var mapContainer = document.getElementById('map');
	var mapOption = {
		//지도 중심 좌표
		center : new kakao.maps.LatLng(info.lat, info.lng),
		//확대 레벨
		level : 4
	};

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	var positions = [];

/*	var imageSrc = "img/qblue.png";
	imageSize = new kakao.maps.Size(30, 31);
	imageOption = {
		offset : new kakao.maps.Point(27, 69)
	}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
			imageOption), markerPosition = new kakao.maps.LatLng(info.lat,
			info.lng);

	// 우 마커가 표시될 위치
	var markerPosition = new kakao.maps.LatLng(info.lat, info.lng);

	// 우 마커를 생성
	var marker = new kakao.maps.Marker({
		position : markerPosition,
		image : markerImage
	});
*/
	// 마커 표시 설정
	marker.setMap(map);

	// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
	var iwContent = '<div style="padding:1px;">' + info.aptName + '</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
		content : iwContent
	});

	// 마커에 마우스오버 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseover', function() {
		// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
		infowindow.open(map, marker);
	});

	// 마커에 마우스아웃 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseout', function() {
		// 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
		infowindow.close();
	});

}

//마커 두개 띄우기
function infoSearchCompare(leftinfo, info) {
/*	$("#category").hide();*/
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(info.lat, info.lng), // 지도의 중심좌표
		level : 5
	// 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	var positions = [];

	//우마커 이미지 옵션
	//var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var imageSrc = "img/green.png";
	imageSize = new kakao.maps.Size(24, 35);
	imageOption = {
		offset : new kakao.maps.Point(27, 69)
	};
	// 우마커 이미지 생성
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
			imageOption), markerPosition = new kakao.maps.LatLng(info.lat,
			info.lng);

	// 우 마커가 표시될 위치
	var markerPosition = new kakao.maps.LatLng(info.lat, info.lng);

	// 우 마커 생성
	var marker = new kakao.maps.Marker({
		position : markerPosition,
		image : markerImage
	});

	//맵에 띄우기
	marker.setMap(map);

	// 우마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
	var iwContent = '<div style="padding:1px;">' + info.aptName + '</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
		content : iwContent
	});

	// 우마커에 마우스오버 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseover', function() {
		// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
		infowindow.open(map, marker);
	});

	// 우마커에 마우스아웃 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseout', function() {
		// 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
		infowindow.close();
	});

	//좌 마커가 표시될 위치
	var leftmarkerPosition = new kakao.maps.LatLng(leftinfo.lat, leftinfo.lng);

	/*//좌 마커 이미지 옵션
	var leftimageSrc = "img/qblue.png";
	imageSize = new kakao.maps.Size(30, 31);
	imageOption = {
		offset : new kakao.maps.Point(27, 69)
	};

	// 좌 마커이미지를 생성합니다
	var leftmarkerImage = new kakao.maps.MarkerImage(leftimageSrc, imageSize,
			imageOption), leftmarkerPosition = new kakao.maps.LatLng(
			leftinfo.lat, leftinfo.lng);
*/
	// 좌 마커를 생성
	var leftmarker = new kakao.maps.Marker({
		position : leftmarkerPosition,
		//image : leftmarkerImage
	});

	//좌 마커 화면에 띄우기
	leftmarker.setMap(map);

	// 좌 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
	var leftiwContent = '<div style="padding:1px;">' + leftinfo.aptName
			+ '</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

	// 인포윈도우를 생성합니다
	var leftinfowindow = new kakao.maps.InfoWindow({
		content : leftiwContent
	});

	// 좌마커에 마우스오버 이벤트를 등록합니다
	kakao.maps.event.addListener(leftmarker, 'mouseover', function() {
		// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
		leftinfowindow.open(map, leftmarker);
	});

	// 좌마커에 마우스아웃 이벤트를 등록합니다
	kakao.maps.event.addListener(leftmarker, 'mouseout', function() {
		// 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
		leftinfowindow.close();
	});

}
//검색한 리스트 위치 지도에 표시
function infoSearch(infos) {

/*	$("#category").hide();
*/	
	console.log(infos);

	var container = document.getElementById('map');

	var options = {
		//지도 중심 좌표
		center : new kakao.maps.LatLng(infos[0].lat, infos[0].lng),
		//확대 레벨
		level : 6
	};

	//지도 생성
	var map = new kakao.maps.Map(container, options);
	var positions = [];

	if (infos.length != 0) {
		for (var i = 1; i < infos.length; i++) {
			positions.push({
				title : infos[i].aptName,
				content : infos[i].aptName,
				latlng : new kakao.maps.LatLng(infos[i].lat, infos[i].lng)

			});
		}
	} else {
		console.log("error! no infos")
	}

	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	//var imageSrc = "img/qyellow.png";
	for (var i = 0; i < positions.length; i++) {

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);

		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			map : map, // 마커를 표시할 지도
			position : positions[i].latlng, // 마커를 표시할 위치
			title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			image : markerImage
		// 마커 이미지 
		});

		// 마커에 표시할 인포윈도우를 생성합니다 
		var infowindow = new kakao.maps.InfoWindow({
			content : positions[i].content
		// 인포윈도우에 표시할 내용
		});

		// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		// 이벤트 리스너로는 클로저를 만들어 등록합니다 
		// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map,
				marker, infowindow));
		kakao.maps.event.addListener(marker, 'mouseout',
				makeOutListener(infowindow));

/*		kakao.maps.event.addListener(marker, 'click', function() {
			viewDetail(i);
		});*/
	}

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
		return function() {
			infowindow.open(map, marker);
		};
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
		return function() {
			infowindow.close();
		};
	}
}
