package com.cengage.common;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;



public class Payload {

	static List<String> isbns = new ArrayList<>();
	static List<Integer> quantities = new ArrayList<>();
 
	public static JSONObject addProdFragmentsAddJson(String isbn, int quantity) {
		JSONObject json = new JSONObject();
		json.put("code", isbn);
		json.put("quantity", quantity);
		
		JSONObject json2 = new JSONObject();
		json2.put("product", json);
		
		System.out.println(json2);
		return json2;
	}
	
	public static JSONObject addProdFragmentsAddProdB2CJson(String isbn, int quantity) {
		JSONObject json1 = new JSONObject();
		json1.put("cngPriceType", "OFFER_PRICE");
		
		JSONObject json = new JSONObject();
		json.put("code", isbn);
	    json.put("price", json1);
		
		JSONObject json2 = new JSONObject();
	    json2.put("product", json);
	    json2.put("quantity", quantity);
	    
	    System.out.println(json2); 
	 
	   return json2;
		
	}
	
	
	public static void clearIsbnsStoredInCurrentExecution()
	{
		quantities.clear();
		isbns.clear();
		System.out.println("Data cleared successfully");
	}


	public static JSONObject multipleIsbnAndQuantityGetAndCreatePayload(String addIsbnWithQuantity) {
		String[] lines = addIsbnWithQuantity.split("\n");

		for (String line : lines) {
			String[] isbnQuantity = line.split(","); // Split by comma
			//String isbn = isbnQuantity[0].split("@@")[0]; // Split by @@ and take the first part
			 String isbn = isbnQuantity[0]; // take the first part
			int quantity = Integer.parseInt(isbnQuantity[1].trim()); // Parse the quantity
			isbns.add(isbn);
			quantities.add(quantity);
		}

		JSONObject reqBody = addProdPayload(isbns.size(), isbns, quantities);
		System.out.println("Size: " + isbns.size());
		System.out.println("ISBNs: " + isbns);
		System.out.println("Quantities: " + quantities);
		return reqBody;

	}
	
	public static JSONObject multipleIsbnAndQuantityGetAndCreatePayloadB2C(String addIsbnWithQuantity) {
		String[] lines = addIsbnWithQuantity.split("\n");

		for (String line : lines) {
			String[] isbnQuantity = line.split(","); // Split by comma
			//String isbn = isbnQuantity[0].split("@@")[0]; // Split by @@ and take the first part
			 String isbn = isbnQuantity[0]; // take the first part
			int quantity = Integer.parseInt(isbnQuantity[1].trim()); // Parse the quantity
			isbns.add(isbn);
			quantities.add(quantity);
		}

		JSONObject reqBody = addProdPayloadB2C(isbns.size(), isbns, quantities);
		System.out.println("Size: " + isbns.size());
		System.out.println("ISBNs: " + isbns);
		System.out.println("Quantities: " + quantities);
		return reqBody;

	}
	
	
	private static JSONObject addProdPayloadB2C(int size, List<String> isbns2, List<Integer> quantities2) {
		String payload = null;
		JSONObject mappedObject = null;

		if (size == 1) {
			JSONArray jsonArraySingle = new JSONArray();
			JSONObject jsonObjectSingle=addProdFragmentsAddProdB2CJson(isbns.get(0), quantities.get(0));
			System.out.println("ISBN " + 0 + " : " + isbns.get(0));
			System.out.println("Quantities " + 0 + " : " + quantities.get(0));
			System.out.println(jsonObjectSingle);
			jsonArraySingle.put(jsonObjectSingle);
			mappedObject = new JSONObject();
	        mappedObject.put("orderEntries", jsonArraySingle);
		} else {
			
			JSONArray jsonArray = new JSONArray();

			for (int i = 0; i < size; i++) {
				System.out.println("Inside the for loop");
				JSONObject jsonObj=addProdFragmentsAddProdB2CJson(isbns.get(i), quantities.get(i));
				System.out.println("ISBN " + i + " : " + isbns.get(i));
				System.out.println("Quantities " + i + " : " + quantities.get(i));
				System.out.println(jsonObj);
				jsonArray.put(jsonObj);
				
			}
			
			System.out.println(jsonArray);

		    mappedObject = new JSONObject();
	        mappedObject.put("orderEntries", jsonArray);
		
			System.out.println(mappedObject);
		}
		return mappedObject;
			
	}

	@SuppressWarnings("unchecked")
	private static JSONObject addProdPayload(int size, List<String> isbns2, List<Integer> quantities2) {
		String payload = null;
		JSONObject mappedObject = null;

		if (size == 1) {
			JSONArray jsonArraySingle = new JSONArray();
			JSONObject jsonObjectSingle=addProdFragmentsAddJson(isbns.get(0), quantities.get(0));
			System.out.println("ISBN " + 0 + " : " + isbns.get(0));
			System.out.println("Quantities " + 0 + " : " + quantities.get(0));
			System.out.println(jsonObjectSingle);
			jsonArraySingle.put(jsonObjectSingle);
			mappedObject = new JSONObject();
	        mappedObject.put("orderEntries", jsonArraySingle);
		} else {
			
			JSONArray jsonArray = new JSONArray();

			for (int i = 0; i < size; i++) {
				System.out.println("Inside the for loop");
				JSONObject jsonObj=addProdFragmentsAddJson(isbns.get(i), quantities.get(i));
				System.out.println("ISBN " + i + " : " + isbns.get(i));
				System.out.println("Quantities " + i + " : " + quantities.get(i));
				System.out.println(jsonObj);
				jsonArray.put(jsonObj);
				
			}
			
			System.out.println(jsonArray);

		    mappedObject = new JSONObject();
	        mappedObject.put("orderEntries", jsonArray);
		
			System.out.println(mappedObject);

			



		}
		return mappedObject;

	}
	public String userCreationRequestPayload() {
		return "{\"accountStatus\":\"ACTIVE\",\"defaultAddress\":{\"country\":{\"isocode\":\"CA\"},\"defaultAddress\":true,\"billingAddress\":true,\"email\":\"#replaceValue#\",\"firstName\":\"Automation\",\"lastName\":\"Tester\",\"line1\":\"6200 FRANK AVE NW\",\"line2\":\"\",\"phone\":\"+1 5405555555\",\"postalCode\":\"44720\",\"region\":{\"countryIso\":\"CA\",\"isocode\":\"CA-ON\"},\"shippingAddress\":true,\"town\":\"NORTH CANTON\",\"visibleInAddressBook\":true},\"email\":\"#replaceValue#\",\"defaultBillToAccount\":\"#replaceAccountValue#\",\"defaultShipToAccount\":\"#replaceAccountValue#\",\"orgUnit\":{\"uid\":\"#replaceAccountValue#\"},\"roles\":[\"purchaser\"],\"uid\":\"#replaceValue#\",\"firstName\":\"Automation\",\"lastName\":\"Tester\",\"selected\":false,\"storeName\":\"KathyBarfield\",\"title\":\"Mr.\",\"titleCode\":\"mr\",\"workPhone\":\"+1 1233211234\"}";
	}
	
	public String userCreationRequestPayloadUnitedStates() {
		return "{\"accountStatus\":\"ACTIVE\",\"defaultAddress\":{\"country\":{\"isocode\":\"US\"},\"defaultAddress\":true,\"billingAddress\":true,\"email\":\"#replaceValue#\",\"firstName\":\"Test\",\"lastName\":\"User\",\"line1\":\"37 COLLEGE AVE\",\"line2\":\"\",\"phone\":\"+1 5405555555\",\"postalCode\":\"4038\",\"region\":{\"countryIso\":\"US\",\"isocode\":\"US-ME\"},\"shippingAddress\":true,\"town\":\"GORHAM\",\"visibleInAddressBook\":true},\"email\":\"#replaceValue#\",\"defaultBillToAccount\":\"#replaceAccountValue#\",\"defaultShipToAccount\":\"#replaceAccountValue#\",\"orgUnit\":{\"uid\":\"#replaceAccountValue#\"},\"roles\":[\"purchaser\"],\"uid\":\"#replaceValue#\",\"firstName\":\"Test\",\"lastName\":\"User\",\"selected\":false,\"storeName\":\"UNIV SOUTHERN MAINE BKSTR NACS\",\"title\":\"Mr.\",\"titleCode\":\"mr\",\"workPhone\":\"+1 1233211234\"}";
	}
	
	public String userCreationRequestPayloadGale() {
		return "{\"accountStatus\":\"ACTIVE\",\"defaultAddress\":{\"country\":{\"isocode\":\"US\"},\"defaultAddress\":true,\"billingAddress\":true,\"email\":\"#replaceValue#\",\"firstName\":\"Automation\",\"lastName\":\"Tester\",\"line1\":\"300 S GEORGE ST\",\"line2\":\"\",\"phone\":\"+1 5405555555\",\"postalCode\":\"254141634\",\"region\":{\"countryIso\":\"US\",\"isocode\":\"US-WV\"},\"shippingAddress\":true,\"town\":\"CHARLES TOWN\",\"visibleInAddressBook\":true},\"email\":\"#replaceValue#\",\"defaultBillToAccount\":\"#replaceAccountValue#\",\"defaultShipToAccount\":\"#replaceAccountValue#\",\"orgUnit\":{\"uid\":\"#replaceAccountValue#\"},\"roles\":[\"purchaser\", \"gale-store\"],\"uid\":\"#replaceValue#\",\"firstName\":\"Automation\",\"lastName\":\"Tester\",\"selected\":false,\"storeName\":\"CATHOLIC DISTANCE UNIV\",\"title\":\"Mr.\",\"titleCode\":\"mr\",\"workPhone\":\"+1 1233211234\"}";
	}
	
	public String activationReqPayloadB2bCanada()
	{
		return "{\"profile\":{\"firstName\":\"Test\",\"lastName\":\"User\",\"email\":\"#replaceEmailValue#\",\"login\":\"#replaceEmailValue#\"},\"credentials\":{\"password\":{\"value\":\"#replacePasswordValue#\"}},\"groupIds\":[\"00g1ycas3i4WTOuvR0h8\"]}";
	}

	public String activationReqPayloadB2bUnitedStates() {
		return "{\"profile\":{\"firstName\":\"Test\",\"lastName\":\"User\",\"email\":\"#replaceEmailValue#\",\"login\":\"#replaceEmailValue#\"},\"credentials\":{\"password\":{\"value\":\"#replacePasswordValue#\"}},\"groupIds\":[\"00g1ycas3i4WTOuvR0h8\"]}";
	}

	public String activationReqPayloadB2bGale() {
		return "{\"profile\":{\"firstName\":\"Test\",\"lastName\":\"User\",\"email\":\"#replaceEmailValue#\",\"login\":\"#replaceEmailValue#\"},\"credentials\":{\"password\":{\"value\":\"#replacePasswordValue#\"}},\"groupIds\":[\"00g1ycas3i4WTOuvR0h8\"]}";
	}


}
