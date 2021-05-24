/*조회페이지에서 사용,간단한 동작 확인*/

console.log("Reply Module.......");

/*var replyService={name:""};*/

/*모듈 구성하기:모듈 패턴은 java class처럼 javascript를 이용해서 메서드를 가지는 객체를 구성*
javascript의 즉시 실행함수는 () 안에 함수를 선언하고 바깥쪽에서 실행함
즉시 실행함수는 함수의 실행결과가 바깥쪽에 선언된 변수에 할당됨
replyService라는 변수에 name이라는 속성에 "AAAA"라는 속성값을 가진 객체가 할당*/

/*var replyService=(function(){
	return {name:"AAAA"};
})();*/

/*등록 처리,ajax를 이용하여 post방식으로 호출
데이터 전송타입 :"application/json,charset=utf-8 방식
파라미터로 callback과 error를 함수로 받는다
만일 Ajax호출이 성공하고, callback값으로 적절한 함수가 존재하면 해당함수를 호출해서 결과를 반영하는 방식
javascript는 함수의 파라미터 개수를 일치시킬 필요가 없기 때문에 callback이나 error와 같은 파라미터는
필요에 따라서 작성할 수 있음"*/
var replyService=(function(){
	/*추가*/
	function add(reply,callback,error){
		console.log("add reply................");
		
		$.ajax({
			type:'post',
			url:'/replies/new',
			data:JSON.stringify(reply),
			contentType:"application/json; charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		})
	}
	/*조회
		getList()는 param이라는 객체를 통해서 필요한 파라미터를 전달받아 Json 목록을 호출함
		json형태가 필요하므로 url호출시 확장자를 '.json'으로 요구*/
	function getList(param,callback,error){
		var bno=param.bno;
		var page=param.page||1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
			function(data){
				if(callback){
					/*callback(data);*///댓글 목록만 가져오는 경우
					callback(data.replyCnt,data.list);//댓글 숫자와 목록을 가져오는 경우
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
	}
	
	/*function getList(param,callback,error){
		var bno=param.bno;
		var page=param.page||1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
			function(data)
		)
	}*/
	
	
	/*특정번호 조회*/
	function get(rno,callback,error){
		$.get("/replies/"+rno+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	
	/*삭제*/
	function remove(rno,callback,error){
		$.ajax({
			type:'delete',
			url:'/replies/'+rno,
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	/*수정*/
	function update(reply,callback,error){
		console.log("RNO: "+reply.rno);
		
		$.ajax({
			type:'put',
			url:'/replies/'+reply.rno,
			data:JSON.stringify(reply),
			contentType:"application/json;charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	/*시간처리*/
	function displayTime(timeValue){
		var today=new Date();
		
		var gap=today.getTime()-timeValue;
		
		var dateObj=new Date(timeValue);
		var str="";
		
		if (gap<(1000*60*60*24)){
			var hh=dateObj.getHours();
			var mi=dateObj.getMinutes();
			var ss=dateObj.getSeconds();
			
			return [(hh>9?'':'0')+hh,':',(mi>9?'':'0')+mi,':',
					(ss>9?'':'0')+ss].join('');
		}else{
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1;//getMonth() is zero-based
			var dd=dateObj.getDate();
			
			return [yy,'/',(mm>9?'':'0')+mm,'/',
							(dd>9?'':'0')+dd].join('');
		}
	};
	
	return {
		add:add,
		getList:getList,
		get:get,
        remove:remove,
        update:update,
        displayTime:displayTime
       };
})();/*add부분이 "add"문자열로 지정되어있어 오류남*/
