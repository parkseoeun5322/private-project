package shopping;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;
import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class ShoppingPage extends PageVO {
	List<ShoppingVO> list;
}
