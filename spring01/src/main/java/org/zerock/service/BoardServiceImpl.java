package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor; /*��ü ���� ��� �޴� Ŭ����(������)*/
import lombok.extern.log4j.Log4j; /*�αװ����*/


@Log4j
//@service:�������� ������ ��ϵǴ� ���񽺰�ü�� ������̼�
//XML�� ��� <component-scan>���� �����ϴ� ��Ű���� Ŭ������ �� @service�� �ִ� Ŭ������ �ν��Ͻ��� �������� ������ ����
@Service /* ������4.3���ʹ� ���� �Ķ���͸� �޴� �������� ���, �ʿ��� �Ķ���͸� �ڵ����� ���԰��� */
@AllArgsConstructor /* ��� �Ķ���͸� �̿��ϴ� �����ڸ� ���� */
public class BoardServiceImpl implements BoardService{
	private BoardMapper mapper;

//	����Ͻ��������� ����ϱ� ������ ���� ������̼� ���
//	���� �����ϱ� ���� mapper�� �����ؾ��ϹǷ� ������̾�带 ����
//	@Autowired:�������� ���� �䱸���װ� ��Ī�Ǵ� ���ø����̼� ���ؽ�Ʈ�󿡼� �ٸ����� ã�� ���� �������� �ڵ����� ������Ű���� �ϴ� ����
//	lombok�� �ڵ� �����ڸ� �����ϹǷ� �⺻ �����ڴ� ������
//	public BoardServiceImpl() {}
	
	@Override
	public void register(BoardVO board) {
		log.info("register"+board);
		mapper.insertSelectKey(board);
		
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("�˻�:"+bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("����:"+board);
		return mapper.update(board) == 1; /* ���� 1�϶� ������ */
	}

	@Override
	public boolean remove(Long bno) {
		log.info("����:"+bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList() {
		log.info("��ü��ȸ");
		return mapper.getList();
	}
	
}
