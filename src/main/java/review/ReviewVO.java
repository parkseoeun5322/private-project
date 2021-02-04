package review;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewVO {
	private int review_no;
	private String board_category;
	private String review_title;
	private String review_content;
	private String review_header;
	private String review_division;
	private String review_writer;
	private Date review_writedate;
	private int review_readcnt;
	private int review_pushcnt;
	private String review_filename;
	private String review_filepath;
	private int review_scrapcnt;
	
	private int review_rownum;	//DB X
}
