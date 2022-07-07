<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Toy Project</title>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<link rel="stylesheet" href="/toy/asset/css/tagify.css" />
<script src="/toy/asset/js/jQuery.tagify.min.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=893acc1129728a3b9555fa0a4c144eae"></script>

<style>

	tr:last-child form {
		margin-right: 5px;
	}
	
	
	<c:if test="${not empty dto.goodbad}">
	#btngood, #btnbad {
		opacity: .6;
	}
	</c:if>
	
	<c:if test="${empty dto.goodbad}">
	#btngood, #btnbad {
		opacity: 1;
	}
	</c:if>
	
	//07.04 GPS 추가	
	<c:if test="${not empty lat}">
	#map {
		width: 100%;
		height: 400px;
	}
	</c:if>
	
</style>
</head>
<body>

	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
			
			<h2>Board</h2>
			
			
			<table class="table table-bordered vertical">
				<tr>
					<th>제목</th>
					<td>${dto.subject}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td style="height: 300px; vertical-align: middle;">${dto.content}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${dto.name}(${dto.id})</td>
				</tr>
				<tr>
					<th>날짜</th>
					<td>${dto.regdate}</td>
				</tr>
				<tr>
					<th>읽음</th>
					<td>${dto.readcount}</td>
				</tr>
				<tr>
					<th>번호</th>
					<td>${dto.seq}</td>
				</tr>
				<tr>
					<th>파일</th>
					<td>
						<c:if test="${not empty dto.orgfilename}">
						<a href="/toy/board/download.do?filename=${dto.filename}&orgfilename=${dto.orgfilename}">${dto.orgfilename}</a> 
						</c:if>
						
						<c:if test="${empty dto.orgfilename}">
						파일 없음
						</c:if>
						
					</td>
				</tr>
				<tr>
					<th>태그</th>
					<td><input type="text" name="tags" readonly></td>
				</tr>
				<!-- readonly를 주면 삭제할 수 없이 딱 읽기만 가능하게 -->
				<tr>
					<th>좋아요/싫어요</th>
					<td style="display: flex;">
						<form method="GET" action="/toy/board/goodbad.do">
						<button class="btn btn-danger" id="btnbad">
							<i class="fa-regular fa-thumbs-up"></i>
							좋아요(${dto.good})
							<%-- <span class="badge badge-primary">${dto.good}</span> --%>
						</button>
						<input type="hidden" name="seq" value="${dto.seq}">
						<input type="hidden" name="isSearch" value="${isSearch}">
						<input type="hidden" name="column" value="${column}">
						<input type="hidden" name="word" value="${word}">
						<input type="hidden" name="good" value="1">
						<input type="hidden" name="bad" value="0">
						</form>
						
						<form method="GET" action="/toy/board/goodbad.do">
						<button class="btn btn-dark" id="btnbad">
							<i class="fa-regular fa-thumbs-down"></i>
							싫어요 (${dto.bad})
							<%-- <span class="badge badge-primary">${dto.bad}</span> --%>
						<input type="hidden" name="seq" value="${dto.seq}">
						<input type="hidden" name="isSearch" value="${isSearch}">
						<input type="hidden" name="column" value="${column}">
						<input type="hidden" name="word" value="${word}">
						<input type="hidden" name="good" value="0">
						<input type="hidden" name="bad" value="1">
						</form>
						
						
					</td>
				</tr>
				<c:if test="${not empty lat}">
				<tr>
					<th>위치</th>
					<td><div id="map"></div></td>
				</tr>
				</c:if>
				<!-- 07.04 GPS 추가 -->
				
			</table>
			
			<div class="btns">
			
				
				<input type="button" value="돌아가기" class="btn btn-secondary"
					onclick="location.href='/toy/board/list.do?column=${column}&word=${word}';"> 
				
				<!-- <input type="button" value="돌아가기" class="btn btn-secondary"
					onclick="history.back();"> -->
					
					
				<c:if test="${not empty auth}">
				
				<c:if test="${dto.id == auth || auth == 'admin'}">
				<button class="btn btn-primary"
					onclick="location.href='/toy/board/edit.do?seq=${dto.seq}&isSerach=${isSearch}&column=${column}&word=${word}';">
					<i class="fas fa-pen"></i>
					수정하기
				</button>
				
				<!-- 07/01 -->
				<!-- 수정하기만 (검색시 들어왔다가 나갈때 검색 풀리는거) 해결할테니까 그거 보면서 삭제, 답변 해결해 ****** -->
				<!-- 여기서 href에 추가한다음 edit.java에서 수정함. 나머지도 그렇게 -->
				<!-- 		>> view.jsp> edit.java> edit.jsp > editok.java > editok.jsp -->
				<button class="btn btn-primary"
					onclick="location.href='/toy/board/del.do?seq=${dto.seq}&isSerach=${isSearch}&column=${column}&word=${word}';">
					<i class="fas fa-pen"></i>
					삭제하기
				</button>
				</c:if>
				
				<button class="btn btn-primary" type="button"
					onclick="location.href='/toy/board/add.do?reply=1&thread=${dto.thread}&depth=${dto.depth}&isSerach=${isSearch}&column=${column}&word=${word}';">
					<i class="fas fa-pen"></i>
					답변쓰기
				</button>
				</c:if>
				
			</div>
			
			
			
			<!-- 댓글 -->
			
			
			<!-- 07.07 Ajax 적용 -->
			
			<%-- 주석으로 묶기
			<form method="POST" action="/toy/board/addcommentok.do">
			<table class="tblAddComment">
				<tr>
					<td>
						<textarea class="form-control" name="content" required></textarea>
					</td>
					<td>
						<button class="btn btn-primary">
							<i class="fas fa-pen"></i>
							쓰기
						</button>
					</td>
				</tr>
			</table>
			<input type="hidden" name="pseq" value="${dto.seq}">
			
			<input type="hidden" name="isSearch" value="${isSearch}">
			<input type="hidden" name="column" value="${column}">
			<input type="hidden" name="word" value="${word}">
			</form>
			
			
			<table class="table table-bordered comment">
				<c:forEach items="${clist}" var="cdto">
				<tr>
					<td>
						<div>${cdto.content}</div>
						<div>
							<span>${cdto.regdate}</span>
							<span>${cdto.name}(${cdto.id})</span>
							<c:if test="${cdto.id == auth}">
							<span class="btnspan"><a href="#!" onclick="delcomment(${cdto.seq});">[삭제]</a></span>
							<span class="btnspan"><a href="#!" onclick="editcomment(${cdto.seq});">[수정]</a></span>
							</c:if>
						</div>
					</td>
				</tr>
				</c:forEach>
				
			</table>
			
			--%>
			
			<!-- 댓글 > Ajax 버전 (method 없어도됨.) -->
			<form id="addCommentForm">
			<table class="tblAddComment">
				<tr>
					<td>
						<textarea class="form-control" name="content" required></textarea>
					</td>
					<td>
						<button class="btn btn-primary" type="button" 
								onclick="addComment();">
							<i class="fas fa-pen"></i>
							쓰기
						</button>
					</td>
				</tr>
			</table>
			<input type="hidden" name="pseq" value="${dto.seq}">
			</form>
			
			
			<table class="table table-bordered comment">
				<c:forEach items="${clist}" var="cdto">
				<tr>
					<td>
						<div>${cdto.content}</div>
						<div>
							<span>${cdto.regdate}</span>
							<span>${cdto.name}(${cdto.id})</span>
							<c:if test="${cdto.id == auth}">
							<span class="btnspan"><a href="#!" onclick="delcomment(${cdto.seq});">[삭제]</a></span>
							<span class="btnspan"><a href="#!" onclick="editcomment(${cdto.seq});">[수정]</a></span>
							</c:if>
						</div>
					</td>
				</tr>
				</c:forEach>
				
			</table>
			
			
		</section>
	</main>
	
	<script>
		
		//수정 삭제에 이벤트 걺.
		//<td>  x (댓글 수) > 그 개수만큼 이벤트 추가 -> 댓글 쓰기 -> 새로운 <td>가 추가 됨.
		// 새로운 <td>가 추가되는 시점보다 이벤트를 거는 시점이 더 이전임. (그래서 새로운 댓글은 이벤트 안걸림.)
		//새로운 댓글이 추가되는 코드 밑에 얘 한번 더 넣기
		$('.table.comment td').mouseover(function() {
			$(this).find('.btnspan').show();
		});
		
		$('.table.comment td').mouseout(function() {
			$(this).find('.btnspan').hide();
		});
		
		
		/* function delcomment(seq) {
			
			if (confirm('delete?')) {
				
				location.href = 'delcommentok.do?seq=' + seq + '&pseq=${dto.seq}&isSearch=${isSearch}&column=${column}&word=${word}';
			}
			
		} */
		
		
		//ajax버전
		function delcomment(seq) {
					
			//alert($(event.target).parents('tr')[0].nodeName);
			
			//지워지는 지 먼저 확인
			//($(event.target).parents('tr').remove();
			//여기서 event.target은 a태그 -> 이 함수가 이벤트 걸려있는곳이 a 태그니까
			
			
			let tr = $(event.target).parents('tr');
			
			if (confirm('delete?')) {
				
				$.ajax({
					
					type: 'POST',
					url: '/toy/board/delcommentajaxok.do',
					data: 'seq=' + seq,
					success: function(result) {
						
						if (result.result == "1") {
							
							
							//$(event.target).parents('tr').remove();
							//여기서 event.target은 a태그가 아님. (HttpRequest -> Ajax 객체)
							//이 함수가 감싸고 있는 곳은 del 함수가 아니라 success에 걸려있음. (success는 ajax에 걸린 객체)
							// > 그래서 ajax객체가 뜸.
							// >> ajax를 실행중에는 이벤트 태그가 쓸모 XX
							// + 그래서 위에서 미리 이벤트 값을 저장해놓고 여기서 사용
							
							
							tr.remove();
							
							
						} else {
							alert('failed');
						}
						
					},
					error: function(a,b,c) {
						console.log(a,b,c);
					}
					
					
				});
			}
			
		}
		
		
		let isEdit = false; 
		
		function editcomment(seq) {
			
			if (!isEdit) {
				
				//댓글을 읽고
				const tempStr = $(event.target).parent().parent().prev().text();
				
				//수정 폼을 가져오고
				$(event.target).parents('tr').after(temp);
				
				//수정 창이 동시에 열리지 않게
				isEdit = true;
				
				$(event.target).parents('tr').next().find('textarea').val(tempStr);
				$(event.target).parents('tr').next().find('input[name=seq]').val(seq);
			}
			
		}
		
		
		/* const temp = `<tr id='editRow' style="background-color: #CDCDCD;">
						<td>
							<form method="POST" action="/toy/board/editcommentok.do">
							<table class="tblEditComment">
								<tr>
									<td>
										<textarea class="form-control" name="content" required></textarea>
									</td>
									<td>
										<button class="btn btn-secondary" type="button"
											onclick="cancelForm();">
											취소하기
										</button>
										<button class="btn btn-primary">
											<i class="fas fa-pen"></i>
											수정하기
										</button>
									</td>
								</tr>
							</table>
							<input type="hidden" name="pseq" value="${dto.seq}">
							
							<input type="hidden" name="isSearch" value="${isSearch}">
							<input type="hidden" name="column" value="${column}">
							<input type="hidden" name="word" value="${word}">
							
							<input type="hidden" name="seq">
							</form>
						</td>
					</tr>`; */
					
					
			//07.07 댓글 수정 ajax로
		const temp = `<tr id='editRow' style="background-color: #CDCDCD;">
						<td>
							<form id="editCommentForm">
							<table class="tblEditComment">
								<tr>
									<td>
										<textarea class="form-control" name="content" required id="txtcontent"></textarea>
									</td>
									<td>
										<button class="btn btn-secondary" type="button"
											onclick="cancelForm();">
											취소하기
										</button>
										<button class="btn btn-primary" type="button"
											onclick="editComment();">
											<i class="fas fa-pen"></i>
											수정하기
										</button>
									</td>
								</tr>
							</table>
							
							
							<input type="hidden" name="seq">
							</form>
						</td>
					</tr>`;
					
					
					
	
		function cancelForm() {
			$('#editRow').remove();
			isEdit = false;
		}
		
		
		/* 이미지 파일 화면에 출력시 크기 조절 */
		
		//img.onload = function() {} 같은 거
		
		
		$('#imgAttach').ready(function() {
			
			//alert($('#imgAttach').width());
			
			if ($('#imgAttach').width() > 630) {
				$('#imgAttach').width(630);
			}
			
			$('#imgAttach').show();
			
			//view.java에서 display:none으로 하고 여기서 show해주면 깜빡임 현상 사라짐. 
		});
		
		let tag = '';
		
		<c:forEach items="${dto.taglist}" var="tag">
			tag += '${tag},';
		</c:forEach>
	
		//alert(tag);
		
		$('input[name=tags]').val(tag);
		
		const tagify = new Tagify(document.querySelector('input[name=tags]'), {});
	      
	      tagify.on('click', test);
	      
	      function test(e) {
	         //alert(e.detail.data.value); > 태그 값이 나옴.
	         
	         //태그를 함께 전송
	         location.href = '/toy/board/list.do?tag=' + e.detail.data.value;
	         
	      }
	      
	      
	      
	      //07.04 추가 GPS
	      
	      <c:if test="${not empty lat}">
     	 	var container = document.getElementById('map');
     	 	
			var options = {
				center: new kakao.maps.LatLng(${lat}, ${lng}),
				level: 3
			};
		
			var map = new kakao.maps.Map(container, options);
			
			var m = new Kakao.maps.Marker({
				position: new kakao.maps.LatLng(${lat}, ${lng})
			});
			
			m.setMap(map);
			
		</c:if>
	     
	      
	    //07.07 ajax로 댓글쓰기
	    
	    function addComment() {
			
			$.ajax({
				type: 'POST',
				url: '/toy/board/addcommentajaxok.do',
				data: $('#addCommentForm').serialize(),
				dataType: 'json',
				success: function(result) {
					if (result.result == "1") {
						//성공 > 새로 작성된 댓글을 목록에 반영하기
						
						let temp = `<tr>
										<td>
											<div>\${$('[name=content]').val()}</div>
											<div>
												<span>\${result.regdate}</span>
												<span>\${result.name}(\${result.id})</span>
												<span class="btnspan"><a href="#!" onclick="delcomment(\${result.seq});">[삭제]</a></span>
												<span class="btnspan"><a href="#!" onclick="editcomment(\${result.seq});">[수정]</a></span>
											</div>
										</td>
									</tr>`;
						
						//첫 댓글 시 새로고침해야 등록되는 문제 해결			
						if ($('.comment tbody').length == 0) {
		                     $('.comment').append('<tbody></tbody>');
		                  }
                  
						
						$('.comment tbody').prepend(temp);
						
						$('[name=content]').val('');
						
						
						$('.table.comment td').mouseover(function() {
							$(this).find('.btnspan').show();
						});
						
						$('.table.comment td').mouseout(function() {
							$(this).find('.btnspan').hide();
						});
						
					} else {
						//실패
						alert('failed');						
					}
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		}
		
		
	    function editComment() {
	    	
	    	
	    	//prev()는 댓글이 출력되는 <tr>을 가리킴.
	    	//걔의 첫번째 자식의 첫번째 자식을 찾으면 됨.
	    	//alert($('#editRow').prev().children().eq(0).children().eq(0).text());
	    	//댓글 내용 모달로 뜸
	    	
	    	//alert($('#txtcontent').val());
	    	
	    	
	    	
	    	$.ajax({
	    		
	    		type: 'POST',
	    		url: '/toy/board/editcommentajaxok.do',
	    		data: $('#editCommentForm').serialize(),
	    		dataType: 'json',
	    		success: function(result) {
	    			
	    			if (result.result == "1") {
	    				
	    				//수정된 댓글을 화면에 반영하기
	    				//$('textarea[name=content]').val()
	    				//<div>${cdto.content}</div>
	    				$('#editRow').prev().children().eq(0).children().eq(0).text($('#txtcontent').val());
	    				
	    				
	    				//수정이 끝나면 수정 창 닫기
	    				$('#editRow').remove();
	    					
	    				// -> 이렇게 하니까 수정삭제버튼 안뜸 ㅜㅜ *******
	    				
	    			} else {
	    				alert('failed');
	    			}
	    			
	    		},
	    		error: function(a,b,c) {
	    			console.log(a,b,c);
	    		}
	    		
	    		
	    	});
	    	
	    	
	    	
	    
	    	
	    }

	</script>

</body>
</html>

























