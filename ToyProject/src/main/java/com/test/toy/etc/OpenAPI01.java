package com.test.toy.etc;

// 네이버 검색 API 예제 - blog 검색
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class OpenAPI01 {

	
	public static void main(String[] args) {
	    String clientId = "avZEcWErPH3lu3dT8e_Z"; //애플리케이션 클라이언트 아이디값"
	    String clientSecret = "ueREVIOJX6"; //애플리케이션 클라이언트 시크릿값"
	
	
	    String text = null;
	    try {
	        text = URLEncoder.encode("wkqk", "UTF-8");
	    } catch (UnsupportedEncodingException e) {
	        throw new RuntimeException("검색어 인코딩 실패",e);
	    }
	
	    
	    // json 결과
	    String apiURL = "https://openapi.naver.com/v1/search/book.json?query=" + text; 
	    
	    // xml 결과
	    //String apiURL = "https://openapi.naver.com/v1/search/book.xml?query="+ text; 
	
	
	    Map<String, String> requestHeaders = new HashMap<>();
	    requestHeaders.put("X-Naver-Client-Id", clientId);
	    requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	    String responseBody = get(apiURL,requestHeaders);
	
	
	    //System.out.println(responseBody);
	    //JAVA <> JavaScript
	    //JSON > 자바 자료형 변환
	    
	  //  try {
			
	    //	JSONParser parser = new JSONParser();
	    	
	   // 	JSONObject obj = (JSONObject)parser.parse(responseBody);
	    	
	    	//System.out.println(obj.get("total"));
	    	
	    //	JSONArray list = (JSONArray)obj.get("items");
	    	
	    	//for (JSONObject item : list) {
	    		
	    //		System.out.println(((JSONObject)item).get("title"));
	    //	}
	    	
	    	
	//	} catch (Exception e) {
	//		System.out.println("OpenAPI01.main");
		//	e.printStackTrace();

	//	}
	    
	    
	    
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
	    HttpURLConnection con = connect(apiUrl);
	    try {
	        con.setRequestMethod("GET");
	        for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	            con.setRequestProperty(header.getKey(), header.getValue());
	        }
	
	
	        int responseCode = con.getResponseCode();
	        if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	            return readBody(con.getInputStream());
	        } else { // 에러 발생
	            return readBody(con.getErrorStream());
	        }
	    } catch (IOException e) {
	        throw new RuntimeException("API 요청과 응답 실패", e);
	    } finally {
	        con.disconnect();
	    }
	}
	
	
	private static HttpURLConnection connect(String apiUrl){
	    try {
	        URL url = new URL(apiUrl);
	        return (HttpURLConnection)url.openConnection();
	    } catch (MalformedURLException e) {
	        throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	    } catch (IOException e) {
	        throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	    }
	}
	
	
	private static String readBody(InputStream body){
	    InputStreamReader streamReader = new InputStreamReader(body);
	
	
	    try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	        StringBuilder responseBody = new StringBuilder();
	
	
	        String line;
	        while ((line = lineReader.readLine()) != null) {
	            responseBody.append(line);
	        }
	
	
	        return responseBody.toString();
	    } catch (IOException e) {
	        throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	    }
	}
}


