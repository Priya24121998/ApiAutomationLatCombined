package com.cengage.utils;

import com.cengage.Runner.BaseClass;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;

public class ExcelFileReader extends BaseClass
{
	static Sheet sheet = null;
	static File file;
	
	public ExcelFileReader(String fName, String sheetName)
	{
		try
		{
			file = new File(fName);
			FileInputStream inputStream = new FileInputStream(file);
			Workbook workbook = null;
			try
			{
				workbook = new XSSFWorkbook(inputStream);
				try
				{
				sheet = workbook.getSheet(sheetName);
				}
				catch(NullPointerException e) {
					
					logMessage(e.getMessage());
				}
			}catch(IOException e) {
				
				logMessage(e.getMessage());
			}
		}catch(FileNotFoundException f){
			logMessage(f.getMessage());
		}
	}
		
		
	public String readCell(int rowNum, int columnNum)
	{
		String data=null;
		Row row = sheet.getRow(rowNum);
		if (row != null) 
		{
			Cell cell = row.getCell(columnNum);
			if (cell != null)
			{
				try {
					data = cell.getStringCellValue();
				}catch(IllegalStateException e) {
					data = Double.toString(cell.getNumericCellValue());
				}
			}
		}
		return data;
	}
	
	
	public int getLastRow()
	{
		return sheet.getLastRowNum();
	}
	
	
	public int getLastColumn(int rowNum)
	{
		return sheet.getRow(rowNum).getLastCellNum();
	}
	
	public ExcelFileReader(String SheetName)
	{
		try
		{
			file = new File("src/test/resources/TestData/"+SheetName);
			FileInputStream inputStream = new FileInputStream(file);
			Workbook workbook = null;
			try
			{
				workbook = new XSSFWorkbook(inputStream);

				sheet = workbook.getSheetAt(0);
				
			}catch(IOException e) {
				
				logMessage(e.getMessage());
			}
		}catch(FileNotFoundException f){
			//f.printStackTrace();
			logMessage(f.getMessage());
		}
		
	}
	
	
	@SuppressWarnings({ "unused", "resource" })
	public void setRowColor(int rowNum) throws IOException
	{
		Workbook workbook = null;
		try
		{
			file = new File("src/test/resources/TestData/Users.xlsx");
			FileOutputStream outputStream = new FileOutputStream(file);
			
			workbook = new XSSFWorkbook();
			try
			{
			sheet = workbook.getSheet("Users");
			}catch(NullPointerException f){
				//f.printStackTrace();
				logMessage(f.getMessage());
			}
		}catch(FileNotFoundException f){
			//f.printStackTrace();
			logMessage(f.getMessage());
		}
		Row row = sheet.getRow(rowNum);
		if(workbook!=null)
		{
		CellStyle style = workbook.createCellStyle();
		style.setFillBackgroundColor(IndexedColors.AQUA.getIndex());
		style.setFillPattern(FillPatternType.BIG_SPOTS);
		row.setRowStyle(style);
		}
	}
}