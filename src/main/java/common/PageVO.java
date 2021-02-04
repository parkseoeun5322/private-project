package common;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageVO {
	private int pageList = 10;		//페이지 당 보여질 목록 수
	private int blockPage = 10;		//블럭 당 보여질 페이지 수
	private int totalList;			//총 목록 수
	
	private int totalPage;			//총 페이지 수
	// 512건 : 512 / 10 = 51...2		나머지가 있으면 한 페이지 추가
	
	private int totalBlock;			//총 블럭 수
	// 52페이지: 52/10 = 5...2		나머지가 있으면 한 블럭 추가
	
	private int curPage;				//현재 페이지
	
	//현재 페이지에 보여질 목록 시작과 끝
	private int beginList, endList;
	
	//현재 블럭에 보여질 페이지 시작과 끝
	private int curBlock, beginPage, endPage;
	
	private String search, keyword;		//검색 조건, 검색어
	
	private String header;		//말머리
	private String division;	//분류
	
	public void setTotalList(int totalList) {
		this.totalList = totalList;
		
		//DB에서 조회해온 총 목록 수에 따라 총 페이지 수가 결정됨
		totalPage = totalList / pageList;
		if(totalList % pageList > 0) ++totalPage;
		
		//총 페이지 수에 따라 총 블럭 수가 결정됨
		totalBlock = totalPage / blockPage;
		if(totalPage % blockPage > 0) ++totalBlock;
		
		//현재 페이지에 따라 보여질 목록의 번호가 결정됨
		//512건: 1페이지: 503 - 512
		//		2페이지: 493 - 502
		//		3페이지: 483 - 492
		endList = totalList - (curPage - 1) * pageList;	//512, 502, 492
		beginList = endList - (pageList - 1);
		
		//현재 블럭에 따라 보여질 페이지 번호가 결정됨
		curBlock = curPage / blockPage;
		if(curPage % blockPage > 0) ++curBlock;
		
		//1블럭: 1페이지 - 10페이지
		//2블럭: 11페이지 - 20페이지
		//3블럭: 21페이지 - 30페이지
		endPage = blockPage * curBlock;
		beginPage = endPage - (blockPage - 1);
		
		//512개의 글 > 52페이지 : 6블럭
		//5블럭: 41  50
		//6블럭: 51, 52 (53부터 60까지는 안보여야 함)
		//endPage는 총 페이지 수 보다 클 수 없다.
		if(endPage > totalPage) endPage = totalPage;
	}
	
}
