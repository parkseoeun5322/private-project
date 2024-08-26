package common;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ScrapVO {
	private int scrap_no;
	private int scrap_boardNo;
	private String scrap_id;
	private Date scrap_date;
	private String scrap_title;
	private String scrap_category;
	
	private int scrap_rownum;		//DB X
	private String scrap_content;	//DB X
}
