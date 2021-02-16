package drama;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DramaBoardVO {
	private int drama_board_no;
	private String board_category;
	private String drama_board_title;
	private String drama_board_content;
	private String drama_board_header;
	private String drama_board_division;
	private String drama_board_writer;
	private Date drama_board_writedate;
	private int drama_board_readcnt;
	private int drama_board_pushcnt;
	private int drama_board_scrapcnt;
	
	private int drama_board_rownum;		//DB X
	private int drama_board_commentcnt;	//DB X
}
