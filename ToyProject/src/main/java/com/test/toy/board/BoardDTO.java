package com.test.toy.board; //06.28

import java.util.ArrayList;

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
	
	
	private double isnew;
	
	
	//파일 업로드
	private String filename;
	private String orgfilename;
	
	
	//해시태그들을 넣을 예정
	private ArrayList<String> taglist;
	
	
	//좋아요싫어요
	private String good;
	private String bad;
	private String goodbad;
	

	
	
	
}
