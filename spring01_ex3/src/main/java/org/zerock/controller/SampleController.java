package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;

@RestController /* jsp와 달리 순수한 데이터를 반환하는 형태 */
@RequestMapping("/sample")
@Log4j
public class SampleController {
	@GetMapping(value="/getText",produces="text/plain; charset=UTF-8")
	/* produces = 해당 메서드가 생산하는 mime타입, 문자열로 직접 지정하거나 메서드내 mediatype이라는 클래스를 이용할수도 있음 */
	
	public String getText() {/* 단순문자열 반환 */
		log.info("MIME TYPE: "+MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample",produces= {MediaType.APPLICATION_JSON_UTF8_VALUE,
												MediaType.APPLICATION_XML_VALUE})
		public SampleVO getSample() {
		return new SampleVO(112,"스타","로드");
	}
	
	/* XML과 JSON방식의 데이터를 생성할 수 있도록 작성됨, getmapping이나 requestmapping 속성응 반드시 지정해야하는 것은 아님(생략가능) */
	@GetMapping(value="/getSample2")
		public SampleVO getSample2() {
		return new SampleVO(113,"로켓","라쿤");
	}
	
	/* 컬렉션 타입의 객체반환, 경우에 따라서 여러 데이터를 한번에 전송하기 위해 배열이나 리스트, 맵타입의 객체를 전송하기도 함 */
	@GetMapping(value="/getList")
	public List<SampleVO> getList(){
		return IntStream.range(1,10).mapToObj(i -> new SampleVO(i,
				i + "First",i+" Last"))
				.collect(Collectors.toList());
	} /* 내부적으로 1부터 10미만까지 루프를 처리하면서 sampleVo객체를 만들어 List<SampleVO>로 만들어냄 */
	/* 확장자를 ".json"으로 처리하면 []로 싸여진 json형태의 배열데이터 확인가능 */
	
	
	/* map은 '키'와 '값'을 가지는 하나의 객체로 간주, 'key'에 속하는 데이터는 xml로 변환하는 경우 태그의 이름이 됨*/
	@GetMapping(value="/getMap")
	public Map<String,SampleVO> getMap(){
		Map<String,SampleVO> map=new HashMap<>();
		map.put("First", new SampleVO(111,"그루트","주니어"));
		
		return map;
	}

	
	/* ResponseEntity는 데이터와 함께 http헤더의 상태메세지 등을 같이 전달하는 용도로 사용함,
 	http의 상태코드와 에러메세지 등을 함께 데이터를 전달할 수 있기 때문에 받는 입장에서는 확실하게 결과를 알수 있다.
 	check()는 반드시 'height'와 'weight'를 파라미터로 전달받고, 만일 'height'값이 150보다 작다면
 	502(bad gateway)상태코드와 데이터를 전송, 그렇지 않다면 200(ok)코드와 데이터를 전송*/
	@GetMapping(value="/check",params={"height","weight"})
	public ResponseEntity<SampleVO> check(Double height,Double weight){
		SampleVO vo=new SampleVO(0,""+height,""+weight);
		
		ResponseEntity<SampleVO> result=null;
		
		if(height<150) {
			result=ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}else {
			result=ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	
	/* RestController는 기존의 @Controller에서 사용하던 일반적인 타입이나 사용자가 정의한 타입(클래스)을 사용
	 * 추가 어노테이션을 이용하는 경우 @PathVariable: Rest방식에서 자주사용(url 경로의 일부를 파라미터로 사용할때 이용)
	 * 					- rest방식에서는 url내에 최대한 많은 정보를 담으려고 하기때문에 예전에 '?'뒤에 추가되는 query string이라는 형태로
	 * 					 파라미터를 이용해서 전달되던 데이터들이 rest방식에서는 경로의 일부로 차용되는 경우가 많음
	 * 					URL에서 '{}'로 처리되 부분은 컨트롤러의 메서드에서 변수로 처리가 가능
	 * 					pathvariable은 '{}'의 이름을 처리할 때 사용함 
	 * 						@RequestBody:JSON데이터를 원하는 타입의 객체로 변환해야 하는 경우 주로 사용*/
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(
		@PathVariable("cat") String cat,
		@PathVariable("pid") Integer pid){
			return new String[] {"category:"+cat,"productid: "+pid};
	}
	
	
	/* RequestBody 는 전달된 요청(request)의 내용(body)을 이용해서 해당 파라미터의 타입으로 변환을 요구함
	 * 내부적으로 HttpMessageConverter타입의 객체들을 이용해서 다양한 포맷의 입력데이터를 변환할 수 있다.
	 * postMapping이 적용된 이유: requestbody가 말그대로 request한 body을 처리하기 때문에 일반적인 파라미터 방식을 사용할 수 업음 */
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert......ticket"+ticket);
		return ticket;
	}
}
