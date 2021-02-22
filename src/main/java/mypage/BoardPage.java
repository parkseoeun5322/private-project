package mypage;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;
import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class BoardPage extends PageVO {
	List<BoardVO> list;
}
