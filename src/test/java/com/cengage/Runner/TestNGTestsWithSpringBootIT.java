package com.cengage.Runner;

import java.io.IOException;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.cengage.Runner.BaseClass;
import com.cengage.b2b.placeOrderApplication.PlaceOrderWebApplication;
import com.cengage.utils.ZephyrIntegration;
import com.cengage.pageactions.YamlPageActions;

import example.TestNGWithSpringApplication;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;



@SpringBootTest(classes = PlaceOrderWebApplication.class)
@CucumberOptions(
		features= {"src/test/resources/FeatureFiles"},
		glue = {"com.cengage.stepdefs"},
		tags = "@B2C_CA_Carts",
		plugin = {"io.qameta.allure.cucumber4jvm.AllureCucumber4Jvm","json:target/cucumber/report.json" , "html:target/site/cucumber-pretty"})

public class TestNGTestsWithSpringBootIT extends AbstractTestNGCucumberTests {

	BaseClass base=new BaseClass();
	YamlPageActions obj = new YamlPageActions();
	ZephyrIntegration zephyr = new ZephyrIntegration();

	@BeforeClass
	public void intiateSession() throws IOException {

		base.initializeBrowser();
		obj.clearYamlFileContent("placeOrder.yaml");

	}
	@Test
	 public void runCucumber() {
	        
	}


	@AfterMethod
	public void updateJira()
	{
		ZephyrIntegration.updateJira();

	}


	@AfterClass
	public void closeSession()
	{
		base.quitSession();
	}
}