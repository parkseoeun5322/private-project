package common;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class BoardCommentPage extends PageVO {
	List<BoardCommentVO> list;
}
