/**
 * The {@code PlaceOrderWebApplication} class serves as the entry point for the 
 * Place Order Web Application. This application is part of the B2B (Business-to-Business) 
 * system and is designed to handle order placement functionalities.
 *
 * <p>This class is responsible for initializing and configuring the application 
 * context, setting up necessary components, and starting the application.
 *
 * <p>Package: {@code com.cengage.b2b.placeOrderApplication}
 *
 * <p>Usage:
 * <pre>
 *     // To start the application, run the main method in this class.
 * </pre>
 *
 * @author Priyadharshini M
 * @version 1.0
 * @since 2025
 */
package com.cengage.b2b.placeOrderApplication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.cengage.b2b.orderrepository")
@EntityScan(basePackages = "com.cengage.b2b.orderrepository")
public class PlaceOrderWebApplication extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(PlaceOrderWebApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(PlaceOrderWebApplication.class, args);
    }
}
