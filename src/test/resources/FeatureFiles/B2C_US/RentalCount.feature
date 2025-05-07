Feature: Rental Count

  ###############################################   (Credit Card)   ############################################
  #CU-4
  @RentalCount
  Scenario: [GDC-10080] Verify count should be increased by 1 if one rental moved to Cancelled and one rental is moved to FORCEPURCHASED by returning to BAD state.
    Given Create RentalCount_1 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I Try to Ship 2 rentals in one go
    Then Verify 2 rental status in return list of rental API is ACTIVE
    And I get Availible rental count is 2
    Then User hit Api to cancel first rental
    #Then Verify status of first rental is CANCELLED
    And User return second rental in BAD state
    #Then Verify status of second rental is FORCEDPURCHASE
    And I verify rental count is 3
    And I log Test Data for Normal
    #When I click on sidebar sign out button

  #CU-4
  @RentalCount
  Scenario: [GDC-10086] Verfiy that rental quantity should increase accordingly when User return rental with GOOD state.
    Given Create RentalCount_2 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I Try to Ship 2 rentals in one go
    Then Verify 2 rental status in return list of rental API is ACTIVE
    And I get Availible rental count is 2
    And User return second rental in GOOD state
    And I verify rental count is 3
    And I log Test Data for Normal
    #When I click on sidebar sign out button

  #CU-12
  @RentalCount
  Scenario: [GDC-10087] Verify that Count should be increased by 2 if one rental is returned in GOOD state and one rental is moved to Cancelled.
    Given Create RentalCount_3 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I Try to Ship 2 rentals in one go
    Then Verify 2 rental status in return list of rental API is ACTIVE
    And I get Availible rental count is 6
    Then User hit Api to cancel first rental
    And User return second rental in GOOD state
    And I verify rental count is 8
    Then Verify 2 rental status in return list of rental API is CANCELLED
    And I log Test Data for Normal
    #When I click on sidebar sign out button

      #CU-4
  @RentalCount
  Scenario: [GDC-10079] Verify that rental count should not increase when user return rental in GOOD state after more than 30 days of start date.
    Given Create RentalCount_4 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I Try to Ship 2 rentals in one go
    Then Verify 2 rental status in return list of rental API is ACTIVE
    And I get Availible rental count is 2
    When User return rental in GOOD state after 31 days
    And I verify rental count is 2
    And I log Test Data for Normal
    #When I click on sidebar sign out button
    