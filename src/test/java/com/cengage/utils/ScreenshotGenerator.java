/*
 * Author: Ekansh Jain
 */

package com.cengage.utils;

import com.cengage.Runner.BaseClass;

import cucumber.api.Scenario;

import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;






public class ScreenshotGenerator extends BaseClass {
	static WebDriver driverget;

	@SuppressWarnings("static-access")
	public ScreenshotGenerator(WebDriver webDriver) {
		this.driverget = webDriver;
	}

	public static void before(Scenario scenario) {
		scenarioName = scenario.getName();
		logMessage("--------------------------------------------------------------------------");
		logMessage("STARTING SCENARIO - " + scenarioName);
		logMessage("--------------------------------------------------------------------------");
	}

	@SuppressWarnings("deprecation")
	public static void after(cucumber.api.Scenario scenario) {
		scenarioStatus = scenario.getStatus().toString();
		if (scenario.isFailed()) {
			takeScreenshot(scenario);
		}
		logMessage("--------------------------------------------------------------------------");
		logMessage("SCENARIO RESULT: " + scenario.getName() + " : " + scenario.getStatus());
		logMessage("--------------------------------------------------------------------------");
	}

	@SuppressWarnings("deprecation")
	public static void takeScreenshot(cucumber.api.Scenario scenario) {
		try {
			final byte[] screenshot = ((TakesScreenshot) driverget).getScreenshotAs(OutputType.BYTES);
			scenario.embed(screenshot, "image/png");
		} catch (RuntimeException e) {
			logMessage("Exception caught during screenshot generation");
		}
	}
}
