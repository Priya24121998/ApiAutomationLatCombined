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
Feature: B2C US Payment scenarios

  # ERP PHASE 2 TICKET - ADDED NEWLY
  @sapecomm-11252 @B2C_US_Order_Reg
  Scenario: [GDC-12885] Verifying the Paypal full Authentication scenario for B2C US
    Given I Hit Api to create B2CUS Token
    Given I hit API to create B2CUS user
    When I hit API to create B2CUS cart
      | basestore | cengage-b2c-us |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-us |
      | Product   | b2cProduct_Mul |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-us |
      | address   | Taxable_Address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-us |
      | address   | Taxable_Address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I put standard-us as shipping mode
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-us |
      | status    |            200 |
      

   @sapecomm-11252 @B2C_US_Order_Reg
  Scenario: [GDC-12890] Verifying the Paypal full Authentication scenario for B2C US With Promo code
    Given I Hit Api to create B2CUS Token
    Given I hit API to create B2CUS user
    When I hit API to create B2CUS cart
      | basestore | cengage-b2c-us |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-us |
      | Product   | B2C_US_Rental |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-us |
      | address   | Taxable_Address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-us |
      | address   | Taxable_Address     |
      | status    |            201 |
    Then User Apply Coupon B2CUS_50
    Then User gets all delivery modes
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I put standard-us as shipping mode
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-us |
      | status    |            200 |

  