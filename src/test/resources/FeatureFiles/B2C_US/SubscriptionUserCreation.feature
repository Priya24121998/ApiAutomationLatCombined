Feature: CU12 Discounted Rental Purchase


  ###########################################(CC)#############################################################
  @subusercu120
  Scenario Outline: [GDC-10124] Verify User is able to purchase single rental: CU 12 months using standard shipping.
    Given Create <user> user
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals


    Examples:
      | user        |
      |CU12SubUser01|
#      |CU12SubUser01|
#      |CU12SubUser03|
#      |CU12SubUser04|
#      |CU12SubUser05|
#      |CU12SubUser06|

  @subusercu04
  Scenario Outline: [GDC-10138] Verify User is able to purchase single rental: CU 4 months using standard shipping.
    Given Create <user> user
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals


    Examples:
      | user        |
      |CU04SubUser01|
      |CU04SubUser02|
      |CU04SubUser03|
      |CU04SubUser04|
      |CU04SubUser05|
      |CU04SubUser06|

