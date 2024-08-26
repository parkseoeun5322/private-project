package common;

import java.util.Date;

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
	private String comment_category;
	private int comment_nickname;
	private int comment_root;
	private int comment_step;
	private String comment_reply;
	
	private String comment_title;	//DB X
}
