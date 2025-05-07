package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.ExcelPageActions;
import com.cengage.pageactions.ExcelReadActions;
import com.cengage.utils.PropFileHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;


import java.io.IOException;


import static com.cengage.pageactions.ExcelPageActions.writeOrderDetInExcelB2B;


public class ExcelStepDef extends BaseClass {

    @Then("I will store the username and password details in the excel named {string}")
    public static void writeUserNameAndPassInExcel(String sheetName) throws IOException {
        ExcelPageActions.writeUserNameAndPassInExcel(sheetName);

    }

    @Then("Write the n user details stored in hashmap in the excel named {string}")
    public static void writeUserDetInExcelB2B(String sheetName)throws IOException  {
        noOfUsers = System.getProperty("numberOfUsers");
        if (noOfUsers == null || noOfUsers.isEmpty())
            noOfUsers = PropFileHandler.readConfigProperty("numberOfUsers");
        ExcelPageActions.writeUserDetInExcelB2B(sheetName,noOfUsers);
    }



    @And("Write the order {int} details stored in hashmap in the excel named {string} , of tab name {string} and of payment type {string}")
    public void writeTheOrderOrderDetailsStoredInHashmapInTheExcelNamedOfTabNameAndOfPaymentType(int n, String sheetName, String tabName, String paymentType) throws IOException {
        writeOrderDetInExcelB2B(n, sheetName,tabName,paymentType);
    }


    @Given("I will read data in the tab {string} of the excel named {string}")
    public void iWillReadDataInTheTabOfTheExcelNamed(String tabName, String excelFileName) throws IOException {
        ExcelReadActions.getDataFromExcel(tabName,excelFileName);
        ExcelReadActions.getDataInLinkedHashMap();
    }
}

