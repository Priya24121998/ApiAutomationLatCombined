package com.cengage.common;

import java.io.*;
import java.util.Properties;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.springframework.core.io.ClassPathResource;

public class PropFileHandler {
    public static Properties config = new Properties();
    public static Properties testData = new Properties();
    public static PropertiesConfiguration write;
    public static String tier;

    public PropFileHandler() {
        tier = "QA"; // Default tier
        try (InputStream configReader = getClass().getClassLoader().getResourceAsStream("TestData/config.properties")) {
            if (configReader != null) {
                config.load(configReader);
            } else {
                logMessage("config.properties not found in classpath.");
            }
        } catch (IOException e) {
            logMessage(e.getMessage());
        }
    }

    public static String readProperty(String property) {
        String value = null;
        try (InputStream in = getClassLoaderResource("TestData/" + tier + "_testData.properties")) {
            if (in != null) {
                testData.load(in);
                value = testData.getProperty(property);
            } else {
                logMessage("Test data file not found.");
            }
        } catch (IOException e) {
            logMessage(e.getMessage());
        }
        return value;
    }

    public static String readPayloads(String property) {
        String value = null;
        try (InputStream in = getClassLoaderResource("TestData/Payloads.properties")) {
            if (in != null) {
                testData.load(in);
                value = testData.getProperty(property);
            } else {
                logMessage("Payloads.properties not found.");
            }
        } catch (IOException e) {
            logMessage(e.getMessage());
        }
        return value;
    }

    public static void writeProperty(String property, String value) {
        String externalPath = System.getProperty("external.config.path");
        if (externalPath == null) {
            logMessage("System property 'external.config.path' not set.");
            return;
        }

        File file = new File(externalPath, tier + "_testData.properties");
        try {
            write = new PropertiesConfiguration(file);
            write.setProperty(property, value);
            write.save();
        } catch (ConfigurationException e) {
            logMessage("Failed to write property: " + e.getMessage());
        }
    }

    public static String readConfigProperty(String property) {
        return config.getProperty(property);
    }

    public static String readSKU_PlanID(String property) {
        String value = null;
        try (InputStream in = getClassLoaderResource("TestData/SKUs.properties")) {
            if (in != null) {
                testData.load(in);
                value = testData.getProperty(property);
            } else {
                logMessage("SKUs.properties not found.");
            }
        } catch (IOException e) {
            logMessage(e.getMessage());
        }
        return value;
    }

    private static InputStream getClassLoaderResource(String path) {
        return PropFileHandler.class.getClassLoader().getResourceAsStream(path);
    }

    private static void logMessage(String message) {
        System.out.println(message);
    }
}
