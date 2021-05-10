package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}/* 생성자를 통해 기본값을 1페이지,10개로 지정하여 처리 */
	
	public Criteria(int pageNum,int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}
	
	public String[] getTypeArr() {
		return type==null?new String[] {}:type.split("");
	}/* 검색 조건이 각 글자(T,W,C)로 구성되어 있으므로 검색 조건을 배열로 만들어 한번에 처리함 */

//	public String getListLink() {
//		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
//				.queryParam("pageNum",this.pageNum)
//				.queryParam("amount",this.getAmount())
//				.queryParam("type",this.getType())
//				.queryParam("keyword",this.getKeyword());
//		
//		return builder.toUriString();
//	} /* UriComponentsBuilder=여러개의 파라미터들을 연결해서 URL의 형태로 만들어주는 기능
//	 		url을 만들어주면 리다이렉트를 하거나, <form>태그를 사용하는 상황을 최소화함
//	 		또한 한글 처리에 신경쓰지 않아도 됨*/
}
