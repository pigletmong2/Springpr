<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><!--아래와 같이 jstl를 입력하지 않으면 오류발생  -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><!-- JSTL의 출력과 포맷을 적용할 수 있는 태그 라이브러리 -->
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Bootstrap Admin Theme</title>


<!-- Bootstrap Core Css -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
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
				<div class="panel-heading">Board List Page
				<!-- 등록 버튼 -->
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
						<tbody>
							<c:forEach items="${list}" var="board">
								<tr>
									<td><c:out value="${board.bno }"/></td>
									<!-- 목록페이지 게시물 제목에 <a>태그를 적용해서 조회 페이지로 이동 -->
									<!-- target='_blank' =>'새창으로 열기' -->
									<td><a href='/board/get?bno=<c:out value="${board.bno}"/>'>  
									<c:out value="${board.title }"/></a></td>
									<td><c:out value="${board.writer }"/></td>
									<td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd"/></td>
									<td><fmt:formatDate value="${board.updateDate }" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
				<!-- /.panel-body -->
			</div>
				<!-- /.panel -->
		</div>
			<!-- /.col-lg-12 -->
	</div>
	<!-- <script type="text/javascript">
		$(document).ready(function() {
			var result = '<c:out value="${result}"/>';
		});
	</script> -->
	
	<!-- /.row -->
	
 	<%@include file="../includes/footer.jsp" %>
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
		});
	</script>
</body>
</html>