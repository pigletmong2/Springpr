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

				<div class="panel-heading">수정하기</div>
				<!-- /.panel-heading -->
				<div class="panel-body">

					<form role="form" action="/board/modify" method="post">

						<div class="form-group">
							<label>Bno</label><input class="form-control" name='bno'
							value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>Title</label><input class="form-control" name='title'
							value='<c:out value="${board.title}"/>'>
						</div>

						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" rows="3" name='content'>
							<c:out value="${board.content}" /></textarea>
						</div>
						
						<div class="form-group">
							<label>Writer</label><input class="form-control" name='writer'
							value='<c:out value="${board.writer}"/>' readonly="readonly">
						</div>
						
						<!-- 등록일과 수정일은 나중에 BoardVO로 수집되어야 하므로 날짜 포맷을 'yyyy/mm/dd'의 포맷으로 해야함
							만일 포맷이 맞지 않으면 파라미터 수집 부분에 문제가 생김 -->
						<div class="form-group">
							<label>RegDate</label><input class="form-control" name='regDate'
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>'
							readonly="readonly">
						</div>
						
						<div class="form-group">
							<label>Update Date</label><input class="form-control" name='updateDate'
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>'
							readonly="readonly">
						</div>
						
						<button type="submit" data-oper='modify' class="btn btn-default">수정하기</button>
						<!-- 링크 추가 -->
						<button type="submit" data-oper='remove' class="btn btn-danger">삭제하기</button>
						<button type="submit" data-oper='list' class="btn btn-info">게시판으로 이동</button>
								<!-- <onclick="location.href='/board/list'"></button> -->
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
		
		var formObj=$("form");
		
		$('button').on("click",function(e)){
			e.preventDefault();
			/* a태그나 submit태그를 누르면 href를 통해 이동하거나 창이 새로고침하여 실행됨
				preventDefault는 이러한 동생을 막아줄 수 있음
				주 사용 경우 1. a태그를 눌렀을 때도 링크로 이동하지 않게 할 경우
						2. form 안에 submit 역할을 하는 버튼을 눌렀어도 새로 실행하게 않게 하고 싶을 경우
							예) event안에 preventDefault가 없는 경우
								0.1초 정도 결과가 보였다가 다시 사라짐
								-> submit과 동시에 창이 다시 실행되기때문,초기화면으로 다시 돌아오게 됨*/
			
			var operation=$(this).data("oper");/* data-oper 속성을 이용해서 세부 기능 동작 처리 */
			
			console.log(operation);
			
			if(operation==='remove'){
				formObj.attr("action","/board/remove");
			}else if(operation==='list'){
				//move to list
				formObj.attr("action","/board/list").attr("method","get");
				formObj.empty();
			}
			formObj.submit();
		});
	});
	</script>

</body>

</html>