package org.zerock.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;

	
//	@Test 
//	public void testGetList() { //작성한 mapper interface테스트
//	  mapper.getList().forEach(board ->log.info(board)); }
	
	@Test
	public void testPaging() {
		Criteria cri=new Criteria();
//		10개씩 3페이지
		cri.setPageNum(2);
		cri.setAmount(10);
		List<BoardVO> list=mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board));
	}
	
//	@Test public void testInsert() {
//	  BoardVO board = new BoardVO();
//	  board.setTitle("새로 작성하는 글"); board.setContent("새로 작성하는 내용");
//	  board.setWriter("newbie"); log.info("1.-----------------------------");
//	  mapper.insertSelectKey(board); log.info("2.-----------------------------");
//	  log.info("자료입력:"+board); }
//	
//	@Test public void testRead() { // 존재하는 게시물 번호로 테스트
//	  BoardVO board=mapper.read(5L);
//	  log.info(board);
//	} /* 5(L)=long타입,Bno="5" */
//	
//
//	@Test
//	public void testDelete() {
//		log.info("삭제할 번호 :"+mapper.delete(61L));
//		
//	}
//
//	@Test
//	public void testUpdate() {
//		BoardVO board = new BoardVO();
//		board.setBno(41L);
//		board.setTitle("수정제목");
//		board.setContent("수정내용");
//		board.setWriter("user00");
//
//		int count = mapper.update(board);
//		log.info("수정할 번호 :" + count);
//	}
}