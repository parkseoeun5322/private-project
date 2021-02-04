package bulpan;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BulpanVO {
	private int bulpan_no;
	private String board_category;
	private String bulpan_title;
	private String bulpan_content;
	private String bulpan_header;
	private String bulpan_division;
	private String bulpan_writer;
	private Date bulpan_writedate;
	private int bulpan_readcnt;
	private int bulpan_pushcnt;
	private String bulpan_filename;
	private String bulpan_filepath;
	
	private int bulpan_rownum;	//DB X
}
