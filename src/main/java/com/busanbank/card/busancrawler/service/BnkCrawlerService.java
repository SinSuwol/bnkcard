package com.busanbank.card.busancrawler.service;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.time.Duration;
import org.springframework.stereotype.Service;

@Service
public class BnkCrawlerService {

    public String crawlBusanBank() {
        System.setProperty("webdriver.chrome.driver", "D:\\chrome\\chromedriver-win64\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                + "AppleWebKit/537.36 (KHTML, like Gecko) "
                + "Chrome/138.0.7204.97 Safari/537.36");
        options.setExperimentalOption("excludeSwitches", new String[]{"enable-automation"});
        options.setExperimentalOption("useAutomationExtension", false);

        WebDriver driver = new ChromeDriver(options);

        try {
            driver.get("https://www.busanbank.co.kr/ib20/mnu/FPMCRD012001002");

            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));

            WebElement cardType = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    By.cssSelector("h3.tit-type1")
            ));

            WebElement cardName = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    By.cssSelector("div.item-detail-t > p.item-detail-tit")
            ));

            String result = "카드 타입: " + cardType.getText()
                    + "\n카드명: " + cardName.getText();

            return result;

        } catch (Exception e) {
            e.printStackTrace();
            return "크롤링 실패: " + e.getMessage();
        } finally {
            driver.quit();
        }
    }
}

