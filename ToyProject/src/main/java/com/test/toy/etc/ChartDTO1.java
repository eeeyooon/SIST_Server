package com.test.toy.etc;

import lombok.Data;

@Data
public class ChartDTO1 {
	
	
	//BoardDTO는 모두 개인데이터이고 밑에 chart에 쓸 데이터는 집합데이터임.
	//그래서 별도의 DTO를 만들어주는게 좋음 > 성격이 다르니까(DTO는 성격에 따라 구분하는게 좋아)
	//chart
	
	private String id;
	private String name;
	private String cnt;
}
