Feature: Return Rental [BAD]

  ######################################################## Smoke ########################################################
  @ReturnRentalBad_Smoke
  Scenario: [GDC-9918] Verify User is able return rental in BAD state using Credit Card.
    Given Create PPSTReturnBAD user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    Then User fetches cart details
    Then I check deliveryCost amount is 9.99
		And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is expedited-us
    And I wait for 50 sec
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    And I log Test Data for rentals
    #When I click on sidebar sign out button

  ###############################################Shipping - Standard (CC)############################################
  @ReturnRentalBadCC
  Scenario: [GDC-9997] Verify User is able return rental in BAD state.
    Given Create STReturnBAD user 
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
    Then I verify shipping method is standard-us
    And I wait for 50 sec
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    And I log Test Data for rentals
    #When I click on sidebar sign out button


  #CU4
  @ReturnRentalBadCC
  Scenario: [GDC-10039] Verify User is able return CU-4 rental in BAD state..
    Given Create CU4ReturnBAD user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
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
    Then I verify shipping method is standard-us
    And I wait for 50 sec
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU12
  @ReturnRentalBadCC
  Scenario: [GDC-10139] Verify User is able return CU-12 rental in BAD state.
    Given Create CU12ReturnBAD user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_5 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    And I wait for 50 sec
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    
    @UpdateRentalBadState
     Scenario: [GDC-12987] Update Rental Contract with tracking information of Rental Return[Bad State]
    Given Create STReturnGood user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Master2 card details
     And I wait for 20 sec
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then Verify able to Update Rental Details   
    Then I verify if return rental details API is returning valid returnTrackingInfo
    Then I verify following details in API response
      | returnTrackingInfo[0].trackingId  |  not null |
      | returnTrackingInfo[0].carrier     |  not null |
      | rentalState                       |  ACTIVE   |
      | rentalEvents[0].eventType         |  ORDERED  |
    When I return rental in BAD state
    Then I verify if return rental details API is returning valid returnTrackingInfo
    Then I verify following details in API response
      | returnTrackingInfo[1].trackingId  |  not null |
      | returnTrackingInfo[1].carrier     |  not null |
      | rentalState                       |  FORCEDPURCHASE|
      | rentalEvents[1].eventType         |  PENALIZED|
    And I log Test Data for rentals
    #When I click on sidebar sign out button

#-------------------------------------------------Removed ---------------------------------------------------------------#   

  #CU24
  Scenario: [GDC-10012] Verify User is able return CU-24 rental in BAD state.
    Given Create CU24ReturnBad user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    #----------------------Removed as a part of SAPECOMM-11358------------------------#
    #CUeT
    Scenario: [GDC-10054] Verify User is able return CUeT-4 rental in BAD state.
    Given Create CUeTReturnBAD user 
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
    Then I verify shipping method is standard-us
    And I wait for 50 sec
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button