package bulpan;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatVO implements Serializable {
	private String chatting_id;
	private int chatting_no;
	private	String chatting_writer;
	private	String chatting_content;
	private Date chatting_time;		// yy/MM/dd HH/mm/ss
	private String chatting_date;	// DB에 X : yyMM/dd
	private int chatting_roomNo;
	private int chatting_nickName;
	private String chatting_title;	// DB에 X
}
