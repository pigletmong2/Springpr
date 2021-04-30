package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {
//	@Select("select*from tbl_board where bno>0") XML파일에 작성
	public List<BoardVO> getList();
	
	public void insert(BoardVO board); /* insert만 처리되고, 생성된 pk값을 알필요가 없는 경우 */
	public void insertSelectKey(BoardVO board); /* insert문이 실행되고, 생성된 pk값을 알아야 하는 경우<selectkey>사용 */
	public BoardVO read(Long bno);
	public int delete(Long bno);
	public int update(BoardVO board);
}

