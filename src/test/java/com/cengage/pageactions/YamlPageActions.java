package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class YamlPageActions extends BaseClass {
    public YamlPageActions() {
        super();
    }

    public void appendContentToYamlFile(String fileName)
    {
        String filePath = System.getProperty("user.dir")+System.getProperty("file.separator")+fileName;
        String contentToAppendOne = "Order: "+OrderID+"||";
        String contentToAppendTwo =  "UserGuid: "+userGUID+"||";
        String contentToAppendThree =  "UserId: "+userID+".";

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(contentToAppendOne);
            writer.write(contentToAppendTwo);
            writer.write(contentToAppendThree);
            writer.newLine();
            System.out.println("Content appended successfully.");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void clearYamlFileContent(String fileName) {
        String filePath = System.getProperty("user.dir")+System.getProperty("file.separator")+fileName;

        try (FileWriter fileWriter = new FileWriter(filePath)) {
            fileWriter.write("");
            System.out.println("Yaml File content cleared successfully before testing place order scenarios.");
        } catch (IOException e) {
            System.err.println("Exception occured: " + e.getMessage());
        }
    }
    }
