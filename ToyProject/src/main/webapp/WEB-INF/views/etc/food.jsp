<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Toy Project</title>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=893acc1129728a3b9555fa0a4c144eae"></script>
<link rel="stylesheet" href="/toy/asset/css/rateit.css" />

<style>
   #map {
		width: 500px;
		height: 400px;
	}
	
	.table .table {
		width: 250px;
	}
   
</style>
</head>
<body>

	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
			<h2>맛집 즐겨찾기</h2>
			
			<table class="table table-bordered">
				<tr>
					<td><div id="map"></div></td>
					<td>
						<table class="table table-bordered">
							<c:forEach items="${list}" var="dto">
							<tr>
								<td>
									<span class="${dto.icon}"></span> 
									<a href="#!" onclick="selFood(${dto.lat}, ${dto.lng}, ${dto.category});">${dto.name}</a>(<span class="rateit" data-rateit-resetable="false" data-rateit-readonly="true"></span>)
								</td>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
			
			<div class="btns">
				<input type="button" value="등록하기" class="btn btn-primary"
					onclick="location.href='/toy/etc/addfood.do';">
			</div>
			
		</section>
	</main>
	
	
	<script src="/toy/asset/js/jquery.rateit.js"></script>
	<script>
		var container = document.getElementById('map');
		
		var options = {
			center: new kakao.maps.LatLng(37.499321, 127.033220),
			level: 3
		};
	
		var map = new kakao.maps.Map(container, options);
		
		
		//rateit
		$('.rateit').ready(function() {
			
			<c:forEach items="${list}" var="dto" varStatus="status">
			$('.rateit').eq(${status.index}).rateit('value', '${dto.star}');
			</c:forEach>
			
		});
		
		
		//마커 띄우기(모든 마커가 동시에)
		<%--
		<c:forEach items="${list}" var="dto" varStatus="status">
		let m${status.index} = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(${dto.lat}, ${dto.lng})
		});
		

		m${status.index}.setMap(map);
		</c:forEach>	
		--%>
		
		
		let m = null;
		
		
		//위치를 알고싶은 식당을 클릭하면 그 위치가 정중앙으로 이동 
		//+ 식당을 클릭해서 지도가 이동될때(식당이 정중앙으로 올때) 그 식당 마커만 보이게 하기
		function selFood(lat, lng) {
			//alert(lat + ',' + lng);
			
			map.panTo(new kakao.maps.LatLng(lat, lng));
			
			
			if (m != null) {
				m.setMap(null);
			}
			
			/* m = new kakao.maps.Marker({
				position:new kakao.maps.LatLng(lat, lng)
			});
			
			m.setMap(map);  */
			
			
			//마커 이미지 바꾸기 > 나는 기본이 좋아서 다시 기본으로..
			//근데 이거 왜 마커 이미지 안보임?
			let imageSrc = '/toy/pic/m' + category + '.png', 
			    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기
			    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		      
			let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치

			// 마커를 생성
			m = new kakao.maps.Marker({
			    position: markerPosition, 
			    image: markerImage // 마커이미지 설정 
			});
		
		    
			m.setMap(map); 
			
			
	}
		
		
		
	</script>
</body>
</html>


















