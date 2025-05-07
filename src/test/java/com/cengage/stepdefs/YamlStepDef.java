package com.cengage.stepdefs;

import com.cengage.Runner.BaseClass;
import com.cengage.pageactions.UIPageActions;
import com.cengage.pageactions.YamlPageActions;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

public class YamlStepDef extends BaseClass {

    YamlPageActions obj = new YamlPageActions();
    @Then("Append the data in the {string} output yaml file")
    public void appendTheDataInTheOutputYamlFile(String fileName) {
        obj.appendContentToYamlFile(fileName);
    }

    @Given("clear the content of {string} output yaml file")
    public void clearTheContentOfOutputYamlFile(String fileName) {
        obj.clearYamlFileContent(fileName);
    }
}
