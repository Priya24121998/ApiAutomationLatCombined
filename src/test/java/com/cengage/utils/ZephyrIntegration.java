package com.cengage.utils;

import com.cengage.Runner.BaseClass;
import io.restassured.RestAssured;
import io.restassured.specification.RequestSpecification;

import java.util.HashMap;

public class ZephyrIntegration extends BaseClass
{
	public static void updateJira()
	{
		String status;
		String issueId;
		String executionId;
		String testcaseID = null;
		String cycleId = System.getProperty("cycleId");
		String versionId = PropFileHandler.readConfigProperty("GDC_versionId");
		String projectId=PropFileHandler.readConfigProperty("GDC_ProjectID");

		try {
			if(cycleId.equalsIgnoreCase("NULL") || cycleId.isEmpty())
				cycleId=null;
		}catch(NullPointerException e) {
			cycleId=null;
		}
		
		if(cycleId!=null)
		{
			if(scenarioName.contains("GDC") || scenarioName.contains("SAPECOMM"))
			{
				testcaseID =scenarioName.split("]")[0].replace("[", "").trim();
				if(scenarioStatus.equals("PASSED")){
					if(scenarioName.contains("Partially Automated"))	status="3";
					else	status="1";
					
					try {
						issueId=getIssueId(testcaseID);
						executionId=getExecutionId(issueId,cycleId,versionId,projectId);
						
						updateStatusAndComment(executionId,status);
					}catch(AssertionError e1) {
						try {
							versionId = PropFileHandler.readConfigProperty("Sapecomm_versionId");
							projectId = PropFileHandler.readConfigProperty("Sapecomm_ProjectID");
							issueId=getIssueId(testcaseID);
							executionId=getExecutionId(issueId,cycleId,versionId,projectId);
							updateStatusAndComment(executionId,status);
						}catch(Exception e3) {
							logMessage("Exception occurs");
						}catch(AssertionError e4) {
							logMessage("Exception occurs");
						}
					}catch(Exception e2) {
						logMessage("Exception occurs");
					}
				}
			}
		}
		scenarioComment="";
	}
	
	
	public static String getIssueId(String testcaseID)
	{
		String issueId;
		RequestSpecification issueIdRequest = RestAssured.given();
		issueIdRequest.header("Content-Type","application/json");
		issueIdRequest.header("Authorization",PropFileHandler.readConfigProperty("JiraToken"));
		String endpoint = "https://jira.cengage.com/rest/api/latest/issue/"+testcaseID;
		issueId = issueIdRequest.get(endpoint).getBody().jsonPath().get("id").toString();
		return issueId;
	}
	
	
	
	
	public static String getExecutionId(String issueId, String cycleId, String versionId, String projectId)
	{
		String executionId;
		RequestSpecification createRequest = RestAssured.given();
		createRequest.header("Content-Type","application/json");
		createRequest.header("Authorization",PropFileHandler.readConfigProperty("JiraToken"));
		String endpoint = "https://jira.cengage.com/rest/zapi/latest/execution/";
		HashMap<String, String> requestBody = new HashMap<>();
		requestBody.put("issueId", issueId);
		requestBody.put("cycleId", cycleId);
		requestBody.put("versionId", versionId);
		requestBody.put("projectId", projectId);
		createRequest.body(requestBody);
		executionId=createRequest.post(endpoint).then().statusCode(200).extract().body().asString().split(":")[0].replace("\"", "").replace("{", "");
		return executionId;
	}
	

	
	public static void updateStatusAndComment(String executionId, String status)
	{
		RequestSpecification updateRequest = RestAssured.given();
		updateRequest.header("Content-Type","application/json");
		updateRequest.header("Authorization",PropFileHandler.readConfigProperty("JiraToken"));
		String endpoint = "https://jira.cengage.com/rest/zapi/latest/execution/"+executionId+"/execute";
		HashMap<String, String> updateBody = new HashMap<>();
		
		updateBody.put("status", status);
		updateBody.put("comment",scenarioComment);
		
		updateRequest.body(updateBody).when().put(endpoint).then().statusCode(200);
	}
}
