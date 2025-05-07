package com.cengage.utils;


import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

import com.cengage.Runner.BaseClass;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Set;

public class PropFileHandler extends BaseClass {
	public static Properties config = new Properties();
	public static Properties testData = new Properties();
	public static PropertiesConfiguration write;
	public static String tier;
	public static int i = 1;

	public PropFileHandler() {
		tier = System.getProperty("tier");
		FileInputStream configReader = null;
		try {
			configReader = new FileInputStream("src/test/resources/TestData/config.properties");
			try {
				try {
					config.load(configReader);
				} catch (NullPointerException e) {
					//e.printStackTrace();
					logMessage(e.getMessage());
				}
				if (tier == null || tier.isEmpty())
					tier = config.getProperty("tier");
				logMessage("Environment: " + tier.toUpperCase());
			} catch (IOException e) {
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} finally {
			if (configReader != null) {
				try {
					configReader.close();
				} catch (NullPointerException | IOException e) {
					//e.printStackTrace();
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
	}

	public static String readConfigProperty(String property) {
		String value;
		value = config.getProperty(property);
		return value;
	}

	public static String readProperty(String property) {
		String value;
		FileInputStream in = null;
		try {
			in = new FileInputStream("src/test/resources/TestData/" + tier.toUpperCase() + "_testData.properties");
			try {
				testData.load(in);
			} catch (IOException e) {
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {

					//e.printStackTrace();
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
		value = testData.getProperty(property);
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
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {

					//e.printStackTrace();
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
		value = testData.getProperty(property);
		return value;
	}

	public static List<String> readAllSKUsPlanIDKeys() {
		List<String> allKeys = new ArrayList<String>();
		FileInputStream in=null;
		try {
			 in = new FileInputStream("src/test/resources/TestData/SKUs.properties");
			try {
				testData.load(in);
			} catch (IOException e) {
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}finally
		{
			if(in!=null)
			{
			try {
				in.close();
			} catch (IOException e) {
				
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
			}
			else
			{
				logMessage("File already closed");
			}
		}
		Set<Object> keys = testData.keySet();
		for (Object str : keys)
			allKeys.add(str.toString());
		return allKeys;
	}

	public static void writeProperty(String property, String value) {
		FileInputStream in=null;
		try {
			in = new FileInputStream(
					"src/test/resources/TestData/" + tier.toUpperCase() + "_testData.properties");
			write = new PropertiesConfiguration(
					"src/test/resources/TestData/" + tier.toUpperCase() + "_testData.properties");

			try {
				testData.load(in);
				in.close();

				write.setProperty(property, value);
				write.save();

			} catch (IOException e) {
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} catch (ConfigurationException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		}finally
		{
			if(in!=null)
			{
				try {
					in.close();
				} catch (IOException e) {
				
					//e.printStackTrace();
					logMessage(e.getMessage());
				}
			}
			else
			{
				logMessage("File already closed");
			}
		}
	}

	public static void ErrorGuids(String property, String value) {
		FileInputStream in = null;
		try {
			in = new FileInputStream("src/test/resources/TestData/ErrorGuids.properties");
			write = new PropertiesConfiguration("src/test/resources/TestData/ErrorGuids.properties");

			try {
				testData.load(in);
				in.close();

				write.setProperty(property + i, value);
				write.save();
				i++;

			} catch (IOException e) {
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} catch (ConfigurationException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} finally {
			if(in!=null)
			{
              try {
				in.close();
			} catch (IOException e) {
				
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
			}
			else
			{
				logMessage("File already closed");
			}
		}
	}

	public static void clearErrorGuidFile() {
		PrintWriter pw = null;
		try {
			pw = new PrintWriter("src/test/resources/TestData/ErrorGuids.properties");
			pw.close();

		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} finally {

		}
	}

	@SuppressWarnings("rawtypes")
	public static List ReadErrorGuids() {
		List<String> content = new ArrayList<String>();
		Properties ErrorGuidData = new Properties();
		FileInputStream in = null;
		try {
			in = new FileInputStream("src/test/resources/TestData/ErrorGuids.properties");

			try {
				ErrorGuidData.load(in);
			} catch (IOException e) {
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (NullPointerException | IOException e) {

					//e.printStackTrace();
					logMessage(e.getMessage());
				}
			} else {
				logMessage("File already closed");
			}
		}
		// Printing all guids
//			for (Object key: ErrorGuidData.keySet()) {
//				logMessage(key + " : " + ErrorGuidData.getProperty(key.toString()));

		for (Object key : ErrorGuidData.keySet())
			content.add(ErrorGuidData.getProperty(key.toString()));
		return content;
	}

	public static String readPayloads(String property) {
		String value;
		FileInputStream in = null;
		try {
			in = new FileInputStream("src/test/resources/TestData/Payloads.properties");
			try {
				testData.load(in);
			} catch (NullPointerException | IOException e) {
				//e.printStackTrace();
				logMessage(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			//e.printStackTrace();
			logMessage(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (NullPointerException | IOException e) {

					//e.printStackTrace();
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