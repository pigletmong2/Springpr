<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><!--아래와 같이 jstl를 입력하지 않으면 오류발생  -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 -->

<%@include file="../includes/header.jsp"%>
	
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Tables</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<!-- 등록 버튼 -->
				<div class="panel-heading">게시판
				<button id='regBtn' type="button" class="btn btn-xs pull-right">
				새글작성</button>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<!-- model에 담긴 데이터 출력 -->
						<!-- <tbody> -->
							<c:forEach items="${list}" var="board">
								<tr>
									<td><c:out value="${board.bno}"/></td>
									
									<!-- 목록페이지 게시물 제목에 <a>태그를 적용해서 조회 페이지로 이동 -->
									<!-- target='_blank' =>'새창으로 열기' -->
									<%-- <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'>  
									<c:out value="${board.title }"/></a></td> --%>
									<!-- 페이지번호는 조회 페이지에 전달되지 않기 때문에 조회페이지에서 목폭으로 이동할 때는 아무런 정보없이 /board/list를 호출함 -->
									
									<td><a class='move' href='<c:out value="${board.bno}"/>'>  
									<c:out value="${board.title}"/></a></td>
									
									<td><c:out value="${board.writer}"/></td>
									<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
									<td><fmt:formatDate value="${board.updateDate}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						<!-- </tbody> -->
					</table>
					
					<div class='pull-right'>
						<ul class="pagination">
							<!-- PageDTO.pageMaker -->
							<c:if test="${pageMaker.prev}">
								<li class="paginate_button previous">
								<a href="${pageMaker.startPage-1}">Previous</a>
								</li>
							</c:if>
							
							<!-- 이상태로 페이지번호를 클릭하면 URL존재하지않는다고 뜸 -->
							<c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								<li class="paginate_button ${pageMaker.cri.pageNum==num ? "active": ""}">
								<a href="${num}">${num}</a></li>
							</c:forEach>
							
							<c:if test="${pageMaker.next}">
								<li class="paginate_button next">
								<a href="${pageMaker.endPage +1}">Next</a></li>
							</c:if>
						</ul>
					</div>
					<!-- end Pagination -->
				</div>
				<!-- /.panel-body -->
				
				<form id='actionForm' action="/board/list" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					
					<%-- <input type='hidden' name='type'
						value='<c:out value="${pageMaker.cri.type}"/>'>
					<input type='hidden' name='keyword'> --%>
				</form>
				
				<!-- Modal 추가 -->
				<!-- <div>를 화면에 특정위치에 보여주고, 배경이 되는 <div>에 배경색을 입혀 처리
					활성화된 <div>를 선택하지 않고, 다시 원래화면을 볼 수 없도록 막기 때문에 메세지를 보여는데 효과적인 방식 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
						<div class="modal-body">
							처리가 완료되었습니다.
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save changes</button>
						</div>
						</div>
	 					<!-- /.modal-content -->
	               </div>
	               <!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->	
	</div>

	<!-- /.row -->		

	<!-- <script type="text/javascript">
		$(document).ready(function() {
			var result = '<c:out value="${result}"/>';
		});
	</script> -->
	<script type="text/javascript">
	/* jQuery 처리/header,footer 미적용시 활성화안됨/header 소스 안에 notifications.html 포함 */
		$(document).ready(function(){
			var result='<c:out value="${result}"/>';
			checkModal(result);
			
			/* 모달창이 새게시물을 등록했을 때만 뜨도록 설정,뒤로가기 실행시 실행되지 않도록 */
			history.replaceState({},null,null); 
			
			function checkModal(result){
				if(result===''||history.state){
					return;
				}
				if(parseInt(result)>0){
					$(".modal-body").html("게시글"+parseInt(result)+" 번이 등록되었습니다.");
				}
				$("#myModal").modal("show");
			}
			/* 목록페이지 상단에 등록 버튼을 추가하여 처리할 수 있도록 함 */
			$("#regBtn").on("click",function(){ 
				self.location="/board/register";
			});
			
			var actionForm=$("#actionForm");
			
			$(".paginate_button a").on("click",function(e){
				e.preventDefault(); /* <a>태그를 클릭해도 페이지 이동이 없도록 처리 */
				console.log('click');
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				/* <form> 태그내 pageNum 값은 href속성값으로 변경 */
				
				actionForm.submit();
			});
			
			$(".move").on("click",function(e){
				e.preventDefalut();
				actionForm.append("<input type='hidden' name='bno' value='"+
						$(this).attr("href")+"'>");
				actionForm.attr("action","/board/get");
				actionForm.submit();
			});
			/* 게시물 제목을 클릭하면 pageNum와 amount 파라미터가 추가로 전달됨 */
		});
	</script>
	
 	<%@include file="../includes/footer.jsp" %>
	