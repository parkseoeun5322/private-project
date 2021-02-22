package mypage;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
	private int board_no;
	private String board_category;
	private String board_title;
	private Date board_writedate;
	private int board_rownum;
}
