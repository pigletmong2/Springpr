package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;
	
	/*
	 * rest 방식으로 처리할때 주의해아할 점 : 브라우저나 외부에서 서버를 호출할 때 데이터의 포맷과 서버에서 보내주는 데이터의 타입을 명확히
	 * 설계해야 함 예)댓글 등록은 브라우저에서는 JSON타입으로 된 댓긋 데이터를 전송하고, 서버에서는 댓글의 처리결과가 정상적으로 되었는지
	 * 문자열로 결과를 알려주도록 한다.
	 */
	
	@PostMapping(value="/new",consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO:"+vo);
		int insertCount=service.register(vo);
		log.info("Reply INSERT COUNT : "+insertCount);
		return insertCount==1
				?new ResponseEntity<>("success",HttpStatus.OK)
						:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		/* 삼항연산자처리, create()는 post방식으로만 동작하도록 설계,
		 * consumes와 produces를 이용해서 json방식의 데이터만 처리하도록 하고, 문자열을 반환하도록 설계
		 * create()의 파라미터는 #RequestBody를 적용해서 Json데이터를 replyVo타입으로 변환하도록 지정
		 * create()는 내부적으로 ReplyServiceImpl을 호출해서 register()를 호출하고, 댓글이 추가된 숫자를 확인해
		 * 브라우저에서 '200ok'혹은 '500 internal server error'를 반환하도록 한다.
		 * 테스트시 content-type과 applicaiton/json으로 지정후 테스트진행해야함, 테스트번호는 기본 존재하는 번호여야함*/
	}
	
	@GetMapping(value="/{rno}",produces={MediaType.APPLICATION_XML_VALUE,
										MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")Long rno){
		log.info("get: "+rno);
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}

	
	
	
	
	/* 댓글수정은 'PUT'방식이나 'PATCH'방식을 이용하도록 처리하고, 실제 수정되는 데이터는 JSON포맷이므로
	 * @RequestBody를 이용해서 처리한다. @RequestBody로 처리되는 데이터는 일반 파라미터나
	 * PathVariable파라미터를 처리할 수 없기 때문에 직접처리해줘야함 */
	@RequestMapping(method= {RequestMethod.PUT,RequestMethod.PATCH},
			value="/{rno}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,
			@PathVariable("rno") Long rno){
		vo.setRno(rno);
		log.info("rno : "+rno);
		log.info("modify : " + vo);
		
		return service.modify(vo)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
						:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/* 특정게시물의 댓글목록 확인: getList()는 Criteria를 이용해서 파라미터를 수집, {page} 값은 Criteria를 생성해서 직접 처리해야 함
	 * 게시물 번호는 PathVariable을 이용해서 파라미터로 처리 */
//	@GetMapping(value="/pages/{bno}/{page}",produces= {MediaType.APPLICATION_XML_VALUE,
//														MediaType.APPLICATION_JSON_UTF8_VALUE})
//	public ResponseEntity<List<ReplyVO>> getList(
//			@PathVariable("page") int page,
//			@PathVariable("bno") Long bno){
//		log.info("getList..............");
//		Criteria cri=new Criteria(page,10);
//		log.info(cri);
//		
//		return new ResponseEntity<>(service.getList(cri, bno),HttpStatus.OK);
//	}
	
	@GetMapping(value="/pages/{bno}/{page}",produces={MediaType.APPLICATION_XML_VALUE,
														MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno){
		Criteria cri=new Criteria(page,10);
		log.info("get Reply List bno: "+bno);
		log.info("cri:"+cri);
		
		return new ResponseEntity<>(service.getListPage(cri,bno),HttpStatus.OK);
	}
	/* 삭체 */
	@DeleteMapping(value="/{rno}",produces= {MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("remove"+rno);
		return service.remove(rno)==1
				?new ResponseEntity<>("success",HttpStatus.OK)
						:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}