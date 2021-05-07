package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor; /*전체 값을 모두 받는 클래스(생성자)*/
import lombok.extern.log4j.Log4j; /*로그값출력*/


@Log4j
//@service:스프링에 빈으로 등록되는 서비스객체의 어노테이션
//XML의 경우 <component-scan>에서 조사하는 패키지의 클래스들 중 @service가 있는 클래스의 인스턴스를 스프링의 빈으로 설정
@Service /* 스프링4.3부터는 단일 파라미터를 받는 생성자의 경우, 필요한 파라미터를 자동으로 주입가능 */
@AllArgsConstructor /* 모든 파라미터를 이용하는 생성자를 생성 */
public class BoardServiceImpl implements BoardService{
	private BoardMapper mapper;

//	비즈니스계층에서 사용하기 때문에 서비스 어노테이션 사용
//	일을 수행하기 위해 mapper를 주입해야하므로 오토와이어드를 붙임
//	@Autowired:스프링이 빈의 요구사항과 매칭되는 애플리케이션 컨텍스트상에서 다른빈을 찾아 빈간의 의존성을 자동으로 만족시키도록 하는 수단
//	lombok이 자동 생성자를 생성하므로 기본 생성자는 삭제↓
//	public BoardServiceImpl() {}
	
	@Override
	public void register(BoardVO board) {
		log.info("register"+board);
		mapper.insertSelectKey(board);
		
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("검색:"+bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("수정:"+board);
		return mapper.update(board) == 1; /* 값이 1일때 지워줌 */
	}

	@Override
	public boolean remove(Long bno) {
		log.info("삭제:"+bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria:"+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	
}

