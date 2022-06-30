package com.test.toy.board; //06.28

import lombok.Data;

@Data
public class BoardDTO {
	
	
	private String seq;
	private String subject;
	private String content;
	private String id;
	private String regdate;
	private String readcount;
	
	private String name;
	private String commentcount;
	
	
	//답변쓰기
	private int thread;
	private int depth;
	
	
}
