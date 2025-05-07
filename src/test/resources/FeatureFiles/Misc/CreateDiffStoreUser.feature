Feature: User Creation Feature

  @AU_User
  Scenario: create user
    #Given I want to create B2CAU user and login to application
    #Given I want to create B2CNZ user and login to application
    #Given I want to create B2CCA user and login to application
    #Given I want to create B2CEMEA user and login to application

  @B2B_User
  Scenario: User is able to create using API
    Given I Hit Api to create B2BCA Token
    And I hit API to create B2BCA User
    Then I verify B2BCA customer is registered

  @User_emea
  Scenario: create user
    Given I want to create B2CUS user and login to application


  Scenario: create user B2B User
    And I hit API to create B2BUS User
    
  
  Scenario: create user B2B User  
    Given  I hit API to create B2CNZ user
    Given I hit API to create B2CAU user
    Given I hit API to create B2CCA user
    Given I hit API to create B2CEMEA user
    
  
@Create_UI_User  
Scenario: create different user
Given create 1 user with OKTA Api for B2CEMEA store
#Given create 1 user with SAP Api for B2CNZ store
#Given create 1 user with SAP Api for B2CCA store
  
@Run
Scenario: run this scenario
And Run this step using comand
  
  
  
  
  
  
  
  
  
  
  
