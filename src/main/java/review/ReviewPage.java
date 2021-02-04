package review;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;
import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class ReviewPage extends PageVO {
	List<ReviewVO> list;
}
