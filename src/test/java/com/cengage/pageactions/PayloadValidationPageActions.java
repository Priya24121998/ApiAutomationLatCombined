package com.cengage.pageactions;

import com.cengage.Runner.BaseClass;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.support.PageFactory;

import java.util.HashMap;


public class PayloadValidationPageActions extends BaseClass
{
	public PayloadValidationPageActions()
	{
		super();
		PageFactory.initElements(driver, this);
	}
	
	
	public HashMap<String, String> getAttributeAndValues(String str)
	{
		HashMap<String,String> vals = new HashMap<>();
		String[] parts = str.split("\r?\n|\r");
		for(int i=0;i<parts.length;i++)
		{
			String[] attVal = parts[i].split(":");
			vals.put(attVal[0].trim(), attVal[1].trim());
		}
		return vals;
	}
	
	
	public String getAttributeValueFromJSON(String jsonString, String expAtt) throws ParseException
	{
		JSONParser parser = new JSONParser();  
		JSONObject obj = (JSONObject) parser.parse(jsonString); 
		JSONArray jsonArray;
		JSONObject obj1;
		String value;
		
		try {
			value = (String) obj.get(expAtt).toString();
		}catch(NullPointerException e) {
			value = null;
		}
		
		if(value==null)
		{
			jsonArray = (JSONArray) obj.get("sapCpiOutboundOrderItems");
			obj1 = (JSONObject) jsonArray.get(0);
			try {
				value = (String) obj1.get(expAtt).toString();
			}catch(NullPointerException e) {
				value = null;
			}
			if(value==null)
			{
				jsonArray = (JSONArray) obj.get("sapCpiOutboundCardPayments");
				obj1 = (JSONObject) jsonArray.get(0);
				try {
					value = (String) obj1.get(expAtt).toString();
				}catch(NullPointerException e) {
					value = null;
				}
				if(value==null)
				{
					jsonArray = (JSONArray) obj.get("sapCpiOutboundAddresses");
					obj1 = (JSONObject) jsonArray.get(0);
					try {
						value = (String) obj1.get(expAtt).toString();
					}catch(NullPointerException e) {
						value = null;
					}
					if(value==null)
					{
						jsonArray = (JSONArray) obj.get("sapCpiOutboundAddresses");
						obj1 = (JSONObject) jsonArray.get(0);
						try {
							value = (String) obj1.get(expAtt).toString();
						}catch(NullPointerException e) {
							value = null;
						}
					}
				}
			}
		}
		return value;
	}
	
	
	public void verifyAttributeValue(String orderNum, String attribute, String expected, String actual)
	{
		if(!expected.equals(actual))
			faulty.put(orderNum+"   ||   "+attribute, expected);
	}
	
	
	public void compareJsonSchema(String json, String attributes, String orderNum) throws ParseException
	{
		String value;
		String[] parts = attributes.split("\r?\n|\r");
		for(int i=0;i<parts.length;i++)
		{
			value = getAttributeValueFromJSON(json, parts[i]);
			if(value==null)
				faultyAttributes.add(orderNum+": "+parts[i]);
		}
	}
}
