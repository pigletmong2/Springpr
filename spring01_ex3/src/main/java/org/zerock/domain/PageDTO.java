package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev,next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri,int total) {
		this.cri=cri;
		this.total=total;
		
		this.endPage=(int)(Math.ceil(cri.getPageNum()/10.0))*10;
//		math.ceil() 소수점을 올림으로 처리,ex)1페이지:Math.ceil(0.1)*10=10/11페이지:Math.ceil(2)*20=20
		
		this.startPage=this.endPage-9;
		
		int realEnd=(int)(Math.ceil((total*1.0)/cri.getAmount()));
		if(realEnd<this.endPage) {
			this.endPage=realEnd;
		}
//		endPage는 total에 의해서 영향을 밤음. ex)10개씩 보여주는 경우 total이 80개면, endPage는 10이 아닌 8이 되야함
//		만약 endPage와 한페이지당 출력되는 amount의 곱이 total보다 크면 endPage는 다시 total을 이용해서 계산되야함
		
		this.prev=this.startPage>1;
		
		this.next=this.endPage<realEnd;
	}
}
