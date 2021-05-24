<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 게시물 등록작업은 post로 처리하지만 화면에서 입력을 받아야 하므로 get 방식으로 입력페이지를 볼 수 있도록
		BoardController에 GetMapping 메서드 추가 -->
		
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
						<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
						<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
						
						<!-- 검색처리추가 -->
						<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
						<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
						
						</form><!-- cri 이름으로 전달될 Criteria 객체를 이용해서 pageNum과 amount 값을 태그로 구성하고,
								버튼 -->

				</div>
				<!--  end panel-body -->

			</div>
			<!--  end panel-body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->
	
	<div class='row'>
		<div class="col-lg-12">
			<!-- /.panel -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i>댓글
						<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글작성</button>
				</div>
				
				<!-- /.panel-heading -->
				<div class="panel-body">
					<ul class="chat">
						<!-- start reply,댓글목록처리  -->
						<!-- 각 li태그는 하나의 댓글을 의미함
							수정삭체시 rno가 필요하므로 'data-rno'속성을 이용하여 처리 -->
						
						<!-- <li class="left clearfix" data-rno='12'>
							<div>
								<div class="header">
									<strong class="primary-font">user00</strong>
									<small class="pull-right text-muted">2021-05-11 11:59</small>
								</div>
								<p>Good job!</p>
							</div>
						</li> -->
						<!-- end reply -->
					
					</ul>
					<!-- ./end ul -->
				</div>
				<!-- /.panel .chat-panel -->
				<div class="panel-footer"></div>
			</div>
		</div>
		<!-- ./end row -->
	</div>
	
	 <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-group">
                    		<label>댓글</label>
                    		<input class="form-control" name='reply' value='새로운 댓글!!!'>
                    	</div>
                    	<div class="form-group">
                    		<label>작성자</label>
                    		<input class="form-control" name='replyer' value='replyer'>
                    	</div>
                    	<div class="form-group">
                    		<label>작성일</label>
                    		<input class="form-control" name='replyDate' value='2018-01-01 13:13'>
                    	</div>
                    </div>
                    <div class="modal-footer">
                        <button id='modalModBtn' type="button" class="btn btn-warning">수정하기</button>
                        <button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제하기</button>
                        <button id='modalRegisterBtn' type="button" class="btn btn-primary">댓글등록</button>
                        <button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
	
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	
	<!-- showList()는 페이지번호를 파라미터로 받고, 만일 파라미터가 없는 경우 자동으로 1페이지가 됨
		브라우저에서 DOM처리가 끝나면 자동으로 showList()가 호출되면서 <ul>태그내에 내용으로 처리됨
		만일 1페이지가 아닌 경우라면 기존 <ul>에 <li>들이 추가되는 형태 -->
	<script>
		$(document).ready(function(){
			var bnoValue='<c:out value="${board.bno}"/>';
			var replyUL=$(".chat");
			
			showList(1);
			
			function showList(page){
				console.log("show list "+page);
				
				replyService.getList({bno:bnoValue,page:page||1},function(replyCnt,list){
					/* 페이지 호출 */
					console.log("replyCnt: "+replyCnt);
					console.log("list: "+list);
					console.log(list);
					
					if(page==-1){
						pageNum=Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}/* 페이지 번호가 -1로 전다뢰면 마지막페이지를 찾아 다시 호출,
					사용자가 새로운 댓글을 추가하면 showList(-1);을 호출하여 우선 전체댓글 수를 파악함 이후 마지막 페이지를 호출*/
					
					var str="";
					if(list==null||list.length==0){
						/* replyUL.html(""); */
						
						return;
					}
					for (var i=0,len=list.length || 0; i<len; i++){
						str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						str+="	<div><div class='header'><strong class='primary-font'>"
						+list[i].replyer+"</strong>";
						str+="		<small class='pull-right text-muted'>"
						+replyService.displayTime(list[i].replyDate)+"</small></div>";
						/* +list[i].replyDate+"</small></div>"; 시간처리를 위한 변경*/
						str+="		<p>"+list[i].reply+"</p></div></li>";
					}
					replyUL.html(str);
					
					showReplyPage(replyCnt);
				});/* end function */
			}/* end showList */
			
			/* 페이지구성 및 선택페이지 강조 */
			var pageNum=1;
			var replyPageFooter=$(".panel-footer");
			
			function showReplyPage(replyCnt){
				var endNum=Math.ceil(pageNum/10.0)*10;
				var startNum=endNum-9;
				
				var prev=startNum !=1;
				var next=false;
				
				if(endNum*10>=replyCnt){
					endNum=Math.ceil(replyCnt/10.0);
				}
				if(endNum*10<replyCnt){
					next=true;
				}
				
				var str="<ul class='pagination pull-right'>";
				
				if(prev){
					str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
				}
				
				for(var i=startNum;i<=endNum;i++){
					var active=pageNum==i? "active":"";
					
					str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
				}
				
				if(next){
					str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>"
				}
				
				str+="</ul></div>";
				
				console.log(str);
				replyPageFooter.html(str);
			}
			
			/* 페이지번호를 클릭했을 때 새로운 댓글을 가져오도록 함 
			페이지번호는 <a>태그 내에 존재하므로 <a>태그의 기본 동작을 제한하고, 댓글 페이지 번호를 변경한 후 해당 페이지의 댓글을 가져옴*/
			replyPageFooter.on("click","li a",function(e){
				e.preventDefault();
				console.log("page click");
				
				var targetPageNum=$(this).attr("href");
				console.log("targetPageNum: "+targetPageNum);
				pageNum=targetPageNum;
				showList(pageNum);
			});
			
			/* 댓글 추가 클릭시 버튼 이벤트 처리 */
			var modal=$(".modal");
			var modalInputReply=modal.find("input[name='reply']");
			var modalInputReplyer=modal.find("input[name='replyer']");
			var modalInputReplyDate=modal.find("input[name='replyDate']");
			
			var modalModBtn=$("#modalModBtn");
			var modalRemoveBtn=$("#modalRemoveBtn");
			var modalRegisterBtn=$("#modalRegisterBtn");
			
			$("#modalCloseBtn").on("click",function(e){
				modal.modal('hide');
			});
			
			$("#addReplyBtn").on("click",function(e){
				modal.find("input").val("");
				modalInputReplyDate.closest("div").hide();
				modal.find("button[id!='modalCloseBtn']").hide();/* 닫기를 제외한 나머지 버튼 숨기기 */
				
				modalRegisterBtn.show();
				
				$(".modal").modal("show");
			});
			
			/* 댓글 등록 및 목록 갱신 : 정상적으로 추가되면 경고창으로 success창을 띄우고,
			등록한 내용으로 다시 등록할 수 없도록 입력항목을 비우고 모달창을 닫는다*/
			modalRegisterBtn.on("click",function(e){
				var reply={
						reply:modalInputReply.val(),
						replyer:modalInputReplyer.val(),
						bno:bnoValue
				};
				replyService.add(reply,function(result){
					alert(result);
					
					modal.find("input").val("");
					modal.modal("hide");
					
					/* showList(1); */ /* 목록 갱신 */
					showList(-1);
				});
			});
			
			/* 특정댓글 이벤트 처리
				DOM(html문서에 대한 인터페이스)에서 이벤트 리스너를 등록하는 것은 반드시
				해당 DOM 요소가 존재해야만 가능. 위와 같이 동적으로 li태그들이 만들어지면 이후에 이벤트를 등록해야 하므로
				일반적인 방식이 아닌 이벤트 위임 delegation형태로 작성해야 함.
				
				이벤트 위임은 실제로 이벤트를 동적으로 생성하는 요소가 아닌 이미 존재하는 요소에 이벤트를 걸어주고
				나중에 이벤트 대상을 변경해주는 방식이다.
				
				jQuery에서 이벤트 위임방식은 이미 존재하는 DOM요소에 이벤트를 처리하고 나중에 동적으로 생기는 요소들에 대해
				파라미터 형식으로 지정*/
			$(".chat").on("click","li",function(e){
				var rno=$(this).data("rno");
				/* console.log(rno); */
				
				replyService.get(rno,function(reply){
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
					modal.data("rno",reply.rno);
					
					modal.find("button[id!='modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					$(".modal").modal("show");
				});
			});/* 오류 */
			/* 위의 경우 ul태그의 클래스 chat을 이용해 이벤트를 걸고 실제 이벤트 대상은 li태그가 되도록 함 */
			
			/* 수정 */
			modalModBtn.on("click",function(e){
				var reply={rno:modal.data("rno"),reply:modalInputReply.val()};
				
				replyService.update(reply,function(result){
					alert(result);
					modal.modal("hide");
					/* showList(1); */
					showList(pageNum);
					/* 댓글이 페이지 처리되면 수정삭제시에도 현재 댓글이 포함된 페이지로 이동하도록 수정 */
				});
			});
			/* 삭제 */
			modalRemoveBtn.on("click",function(e){
				var rno=modal.data("rno");
			
				replyService.remove(rno,function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
					});
				});
		});
	</script>
	
	
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
	
	<!-- <script type="text/javascript">
		$(document).ready(function(){
			console.log(replyService);
		});
	</script> -->
	
	<!-- Ajax호출은 replyService 객체에 감춰져 있으므로 필요한 파라미터들만 전달하는 형태로 간결해짐
		replyService의 add()에 던져야 하는 파라미터는 JavaScript의 객체 타입으로 만들어 전송해주고
		Ajax 전송 결과를 처리하는 함수를 파라미터로 같이 전달한다.  -->
	<!-- <script>
	/* console.log("================");
	console.log("JS TEST");
	
	var bnoValue='<c:out value="${board.bno}"/>'; */
	
	/* for replyService add test */
	/* replyService.add(
			{reply:"JS TEST",replyer:"tester",bno:bnoValue}
			,
			function(result){
				alert("RESULT : "+result);
			}
	); */
	
	/* for reply List test */
	/* replyService.getList({bno:bnoValue,page:1},function(list){
		for(var i=0,len=list.length||0;i<len;i++){
			console.log(list[i]);
		} */
	
	/* 21번 댓글 삭제 테스트 */
	/* replyService.remove(21,function(count){
		console.log(count);
		
		if(count==="success"){
			alert("REMOVED");
		}
	},function(err){
		alert('ERROR...');
	}); */
	
	/* 12번 댓글 수정 */
	/* replyService.update({
		rno:12,
		bno:bnoValue,
		reply:"Modified Reply..."
	},function(result){
		alert("수정 완료...");
	}); */
	
	/* 10번 댓글 조회 */
	/* replyService.get(10,function(data){
		console.log(data);
	}); */
	</script> -->
	<%@include file="../includes/footer.jsp"%>

