#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template
Feature: B2C AU User Creation and Activation

  #Single User
  @B2CAU_UserCreation_Activation
  Scenario: Creating and activating B2C AU User
    Given I need to create and activate AU user for B2CAU store

   #mutliple Users creation at run time
  @B2CAU_UserCreation_Multiple
  Scenario: Creating and activating n B2C Users
    Given I will create n B2CAU users and activate it for B2CAU store
    Then I will store the username and password details in the excel named "UserCreation_B2C.xlsx"
    And Clear data in hashmap after creating users


