Feature: B2C US Subscription and Rental initial order test data

    #CU120 Subscription
  @B2CUS_UC_CU120_Subscription
  Scenario: Creating and activating B2C Users with CU120 Subscription
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription

     #CU365 Subscription
  @B2CUS_UC_CU365_Subscription
  Scenario: Creating and activating B2C Users with CU365 Subscription
    Given Create user B2CUS_CU365_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription

  @B2CUS_UC_CU365_Subscription_WithCURental
  Scenario Outline: Creating and activating B2C Users with CU365 Subscription
    Given Create user B2CUS_CU365_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User will add rental product <rentalISBN> to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals

    Examples:
      | rentalISBN        |creditCardType |
      |9781133365419@@CU  | Master3       |

  @B2CUS_UC_CU120_Subscription_WithCURental
  Scenario Outline: Creating and activating B2C Users with CU365 Subscription
    Given Create user B2CUS_CU365_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User will add rental product <rentalISBN> to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals

    Examples:
      | rentalISBN        |creditCardType |
      |9781133365419@@CU  | Visa          |

  @B2CUS_UC_WithSDRental
  Scenario Outline: Creating and activating B2C Users with CU365 Subscription
    Given Create user B2CUS_STANDALONE_REN_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User will add rental product <rentalISBN> to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals

    Examples:
      | rentalISBN          |creditCardType |
      |9780357662106@@180I  | Master3       |
    


