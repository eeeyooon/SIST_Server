package com.test.toy; //06.28

import lombok.Data;
//lombok은 따로 Getter,Setter를 안만들어줘도 어노테이션만 사용하면 됨.

@Data

/*
  @Data는 밑에 3개 포함함.
  
  @Getter
  @Setter
  @ToString
 */
public class Student {
	
	private String name;
	private String age;
	private String address;
	
	
	
}
