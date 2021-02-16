package shopping;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class ShoppingVO {
	private int shopping_no;
	private String board_category;
	private String shopping_title;
	private String shopping_content;
	private String shopping_header;
	private String shopping_division;
	private String shopping_writer;
	private Date shopping_writedate;
	private int shopping_readcnt;
	private int shopping_pushcnt;
	private int shopping_scrapcnt;
	
	private int shopping_rownum;		//DB X
	private int shopping_commentcnt;	//DB X
}
