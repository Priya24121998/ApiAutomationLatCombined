package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.util.HashMap;

public class ExcelPageActions extends BaseClass {

    static XSSFWorkbook workbook = null;
    public ExcelPageActions() throws FileNotFoundException {
        super();
    }

    public static void writeUserNameAndPassInExcel(String sheetName) throws IOException {
        workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("userCreation");
        XSSFRow rowget;
        XSSFRow row;
        int rownumber = 0;
        rowget = sheet.createRow(rownumber);
        rowget.createCell(0).setCellValue("Username");
        rowget.createCell(1).setCellValue("Password");
        int rowno=1;
        for (HashMap.Entry<String,String> entry : userCreation.entrySet()) {
            row=sheet.createRow(rowno++);
            row.createCell(0).setCellValue((String)entry.getKey());
            row.createCell(1).setCellValue((String)entry.getValue());
        }
        try (FileOutputStream fileOut = new FileOutputStream(sheetName)) {
            workbook.write(fileOut);
            logMessage("Username and password details created are saved in "+sheetName+".");
        }

    }

    public static void writeUserDetInExcelB2B(String sheetName,String noOfUsers) throws IOException {
        workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("UserCreation_TabOne");
        XSSFRow row;
        int rowno = 0;
        for (HashMap.Entry<String, String> entry : userCreationDetMap.entrySet()) {
            row = sheet.createRow(rowno++);
            row.createCell(0).setCellValue((String) entry.getKey());
            row.createCell(1).setCellValue((String) entry.getValue());
        }
        try (FileOutputStream fileOut = new FileOutputStream(sheetName)) {
            workbook.write(fileOut);
            logMessage("Username and password details created are saved in " + sheetName + ".");
        }

        sheet = workbook.createSheet("UserCreation_Latest");
        XSSFRow rowget;
        int rownumber = 0;
        int rownumberAcc= 1;
        int noOfUsersCount = Integer.parseInt(noOfUsers);
        rowget = sheet.createRow(rownumber++);
        rowget.createCell(0).setCellValue("Username");
        rowget.createCell(1).setCellValue("Password");
        rowget.createCell(2).setCellValue("Account");
        String[] usernameArr = new String[noOfUsersCount];
        String[] passwordArr = new String[noOfUsersCount];
        String[] accountArr = new String[noOfUsersCount];
        int i=0;
        int j=0;
        int k=0;
        for (HashMap.Entry<String, String> entry : userCreationDetMap.entrySet()) {
            if (entry.getKey().contains("username "+i)) {
                usernameArr[i] = entry.getValue();
                i=i+1;
            }
            else if (entry.getKey().contains("password "+j)) {
                passwordArr[j] = entry.getValue();
                j=j+1;
            }
            else if (entry.getKey().contains("account "+k)) {
                accountArr[k] = entry.getValue();
                k=k+1;
            }

        }

        for (int no=0;no<Integer.parseInt(noOfUsers);no++) {
            rowget= sheet.createRow(rownumberAcc);
            rowget.createCell(0).setCellValue(userCreationDetMap.get("username "+no));
            rowget.createCell(1).setCellValue("Password1");
            rowget.createCell(2).setCellValue(userCreationDetMap.get("account "+no));
            rownumberAcc = rownumberAcc+1;
        }

        try (FileOutputStream fileOut = new FileOutputStream(sheetName)) {
            workbook.write(fileOut);
            logMessage("Username and password details created are saved in " + sheetName + ".");
        }

    }

    public static void writeOrderDetInExcelB2B( int n,String sheetName,String tabName,String paymentType) throws IOException {
        XSSFSheet sheet;
        workbook = new XSSFWorkbook();
        sheet = workbook.createSheet(tabName);
        XSSFRow row;
        row = sheet.createRow(0);
        row.createCell(0).setCellValue("Username");
        row.createCell(1).setCellValue("BaseStore");
        row.createCell(2).setCellValue("AccountBillTo");
        row.createCell(3).setCellValue("AccountShipTo");
        row.createCell(4).setCellValue("AccountType");
        row.createCell(5).setCellValue("PaymentType");
        row.createCell(6).setCellValue("Delivery Mode");
        row.createCell(7).setCellValue("Promo Code");
        row.createCell(8).setCellValue("Order");

        int rownumber = 1;
        for (int i = 1; i <= n; i++) {
            row = sheet.createRow(rownumber++);
            row.createCell(0).setCellValue(placeOrderDetMap.get("User" + i));
            row.createCell(1).setCellValue(placeOrderDetMap.get("storeType" + i));
            row.createCell(2).setCellValue(placeOrderDetMap.get("accountBillTo" + i));
            row.createCell(3).setCellValue(placeOrderDetMap.get("accountShipTo" + i));
            row.createCell(4).setCellValue(placeOrderDetMap.get("accountType" + i));
            row.createCell(5).setCellValue(placeOrderDetMap.get("PaymentType" + i));
            row.createCell(6).setCellValue(placeOrderDetMap.get("deliveryMode" + i));
            if(placeOrderDetMap.get("couponCode" + i) != null) {
                row.createCell(7).setCellValue(placeOrderDetMap.get("couponCode" + i));
            }
            else
            {
                row.createCell(7).setCellValue("No Promo code");
            }
            row.createCell(8).setCellValue(placeOrderDetMap.get("Order" + i));

        }
        try (FileOutputStream fileOut = new FileOutputStream(sheetName)) {
            workbook.write(fileOut);
            logMessage("Order details placed are saved in " + sheetName + ".");
        }


    }

}
