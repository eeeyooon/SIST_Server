package com.test.toy.etc;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Ex02 {
	
	public static void main(String[] args) throws Exception {
		//귀찮으니까 일단 예외 미루기 (정식 프로그램은 아니니까) 
		
		//Ex02.java
		
		System.out.println("[네이버 영화 랭킹]");
		
		String url = "https://movie.naver.com/movie/sdb/rank/rmovie.naver";
		
		Document doc = Jsoup.connect(url).get();
		
		//System.out.println(doc.title()); //랭킹 : 네이버 영화
		
		//원하는 정보의 태그, 클래스나 아이디 이름찾는게 가장 중요함.
		Elements list = doc.select(".tit3 > a");
		
		//System.out.println(list.size()); //50
		
		for (Element item : list) {
			System.out.println(item.text()); //PCDATA > 영화 제목 50개
			System.out.println(item.attr("href")); //속성 /movie/bi/mi/basic.naver?code=191646
		}
		
		
	}

}
