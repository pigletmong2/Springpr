<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 게시물 등록작업은 post로 처리하지만 화면에서 입력을 받아야 하므로 get 방식으로 입력페이지를 볼 수 있도록
		BoardController에 GetMapping 메서드 추가 -->

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Bootstrap Admin Theme</title>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="/resources/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

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
			<h1 class="page-header">조회하기</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">

				<div class="panel-heading">조회게시물</div>
				<!-- /.panel-heading -->
				<div class="panel-body">

					<!-- <form role="form" action="/board/register" method="post">
						<div class="form-group">
							<label>Title</label> <input class="form-control" name='title'>
						</div> -->

						<div class="form-group">
							<label>Bno</label><input class="form-control" name='bno'
							value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>Title</label><input class="form-control" name='title'
							value='<c:out value="${board.title}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" rows="3" name='content'
							readonly="readonly"><c:out value="${board.content}" /></textarea>
						</div>
						
						<div class="form-group">
							<label>Writer</label><input class="form-control" name='writer'
							value='<c:out value="${board.writer}"/>' readonly="readonly">
						</div>
						
						<button data-oper='modify' class="btn btn-default">수정하기</button>
						<!-- onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'"> -->
						
						
						<button data-oper='list' class="btn btn-info">게시판으로 이동</button>
						<!-- 버튼 내 링크 추가 -->
						<!-- onclick="location.href='/board/list'"> -->
					
						<!-- form태그를 이용하여 수정페이지로 이동 -->
						<form id="operForm" action="/board/modify" method="get">
						<input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno}"/>"/>
					</form>

				</div>
				<!--  end panel-body -->

			</div>
			<!--  end panel-body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->
	<%@include file="../includes/footer.jsp"%>
	<script type="text/javascript">
		$(document).ready(function(){
			
			var operForm=$("#operForm");
			
			$("button[data-oper='modify']").on("click",function(e){
				operForm.attr("action","/board/modify").submit();
			});
			
			$("button[data-oper='list']").on("click",function(e){
				operForm.find("#bno").remove();/* list로 이동하는 경우 아무런 데이터도 필요하지 않으므로 bno태그를 지움 */
				operForm.attr("action","/board/list")
				operForm.submit();
			});
		});
	</script>

</body>

</html>