/**
 * The PlaceOrderB2CWebApplication class serves as the entry point for the 
 * Place Order B2C Web Application. This application is designed to handle 
 * the business logic and operations related to placing orders in a 
 * business-to-consumer (B2C) context.
 *
 * <p>It is part of the cu_e2e module and resides in the 
 * com.cengage.b2c.placeOrderApplication package. This class is typically 
 * responsible for initializing and configuring the application, as well as 
 * starting the necessary services to support the order placement process.
 *
 * <p>Ensure that all dependencies and configurations are properly set up 
 * before running this application.
 */
package com.cengage.b2c.placeOrderApplication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.cengage.b2b.placeOrderApplication.PlaceOrderWebApplication;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.cengage.b2c.orderrepository")
@EntityScan(basePackages = "com.cengage.b2c.orderrepository")
public class PlaceOrderB2CWebApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(PlaceOrderWebApplication.class);
	}

	public static void main(String[] args) {

		SpringApplication.run(PlaceOrderB2CWebApplication.class, args);
	}

}
