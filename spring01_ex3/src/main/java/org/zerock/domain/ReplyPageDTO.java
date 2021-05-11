package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReplyVO> list;
	/*
	 * 단순히 댓글 전체를 보여주는 방식과 달리 댓글의 페이징 처리가 필요한 경우에 댓글 목록과 함께 전체 댓글 수를 같이 전달해야 함.
	 * ReplyService 인터페이스와 구현클래스인 Impl 클래스는 List<ReplyVO>와 댓글 수를 같이 전달할 수 있는 구조로 변경
	 */
}
