<%@page import="java.util.Comparator"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//06.23
	//디렉토리 탐색
	String path = application.getRealPath("/example/images");

	File dir = new File(path);
	
	File[] list = dir.listFiles();
	
	//System.out.println(Arrays.toString(list));
	/* [
	 C:\class\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPTest\example\images\back.jpg,
	 C:\class\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPTest\example\images\catty21.png,
	 C:\class\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPTest\example\images\dog03.jpg,
	 C:\class\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPTest\example\images\rect_icon10.png
	 ] */
	
	
	//System.out.println(list[0].getName()); //back.jpg
	
	//업로드시간 순으로 정렬 
	//먼저 업로드시간 가져올 수 있는지 확인
	//System.out.println(list[0].lastModified()); //1655950829226
	
	//tick값을 %tF %tT로 보기
	Calendar temp = Calendar.getInstance();
	temp.setTimeInMillis(list[0].lastModified());
	//System.out.println(list[0].getName());
	//System.out.printf("%tF %tT\n", temp, temp);
	
	//cat01.jpg
	//2022-06-23 11:20:29
	
	/* Arrays.sort(list, (a, b) -> {
		return Long.compare(a.lastModified(), b.lastModified());
		
		//음수 or 양수
		//a와 b중에 누가 업로드 시간 틱값이 큰지, 작은지 확인
		
	}); */
	
	Arrays.sort(list, new Comparator<File>() {
		public int compare(File a, File b) {
			return Long.compare(a.lastModified(), b.lastModified());
		}
	});
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/example/inc/asset.jsp" %>
<style>
	
	#list {
		width: 800px;
		margin-top: 20px;
		margin-bottom: 50px 
		/* outline: 10px solid black; */
	}
	
	#list > div {
		float: left;
		border: 1px solid #999;
		margin: 15px;
		width: 126px;
		height: 126px;
		background-size: cover;
		background-repeat: no-repeat;
		background-position: center center;
		
		/* 밑에 span처리 위해서 추가 */
		position: relative;
		left: 0;
		top: 0;
		/* 얘를 부모로 or flex이용 */
		
	}
	
	#list > div > span {
		font-size: 1.5em;
		position: absolute;
		right: 5px;
		top: 0;
		cursor: pointer;
		display: none;
		/* 평상시엔 감추고 */
		
		
	}
	
	/* img에 마우스 올렸을때만 보이게 */
	#list > div:hover > span {
		display: inline;
	}
	
	
	#list::after {
		content: '';
		display: block;
		clear: both;
	}
	
/* 	#list > div > img {
		width: 126px;
		height: 126px;	
	} */
	
	.modal-body > img {
		display: block;
		margin: 15px auto;
		max-width: 560px;
		
		/* 
			width: ; 		> 고정 크기
			max-width: ;	> 작을땐 객체 크기, 클땐 최대 지정
			min-width: ; 	> 
		 */
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
	
	<!-- ex20_file_form.jsp -->
	<div class="container">
		<h1>Image Gallery</h1>
		
		<div id="list">
		
		<!-- div는 블럭태그 블럭태그는 내용물에 따라 높이가 결정됨.
			float를 주면 포지션 absolute때랑 같아짐 > 자신의 영역이 사라짐.
			그래서 자식에게 float를 주면 부모입장에선 자식이 없는것과 같음
			(자식의 영역이 어느정도인지를 부모는 모름 > 흔적없이 자식이 나가는게 float)
			float를 넣은 자식들 밑에 그냥 자식을 넣으면 그제야 모든 자식의 영역이 인식이 됨.
			(하나라도 자신의 영역을 뚜렷하게 나타내면 float 자식까지도 영역이 나타남.)
			근데 일반자식이 float자식 밑에 있을때만 ! 위나 중간에 있을땐 인식x -->
			
			<!-- <div><img src="images/rect_icon10.png"></div>  x 10개 있었음-->
			
			<!-- <div style="clear:both;float:none;"></div> -->
			<!-- 그래서 얘를 넣은 것 > float가 아닌 일반 자식을 넣어서 전체 자식을 모두 인식할 수 있게 -->
			<!-- 근데 위에서 #list > div 전체에 float을 줬으니까 float:none;도 줌 
				 하지만 여기엔 테두리를 주면 안되니까 주석하고 위에서 after-->
				 
				 
			<% for (File img : list) { %>
			
			<%-- <div><img src="images/<%= img.getName() %>"></div> --%>
			
			<div style="background-image:url(images/<%= img.getName() %>);" data-toggle="modal" data-target="#exampleModal" onclick="showImage('<%= img.getName() %>');">
			
				<span title="delete" onclick="deleteImage('<%= img.getName() %>');">&times;</span>			
			</div>
			
			<% } %>	
			
		</div>
		
		<form  method="POST" action="ex20_file_ok.jsp" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<th>이미지</th>
				<td><input type="file" name="attach" required></td>
			</tr>
		</table>
		
		<div>
			<input type="submit" value=" 이미지 업로드 "
				class="btn btn-success">
		</div>
		
		</form>
		
	</div>
	
	<!-- https://getbootstrap.com/docs/4.6/components/modal/  > Live demo -->
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-x1">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <img src="images/cat01.jpg">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
	<script>
	

		function showImage(img) {
			//alert(img); //파일명 잘뜨는지 확인
			
			$('.modal-body > img').attr('src', 'images/' + img);
			$('#exampleModalLabel').text(img);
			
		}
		
		
		function deleteImage(img) {
			//alert(img);
			
			
			
			if (confirm('delete?')) {
			location.href = 'ex20_file_delete.jsp?filename=' + img;
			}
			
			event.stopPropagation();
			//버블링 막는것과 비슷 (여기선 캔슬버블 안먹어서 이걸로)
			
		}
	
	
	</script>

</body>
</html>