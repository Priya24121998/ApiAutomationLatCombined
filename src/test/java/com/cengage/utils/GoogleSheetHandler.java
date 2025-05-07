package com.cengage.utils;

import com.cengage.Runner.BaseClass;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.sheets.v4.Sheets;
import com.google.api.services.sheets.v4.model.*;

import java.io.*;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class GoogleSheetHandler extends BaseClass
{
	public static final String APPLICATIONNAME = "AccessCodeAutomation";
	public static JsonFactory JSONFACTORY = JacksonFactory.getDefaultInstance();
	public static GoogleClientSecrets clientSecrets;
	public static final String CREDENTIALSFILEPATH = "/credentials.json";
	public static final String TOKENSDIRECTORYPATH = "tokens";
	public static GoogleAuthorizationCodeFlow flow;
	private static InputStream inputStream;
	private static File filepath;
	public  Sheets.Spreadsheets.Values.Clear request;
	public ClearValuesResponse clearResponse;
    String drange, wrange;
	public  ClearValuesRequest requestBody;
    Sheets service;
	public static String spreadsheetId="1X-WX_QzbonwjFnqOwqVxXu8eUpxC0tHEUe4ca5_oJcY";
	@SuppressWarnings("rawtypes")
	public static List SCOPES = Collections.singletonList(DriveScopes.DRIVE);
	public static NetHttpTransport HTTPTRANSPORT;
	public static java.io.File DATA_STORE_DIR = new java.io.File(System.getProperty("user.dir"),".credentials/2/sheets.googleapis.com-java-quickstart.json");

	
	public GoogleSheetHandler()
	{
		try {
			HTTPTRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
			getCredentials(HTTPTRANSPORT);
			service = new Sheets.Builder(HTTPTRANSPORT, JSONFACTORY, getCredentials(HTTPTRANSPORT))
					.setApplicationName(APPLICATIONNAME).build();
		}catch(IOException e) {
			logMessage(e.getMessage());
		}catch(GeneralSecurityException g) {
			logMessage(g.getMessage());
		}
	}
	
	@SuppressWarnings("unchecked")
	public static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws IOException 
	{

		filepath = new File("src/test/resources/TestData/credentials.json");
		inputStream = new FileInputStream(filepath);

		clientSecrets = GoogleClientSecrets.load(JSONFACTORY, new InputStreamReader(inputStream));
		flow = new GoogleAuthorizationCodeFlow
				.Builder(HTTP_TRANSPORT, JSONFACTORY, clientSecrets, SCOPES)
				.setDataStoreFactory(new FileDataStoreFactory((DATA_STORE_DIR)))
				.setAccessType("offline").build();
		inputStream.close();
		LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
		return new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
	}
	
	
	public String readValueFromGoogleSheet(int row, String sheetName)
	{
		ValueRange response = null;
		try {
		response = service.spreadsheets().values().get(spreadsheetId, sheetName).execute();
		}catch(IOException e) {
		}
		List<List<Object>> temp = response.getValues();
		int numRows = response.getValues().size();
		logMessage("Total number of records found: "+numRows);
		String val;
        val=temp.get(row).toString().replace("[", "");
        val=val.replace("]", "").trim();
        return val;
	}
	
	
	public void deleteRow(int sheetID) throws IOException, GeneralSecurityException
	{
		DeleteDimensionRequest deleteRequest;
		deleteRequest = new DeleteDimensionRequest()
				.setRange(new DimensionRange().setSheetId(sheetID).setDimension("ROWS").setEndIndex(1));

		List<Request> requests = new ArrayList<>();
		requests.add(new Request().setDeleteDimension(deleteRequest));

		BatchUpdateSpreadsheetRequest body = new BatchUpdateSpreadsheetRequest().setRequests(requests);
		try {
			service.spreadsheets().batchUpdate(spreadsheetId, body).execute();
		}catch(IOException e) {
		}
	}
	
	
	public void clearData(String sheetName, String range) throws IOException 
	{
	
		drange = sheetName+"!"+range;
		requestBody = new ClearValuesRequest();
		request =service.spreadsheets().values().clear(spreadsheetId, drange, requestBody);
		clearResponse = request.execute();
	}
	
	
	public void writeData(String sheetName, String range, String value, int row) throws IOException 
	{
		String dataColumn;
		List<List<Object>> list;
		ValueRange vr;
		
		dataColumn = sheetName+"!"+range +String.valueOf(row);
		list = Arrays.asList(Arrays.asList(value));
		vr = new ValueRange().setValues(list).setMajorDimension("ROWS");
		service.spreadsheets().values().update(spreadsheetId, dataColumn, vr)
				.setValueInputOption("RAW").execute();
	}
}
