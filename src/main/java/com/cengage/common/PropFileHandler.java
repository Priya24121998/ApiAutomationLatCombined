package com.cengage.common;


import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

import com.cengage.b2b.placeOrderApplication.OrderPlacementController;
import com.cengage.b2c.placeOrderApplication.OrderPlacementControllerB2C;

public class PropFileHandler {
	public static Properties config = new Properties();
	public static Properties testData = new Properties();
	public static PropertiesConfiguration write;
	public static String tier;
	
	public PropFileHandler() {
		tier = System.getProperty("tier");
		FileInputStream configReader = null;
		try {
			configReader = new FileInputStream("src/test/resources/TestData/config.properties");
			try {
				try {
					config.load(configReader);
				} catch (NullPointerException e) {
					logMessage(e.getMessage());
				}
				if (tier == null || tier.isEmpty())
				{
				tier = OrderPlacementControllerB2C.environmentSelected;
				if (tier == null || tier.isEmpty())
				{
					tier = OrderPlacementController.environmentSelected;
				}
				logMessage("Environment: " + tier.toUpperCase());
				}
					//tier= "QA";
	
			} catch (IOException e) {
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			
			logMessage(e.getMessage());
		} finally {
			if (configReader != null) {
				try {
					configReader.close();
				} catch (NullPointerException | IOException e) {
					
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
	}
	public static String readProperty(String property) {
		String value;
		FileInputStream in = null;
		try {
			in = new FileInputStream("src/test/resources/TestData/" + tier + "_testData.properties");
			try {
				testData.load(in);
			} catch (IOException e) {
				
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			
			logMessage(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {

					
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
		value = testData.getProperty(property);
		return value;
	}

	private static void logMessage(String message) {
		System.out.println(message);
		
	}
	public static String readPayloads(String property) {
		String value;
		FileInputStream in = null;
		try {
			in = new FileInputStream("src/test/resources/TestData/Payloads.properties");
			try {
				testData.load(in);
			} catch (NullPointerException | IOException e) {
			
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
		
			logMessage(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (NullPointerException | IOException e) {

				
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
		value = testData.getProperty(property);
		return value;
	}
	
	public static void writeProperty(String property, String value) {
		FileInputStream in=null;
		try {
			in = new FileInputStream(
					"src/test/resources/TestData/" + tier + "_testData.properties");
			write = new PropertiesConfiguration(
					"src/test/resources/TestData/" + tier + "_testData.properties");

			try {
				testData.load(in);
				in.close();

				write.setProperty(property, value);
				write.save();

			} catch (IOException e) {
				
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			
			logMessage(e.getMessage());
		} catch (ConfigurationException e) {
			
			logMessage(e.getMessage());
		}finally
		{
			if(in!=null)
			{
				try {
					in.close();
				} catch (IOException e) {
				
					
					logMessage(e.getMessage());
				}
			}
			else
			{
				logMessage("File already closed");
			}
		}
	}

	public static String readConfigProperty(String property) {
		String value;
		value = config.getProperty(property);
		return value;
	}
	
	public static String readSKU_PlanID(String property) {
		String value;
		FileInputStream in = null;
		try {
			in = new FileInputStream("src/test/resources/TestData/SKUs.properties");
			try {
				testData.load(in);
			} catch (IOException e) {
				
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			
			logMessage(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {

					
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
		value = testData.getProperty(property);
		return value;
	}

	
}