package com.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTests {
	@Setter(onMethod_= {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO board=new BoardVO();
		board.setTitle("새 제목 테스트");
		board.setContent("새 내용 테스트");
		board.setWriter("newbie test");
		
		service.register(board);
		log.info("생성된 게시물 번호"+board.getBno());
	}
	
	@Test
	public void testGet() {
		log.info(service.get(1L));
	}
	
	
	@Test public void testDelete() {
		log.info("삭제결과:"+service.remove(62L));
	}
	 
	
	@Test
	public void testUpdate() {
		BoardVO board=service.get(1L);
		if(board==null) {
			return;
		}
		board.setTitle("제목을 수정합니다.");
		log.info("수정결과:"+service.modify(board));
	}
}
