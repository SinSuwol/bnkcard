package com.busanbank.card.busancrawler.service;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class BnkCrawlerService {

    public String crawlBusanBank() {
        System.setProperty("webdriver.chrome.driver", "D:\\chrome\\chromedriver-win64\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();

        // User-Agent 변경
        options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                + "AppleWebKit/537.36 (KHTML, like Gecko) "
                + "Chrome/138.0.7204.97 Safari/537.36");

        // Headless 제거
        // options.addArguments("--headless=new");

        // 자동화 탐지 방지 옵션
        options.setExperimentalOption("excludeSwitches", new String[]{"enable-automation"});
        options.setExperimentalOption("useAutomationExtension", false);

        WebDriver driver = new ChromeDriver(options);

        try {
            driver.get("https://www.busanbank.co.kr/ib20/mnu/FPMCRD012001002");

            System.out.println(driver.getCurrentUrl());
            System.out.println(driver.getPageSource());

            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
            WebElement el = wait.until(ExpectedConditions.visibilityOfElementLocated(
                    By.cssSelector("p.item-detail-tit")
            ));

            System.out.println("카드명: " + el.getText());

            return "크롤링 성공! 카드명: " + el.getText();

        } catch (Exception e) {
            e.printStackTrace();
            return "크롤링 실패: " + e.getMessage();
        } finally {
            driver.quit();
        }
    }
}
