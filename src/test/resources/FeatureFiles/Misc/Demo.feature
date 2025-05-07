Feature: This is a Feature for Automation Demo

	@Demo_Positive
  Scenario: [GDC-10134] User should be able to purchase Hardcover Book.
    Given Create HardCover8279 user
    When I Hit the API to add cart to user account and verify status code
    And User adds HardCover product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal

	@Demo_Positive
  Scenario: [GDC-10103] Verify User is able to purchase rental textbook using CC.
    Given Create StandRental user
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals

	@Demo_Negitive
  Scenario: [GDC-11164] Verify that user should not be able to add CU 24 months sub in to cart.
    Given Create Cu24NotPurchase user
    When I Hit the API to add cart to user account and verify status code
    And User adds 24Mon_Payload product to cart
    Then I verify error with given message
      | Message | Purchase Cengage Unlimited - Full-Access-730 not available for sale. |
    And I log Test Data for Cart
	
	@Demo_Negitive
  Scenario: [GDC-9906] Verify User is able to purchase CU Full 4 Months using 3DS enabled Visa credit card
    Given Create SubsPur006 user
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    When Accept Visa securit popup
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I log Test Data for subscription
