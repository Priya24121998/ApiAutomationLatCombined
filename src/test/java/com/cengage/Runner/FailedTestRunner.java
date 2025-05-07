package com.cengage.Runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;




@CucumberOptions(
		features= {"@target/rerun.txt"},
		glue = {"com.cengage.stepdefs"}, 
		tags = "@sapecomm-9783",
		plugin = {"io.qameta.allure.cucumber4jvm.AllureCucumber4Jvm","json:target/cucumber/report.json" , "html:target/site/cucumber-pretty"})

public class FailedTestRunner extends AbstractTestNGCucumberTests
{
	
}

