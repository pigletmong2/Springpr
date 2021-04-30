package org.zerock.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;

	
	@Test 
	public void testGetList() { //�ۼ��� mapper interface�׽�Ʈ
	  mapper.getList().forEach(board ->log.info(board)); }
	
	@Test public void testInsert() {
	  BoardVO board = new BoardVO();
	  board.setTitle("���� �ۼ��ϴ� ��"); board.setContent("���� �ۼ��ϴ� ����");
	  board.setWriter("newbie"); log.info("1.-----------------------------");
	  mapper.insertSelectKey(board); log.info("2.-----------------------------");
	  log.info("�ڷ��Է�:"+board); }
	
	@Test public void testRead() { // �����ϴ� �Խù� ��ȣ�� �׽�Ʈ
	  BoardVO board=mapper.read(5L);
	  log.info(board);
	} /* 5(L)=longŸ��,Bno="5" */
	

	@Test
	public void testDelete() {
		log.info("������ ��ȣ :"+mapper.delete(61L));
		
	}

	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(41L);
		board.setTitle("��������");
		board.setContent("��������");
		board.setWriter("user00");

		int count = mapper.update(board);
		log.info("������ ��ȣ :" + count);
	}

}
