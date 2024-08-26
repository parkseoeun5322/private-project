package common;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class ScrapPage extends PageVO {
	List<ScrapVO> list;
}
