package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;


//����Ͻ� ����, ���ż���-��ǰ/ȸ��ó����ü
//���θ��� ���� ��: ������ ������ ȸ������ ����Ʈ ����
//���Ӱ���(��ǰ�� ȸ���� ������ ����)/����Ͻ���������(��ǰ������ ȸ�������� ���ÿ� �ٿ��Ͽ� �ϳ��� ����ó��)
//�� ������ ������ �������̽��� ����Ͽ� ������ ����(����)�� ��
public interface BoardService {
	public void register(BoardVO board);
	public BoardVO get(Long bno); /* ������ �Խù� ��ȸ */
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public List<BoardVO> getList(); /* get():Ư���Խù��� ������ ,getList():��ü����Ʈ */

}
