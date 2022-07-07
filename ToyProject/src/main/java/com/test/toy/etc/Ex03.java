package com.test.toy.etc; //07.07

import java.util.Arrays;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Ex03 {

	public static void main(String[] args) throws Exception {
		
		String url = "https://movie.naver.com/movie/running/current.naver";
		
		Document doc = Jsoup.connect(url).get();
		
		Elements list = doc.select("#content .lst_detail_t1 > li");
		
		
		EtcDAO dao = new EtcDAO();
		
		for (Element item : list) {
			
			//item == <li>
			
			//영화 제목
			String title = item.select(".tit > a").text(); //<li> 태그 이하에서만 검색해라
			
			//System.out.println(title);
			
			//개요(장르)
			String category = item.select(".info_txt1 dd:nth-child(2) .link_txt").text();
			//System.out.println(category);
			
			
			String dd = item.select(".info_txt1 dd:nth-child(2)").text();
			//System.out.println(dd); //드라마, 미스터리 | 135분 | 1995.03.25 개봉
			
			//split으로 자르기
			
			String[] temp = dd.split("\\|");
			
			//덤프
			//System.out.println(Arrays.toString(temp));
			
			//상영 시간
			String time = "";
			
			//개봉일
			String rdate = "";
			
			if (temp.length == 3) {
				time = temp[1].replace("분","").trim();
				rdate  = temp[2].replace(" 개봉", "").trim();
				
			} else if (temp.length == 2) {
				time = temp[0].replace("분","").trim();
				rdate  = temp[1].replace(" 개봉", "").trim();
			}
			
			//System.out.println(rdate);
			
			//감독
			String director = item.select(".info_txt1 dd:nth-child(4) span").text();
			
			//출연
			String actor = item.select(".info_txt1 dd:last-child span").text();
			//System.out.println(actor);
			
			//포스터
			String poster = item.select(".thumb img").attr("src");
			//System.out.println(poster);
			
			MovieDTO dto = new MovieDTO();
			
			dto.setTitle(title);
			dto.setCategory(category);
			dto.setTime(time);
			dto.setRdate(rdate);
			dto.setDirector(director);
			dto.setActor(actor);
			dto.setPoster(poster);
			
			System.out.println(dao.addMovie(dto));
			
		}
		
	}
}
