package common;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardCommentVO {
	private int comment_no;
	private int comment_bno;
	private String comment_writer;
	private String comment_content;
	private Date comment_writedate;
	private String comment_writetime;
	private String comment_category;
}
