package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.PayloadValidationPageActions;
import com.cengage.utils.ExcelFileReader;
import io.cucumber.java.en.Then;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.Map;



/**
 * @author Ekansh Jain
 *
 */
public class PayloadValidatorStepDef extends BaseClass {
	public PayloadValidatorStepDef() {
		super();
	}

	PayloadValidationPageActions payload = new PayloadValidationPageActions();

	@Then("Validate the payloads")
	public void validatePayload() throws ParseException {
		ExcelFileReader reader = new ExcelFileReader("src/test/resources/TestData/Personal.xlsx", "Sheet2");
		double temp;
		int temp1;
		HashMap<String, String> attVal = new HashMap<>();
		String json;
		String attribute;
		String expectedValue;
		String actualValue;
		String orderNum = null;
		String orderType;

		for (int i = 1; i <= reader.getLastRow(); i++) {
			orderNum = reader.readCell(i, 0);
			temp = Double.parseDouble(orderNum);
			temp1 = (int) temp;
			orderNum = Integer.toString(temp1);
			orderType = reader.readCell(i, 1);

			attVal = payload.getAttributeAndValues(reader.readCell(i, 2));
			json = reader.readCell(i, 3);

			for (Map.Entry<String, String> entry : attVal.entrySet()) {
				attribute = entry.getKey();
				expectedValue = entry.getValue();

				actualValue = payload.getAttributeValueFromJSON(json, attribute);
				payload.verifyAttributeValue(orderNum, attribute, expectedValue, actualValue);
			}

			ExcelFileReader e = new ExcelFileReader("src/test/resources/TestData/Personal.xlsx", "Sheet3");

			for (int j = 0; j < e.getLastColumn(0); j++) {
				if (e.readCell(0, j).equals(orderType)) {
					payload.compareJsonSchema(json, e.readCell(1, j), orderNum);
					break;
				}
			}

			reader = new ExcelFileReader("src/test/resources/TestData/Personal.xlsx", "Sheet2");
		}

		logMessage("*************************** Unmatched Values*****************************");
		for (Map.Entry<String, String> entry : faulty.entrySet())
			logMessage(entry.getKey() + ": " + entry.getValue());

		logMessage("");
		logMessage("");
		logMessage("*************************** Unmatched Attribute Values*****************************");
		for (String s : faultyAttributes)
			logMessage(s);
	}
}