package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
//실행안됨@RequestMapping(value="/board/*",method={RequestMethod.GET,RequestMethod.POST})
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
//	@GetMapping("/list")
//	public void list(Model model) { /* 게시물(boardvo)의 목록을 model에 담아서 전달 */
//		log.info("list");
//		model.addAttribute("list",service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list: "+cri);
		model.addAttribute("list",service.getList(cri));
		/* model.addAttribute("pageMaker",new PageDTO(cri,123));
		 * list()는 'pageMaker'라는 이름으로 dto클래스에서 객체를 만들어 model에 담음 123은 dto구성을 위해서는 전체데이터
		 * 수가 필요한데 아직 그 처리가 이뤄지지 않았으므로 임의의값임
		 */
		
		int total=service.getTotal(cri);
		
		log.info("total: "+total);
		
		model.addAttribute("pageMaker",new PageDTO(cri,total));
		/* 전체 데이터 수를 계산해서 페이지 수를 구성함 */
	}
	
//	Post방식으로 처리되는 데이터를 boardVO 타입의 인스턴스로 바인딩해서 메서드에서 활용
//	boardservice를 이용해 등록처리
//	'redirect:'를 이용해서 다시 목록으로 이동
	@PostMapping("/register")
	public String register(BoardVO board,RedirectAttributes rttr) {
		log.info("register: " +board);
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		return "redirect:/board/list";
	}
	
//	게시물 등록작업은 post로 처리하지만 화면에서 입력을 받아야 하므로 get 방식으로 입력페이지를 볼 수 있도록
//	BoardController에 GetMapping 메서드 추가
	@GetMapping("/register")
	public void register() {}
	
	@GetMapping({"/get","/modify"}) /* /modify 추가 */
	/* @ModelAttribute: 자동으로 Model에 데이터를 지정한 이름으로 담아줌 */
	public void get(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri,Model model){
		log.info("/get or modify");
		model.addAttribute("board",service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		log.info("modify:"+board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		/* url뒤 원래의 페이지로 이동하기 위함 */
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		/*수정삭체 처리는 redirect방식으로 동작하므로 type과 keyword조건을 포함시켜야함*/
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		/* getListLink를 이용하면 위의 내용 생략 가능 */
		return "redirect:/board/list";
	}
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		log.info("remove..."+bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}
}
