package com.busanbank.card.busancrawler.service;

import com.busanbank.card.busancrawler.dto.CardInfoDTO;
//import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.List;

@Service
public class OtherBankCardCrawlerService {

    public CardInfoDTO crawlShinhanCard(String url) {
        //WebDriverManager.chromedriver().setup();

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless=new"); // 창 없이 실행
        WebDriver driver = new ChromeDriver(options);

        try {
            driver.get(url);
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

            // 카드명 (예: "신한카드 Hey Young 체크(먼작귀)")
            String cardName = wait.until(ExpectedConditions
                    .visibilityOfElementLocated(By.cssSelector("a.card_name")))
                    .getText().trim();

            // 혜택 리스트
            List<WebElement> benefitElements = driver.findElements(By.cssSelector("div.txt1"));
            StringBuilder benefits = new StringBuilder();
            for (WebElement el : benefitElements) {
                String text = el.getText().trim();
                if (!text.isEmpty()) {
                    benefits.append("- ").append(text).append("\n");
                }
            }

            // DTO 세팅
            CardInfoDTO dto = new CardInfoDTO();
            dto.setCardName(cardName);
            dto.setCardType("체크"); // 하드코딩된 카드타입 (필요시 파싱 가능)
            dto.setService(benefits.toString().trim());

            return dto;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            driver.quit();
        }
    }
}
