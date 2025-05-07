Feature: Rental Cancellation

  #StandAlone Rental
  #  @CancelRentalCC
  Scenario: [GDC-9995] Verify Rental cancellation using Cancel API.
    Given Create STCancel user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for rentals
    #When I click on sidebar sign out button

  #CUet
  #  @CancelRentalCC
  Scenario: [GDC-10169] Verify CUeT-4 Rental cancellation using Cancel API.
    Given Create CUeTCancel user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU4
  #  @CancelRentalCC
  Scenario: [GDC-10102] Verify CU-4 Rental cancellation using Cancel API.
    Given Create CU4Cancel user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU12
  #  @CancelRentalCC
  Scenario: [GDC-10107] Verify CU-12 Rental cancellation using Cancel API..
    Given Create CU12Cancel user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_3 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU24
  #  @CancelRentalCC
  Scenario: [GDC-10041] Verify CU-24 Rental cancellation using Cancel API.
    Given Create CU24Cancel user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_4 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
