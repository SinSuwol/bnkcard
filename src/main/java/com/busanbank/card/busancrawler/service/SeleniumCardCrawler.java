package com.busanbank.card.busancrawler.service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busanbank.card.busancrawler.dto.ScrapCardDto;
import com.busanbank.card.busancrawler.mapper.ScrapCardMapper;

@Service
public class SeleniumCardCrawler {
	
	@Autowired
	ScrapCardMapper scrapCardMapper ;
	
    public String crawlShinhanCards() {
    	
    	List<ScrapCardDto> cardList = new ArrayList<>();
    	
        System.setProperty("webdriver.chrome.driver", "C:/Users/GGG/Desktop/chromedriver-win64/chromedriver.exe");
        WebDriver driver = new ChromeDriver();

        try {
            String url = "https://www.shinhancard.com/pconts/html/card/check/MOBFM282R11.html?crustMenuId=ms527";
            driver.get(url);

            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));

            // 카드 리스트 로딩 대기
            wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".card_thumb_list_wrap li")));

            List<WebElement> cardItems = driver.findElements(By.cssSelector(".card_thumb_list_wrap li"));
            StringBuilder result = new StringBuilder();
//            result.append("총 카드 수: ").append(cardItems.size()).append("\n\n");

            for (int i = 0; i < 4; i++) {
                try {
                    // 카드 목록이 페이지 이동 시 사라지므로, 매번 새로 가져와야 함
                    cardItems = driver.findElements(By.cssSelector(".card_thumb_list_wrap li"));
                    WebElement card = cardItems.get(i);

                    String cardName = card.findElement(By.cssSelector(".card_name")).getText();
                    String imgUrl = card.findElement(By.cssSelector(".card_img_wrap img")).getAttribute("src");
                    String benefit = card.findElement(By.cssSelector(".benefit_wrap a")).getText();
                    String detailUrl = card.findElement(By.cssSelector(".card_name")).getAttribute("href");

                    // 상세페이지 이동
                    driver.navigate().to(detailUrl);
                    Thread.sleep(2000); // 또는 wait

                    String annualFee = "";
                    int fee = 0;
                    try {
                        WebElement feeElement = driver.findElement(By.cssSelector(".annual-fee li span:last-of-type"));
                        annualFee = feeElement.getText();
                        fee = Integer.parseInt(annualFee.replaceAll("[^0-9]", ""));
                    } catch (Exception e) {
                        annualFee = "연회비 정보 없음";
                        fee = 0;
                    }
                    
                    // 카드 데이터 저장
                    ScrapCardDto dto = new ScrapCardDto();
                    dto.setScCardName(cardName);
                    dto.setScCardUrl(detailUrl);
                    dto.setScCardSlogan("-"); // 슬로건 없으면 일단 빈값 or "미정"
                    dto.setScSService(benefit);
                    dto.setScAnnualFee(fee);
                    
                    cardList.add(dto);

                    // 결과 추가
                    result.append("카드명: ").append(cardName).append("\n");
                    result.append("이미지: ").append(imgUrl).append("\n");
                    result.append("혜택: ").append(benefit).append("\n");
                    result.append("연회비: ").append(annualFee).append("\n");
                    result.append("상세 URL: ").append(detailUrl).append("\n\n");

                    // 목록으로 돌아가기
                    driver.navigate().back();
                    wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".card_thumb_list_wrap li")));
                    Thread.sleep(1000);

                } catch (Exception e) {
                    result.append("카드 처리 중 오류: ").append(e.getMessage()).append("\n\n");
                }
            }
            
            if (!cardList.isEmpty()) {
                for (ScrapCardDto  card : cardList) {
                    scrapCardMapper.insertCard(card);  // 단건 insert
                }
                result.append("\n").append(cardList.size()).append("건 DB 저장 완료됨.");
                System.out.println("db저장 완료");
            }

            return result.toString();

        } catch (Exception e) {
        	System.out.println(e.getMessage());
            return "크롤링 실패: " + e.getMessage();
        } finally {
            driver.quit();
        }
    }
}
