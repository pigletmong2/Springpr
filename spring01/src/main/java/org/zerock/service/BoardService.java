package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;


//비즈니스 계층, 구매서비스-상품/회원처리객체
//쇼핑몽의 로직 예: 물건을 구매한 회원에게 포인트 적립
//영속계층(상품과 회원을 나눠서 설계)/비즈니스계층설계(상품영역과 회원영역을 동시에 다용하여 하나의 로직처리)
//각 계층간 연결은 인터페이스를 사용하여 느슨한 연결(결합)을 함
public interface BoardService {
	public void register(BoardVO board);
	public BoardVO get(Long bno); /* 지정한 게시물 조회 */
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
//	public List<BoardVO> getList(); /* get():특정게시물을 가져옴 ,getList():전체리스트 */
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);

}
