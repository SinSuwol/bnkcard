package com.busanbank.card;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.busanbank.card.admin.dao")
public class BnkCardApplication {

	public static void main(String[] args) {
		SpringApplication.run(BnkCardApplication.class, args);
	}

}
