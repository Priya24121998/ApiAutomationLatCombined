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
@tag
Feature: Title of your feature
  I want to use this template for my feature file

  Scenario: [GDC-12793] Verify the previous order number details while upgrading Ebook> Cuet> CU 4> CU 12
    Given Create user DPSdiscount_1 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    Then I get previousOrder from response
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    Then User fetches cart details
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    Then I verify previousOrderId in API response
    Then I get previousOrder from response
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And User adds 4Mon_Payload product to cart
    Then User fetches cart details
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify previousOrderId in API response
    Then I get previousOrder from response
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
     And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify previousOrderId in API response
    Then I get previousOrder from response
    And I log Test Data for subscription
    When I click on sidebar sign out button