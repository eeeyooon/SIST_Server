package com.test.toy.etc;

import java.util.concurrent.TimeUnit;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class Ex04 {

	public static void main(String[] args) throws Exception {
		
		//Ex04.java
		
		
		/*
		 
		  	Jsoup 방식
		  	- 인증이 불필요한 페이지에서 사용 가능
		  	- 인증이 필요한 페이지에서 사용 불가능 > 고비용
		  	- JavaScript 실행이 필요한 페이지에서 사용 불가능 > Ajax 페이지
		  	
		  	웹 응용 프로그램 자동화 프로그램
		  	- 셀레니움
			- 사람 대신에 프로그램이 사람처럼 웹 사이트에 방문해서 여러가지 행도을 하는 프로그램
			- 클로링 작업도 가능함.
			- 인증이 필요한 페이지에서 사용 가능
			- JavaScript 실행이 필요한 페이지에서 사용 가능
			- 준비물 > 드라이버 > 브라우저 종류 + 버전
			
			
		  
		 */
		
		
		//m1();
		//m2();
		m3();
		
	}

	private static void m3() throws Exception {

		String webDriverID = "webdriver.chrome.driver";
		String path = "C:\\class\\chromedriver.exe";
		
		System.setProperty(webDriverID, path);
		
		ChromeOptions options = new ChromeOptions();
	    options.setCapability("ignoreProtectedModeSettings", true);
		
	    
	    WebDriver driver = new ChromeDriver(options);
		
	    String url = "http://lms1.sist.co.kr/worknet/SLogin.asp";
	    
	    driver.get(url);
	    
	    
	    //아이디 텍스트
	    WebElement id = driver.findElement(By.id("strLoginID"));
	    id.sendKeys("강경원"); //타이핑하듯 키보드 입력
	    
	    //비밀번호 텍스트
	    WebElement pwd = driver.findElement(By.id("strLoginPwd"));
	    pwd.sendKeys("2516"); //타이핑하듯 키보드 입력
	    
	    //로그인버튼
	    WebElement btn = driver.findElement(By.cssSelector(".login-btn > input"));
	    btn.click();
	    
	    
	    try {
	         WebElement eID = new  WebDriverWait(driver, 10).until( 
	               ExpectedConditions.visibilityOfElementLocated(By.cssSelector("#content tr:nth-child(5) > td:nth-child(2)")) );
	         
	         System.out.println("나의 교육 기간: " + eID.getText());

	      } catch (Exception e) {
	         System.out.println("> 오류 발생 + " + e.toString());
	      }
	    
	    
//	    driver.manage().timeouts().implicitlyWait(3000, TimeUnit.SECONDS);
//	    
//	    
//	    WebElement td = driver.findElement(By.cssSelector("#content > div > div > div > div.panel-body > form > table > thead > tr:nth-child(5) > td:nth-child(2)"));
//	    
//	    System.out.println("나의 교육 기간: " + td.getText());
	    
	    
	}

	private static void m2() {
		
		String webDriverID = "webdriver.chrome.driver";
		String path = "C:\\class\\chromedriver.exe";
		
		System.setProperty(webDriverID, path);
		
		//client-combined-3.141.59.jar
		ChromeOptions options = new ChromeOptions();
	    options.setCapability("ignoreProtectedModeSettings", true);
		
	    
	    //
	    WebDriver driver = new ChromeDriver(options);
	    
	    String url = "http://localhost:8090/toy/etc/expage.do";
	    
	    driver.get(url);
	    
	    //chrome에 의해서 위 주소가 열림. > "chrome이 자동화 된 소프트웨어에 의해
	    
	    WebElement name = driver.findElement(By.id("name"));
		//이게 태그 하나, 그 태그의 PCDATA를 가져옴.
	    
	    System.out.println(name.getText()); //이제 "아무개"도 콘솔 출력 (가져올 수 있음.)
	    //
		
	}

	private static void m1() throws Exception {
		
		String url = "http://localhost:8090/toy/etc/expage.do";
		
		Document doc = Jsoup.connect(url).get();
		
		//페이지 검사에서 원하는 태그 오른쪽 버튼 selector 복사 > 단일 찾기 
		Elements span = doc.select("body > main > section > div > span");
		
		System.out.println(span.text());
		
		Elements span2 = doc.select("#name"); //이건 못 읽어옴.(자바스크립트로 만든 객체를 못불러옴.)
		
		System.out.println(span2.text());
		
		
		
	}
}
