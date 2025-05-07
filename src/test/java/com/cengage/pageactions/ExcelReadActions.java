package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static org.apache.poi.util.HexRead.readData;


public class ExcelReadActions extends BaseClass {

    static XSSFWorkbook workbook = null;
    static int totalRow;

    public ExcelReadActions() throws FileNotFoundException {
        super();
    }

    public static List<Map<String, String>> getDataFromExcel(String tab, String excelName) throws IOException {

        XSSFSheet sheetNo;
        String fs = System.getProperty("file.separator");
        String currDir = System.getProperty("user.dir");
        String filePath = currDir + fs + excelName;
        logMessage(filePath);
        File file = new File(filePath);

        try (FileInputStream fis = new FileInputStream(file)) {

            workbook = new XSSFWorkbook(fis);
            sheetNo = workbook.getSheet(tab);
        }
        return readSheet(sheetNo);

    }

    private static List<Map<String, String>> readSheet(XSSFSheet sheet) {
        XSSFRow row;
        XSSFCell cell;

        totalRow = sheet.getLastRowNum();

        for (int currentRow = 1; currentRow <= totalRow; currentRow++) {

            row = sheet.getRow(currentRow);

            int totalColumn = row.getLastCellNum();
            logMessage(String.valueOf(totalColumn));

            for (int currentColumn = 0; currentColumn < totalColumn; currentColumn++) {

                cell = row.getCell(currentColumn);
                String columnHeaderName = sheet.getRow(sheet.getFirstRowNum()).getCell(currentColumn)
                        .getStringCellValue();
                columnMapdata.put(columnHeaderName+currentRow, cell.getStringCellValue());
            }

            excelRows.add(columnMapdata);
        }

        return excelRows;

    }

    public static void getDataInLinkedHashMap()
    {
        for(Map.Entry<String,String>value:columnMapdata.entrySet())
            logMessage(value.getKey()+":"+value.getValue());
    }

    }
