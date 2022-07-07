package com.test.toy.etc; //07.07

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class Ex01 {

	public static void main(String[] args) {
		
		
		try {
			
			//Document > 해당 URL의 페이지 소스 내용을 전부 담고 있는 객체
			Document doc = Jsoup.connect("https://en.wikipedia.org/wiki/Main_Page").get();
			
			//System.out.println(doc.html()); > 그 페이지의 HTML이 콘솔에 찍힘.
			
			
			//id="In_the_news" > Id를 입력하면 그 대상을 가져옴.
			Elements list = doc.select("#In_the_news");
			
			System.out.println(list.get(0).text()); 
			
			//list.get(0)이 바로 span태그임. 
			
			
			
			
			
		} catch (Exception e) {
			System.out.println("Ex01.main");
			e.printStackTrace();

		}
		
	}
}
