<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Gallery</title>
<%@ include file="/gallery/inc/asset.jsp" %>
<style>

	.container {
		width: 810px;
		margin-bottom: 100px;
	}
	
	#list {
		width: 800px;
		margin-top: 20px;
		margin-bottom: 0px;
	}
	
	#list > div {
		float: left;
		border: 1px solid #999;
		margin: 15px;
		margin-bottom: 50px;
		width: 126px;
		height: 126px;
		background-size: cover;
		background-repeat: no-repeat;
		background-position: center center;
		position: relative;
		left: 0;
		top: 0;
	}
	
	#list > div > span {
		font-size: 1.5em;
		position: absolute;
		right: 6px;
		top: 0;
		cursor: pointer;
		display: none;
	}
	
	#list > div > .title {
		position: absolute;
		font-size: 12px;
		left: -1px;
		top: 130px;
		padding-left: 5px;
		width: 126px;
		text-align: center;
	}
	
	#list > div:hover > span {
		display: inline;
	}
	
	#list::after {
		content: '';
		display: block;
		clear: both;
	}	
	
	.modal-body > img {
		display: block;
		margin: 15px auto;
		max-width: 560px;
	}
	
	
	#exampleModal .modal-dialog {
       -webkit-transform: translate(0,-50%);
       -o-transform: translate(0,-50%);
       transform: translate(0,-50%);
       top: 50%;
       margin: 0 auto;
   }
</style>
</head>
<body>

	<!-- list.jsp -->
	<div class="container">
		<h1>Image Gallery <small>List</small></h1>
		
		<div id="list">
		
			<div style="background-image:url(images/rect_icon10.png);" data-toggle="modal" data-target="#exampleModal" onclick="showImage('rect_icon10.png', '시계 아이콘', '2022-06-24 12:30:00');">
				<span title="delete" onclick="deleteImage('rect_icon10.png');">&times;</span>
				<div class="title">시계 아이콘</div>
			</div>
			
			<div style="background-image:url(images/puzzle.png);" data-toggle="modal" data-target="#exampleModal" onclick="showImage('puzzle.png', '날아라 시바!!', '2022-06-24 12:30:00');">
				<span title="delete" onclick="deleteImage('puzzle.png');">&times;</span>
				<div class="title">날아라 시바!!</div>
			</div>
			
			<div style="background-image:url(images/placeimg_500_200_people.jpg);" data-toggle="modal" data-target="#exampleModal" onclick="showImage('placeimg_500_200_people.jpg', '바탕 화면', '2022-06-24 12:30:00');">
				<span title="delete" onclick="deleteImage('placeimg_500_200_people.jpg');">&times;</span>
				<div class="title">바탕 화면</div>
			</div>
				
		</div>

		<input type="button" value=" 이미지 업로드 "
				class="btn btn-success" onclick="location.href='add.jsp';">
					

	</div>
	
	
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel"><span></span><span style="float:right; color: #999; margin-top: 5px; font-size: 12px;"></span></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	        </button>
	      </div>
	      <div class="modal-body">
	      	<img src="images/1.png">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
	<script>
	
		function showImage(img, title, regdate) {
			//alert(img);
			
			$('.modal-body > img').attr('src', 'images/' + img);
			$('#exampleModalLabel > span').eq(0).text(title + '(' + img + ')');
			$('#exampleModalLabel > span').eq(1).text(regdate);
			
		}
		
		function deleteImage(img) {
			//alert(img);
						
			if (confirm('delete?')) { 
				location.href = 'delok.jsp';
			}
			
			event.stopPropagation();
			
		}
	
	</script>

</body>
</html>
















