package com.cengage.b2b.placeOrderApplication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.cengage.b2b.orderrepository")
@EntityScan(basePackages = "com.cengage.b2b.orderrepository")
public class PlaceOrderWebApplication {

	public static void main(String[] args) {

		SpringApplication.run(PlaceOrderWebApplication.class, args);
	}

}
