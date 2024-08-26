package bluray;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BlurayVO {
	private int bluray_no;
	private String board_category;
	private String bluray_title;
	private String bluray_content;
	private String bluray_header;
	private String bluray_division;
	private String bluray_writer;
	private Date bluray_writedate;
	private int bluray_readcnt;
	private int bluray_pushcnt;
	private int bluray_scrapcnt;
	
	private int bluray_rownum;		//DB X
	private int bluray_commentcnt;	//DB X
}
