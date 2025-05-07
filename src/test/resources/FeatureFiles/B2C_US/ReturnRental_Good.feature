Feature: Return Rental [GOOD]

  ###############################################Shipping - Standard (CC)############################################
  @ReturnRentalGood_Smoke
  Scenario: [GDC-9914] Verify User is able return rental in GOOD state.
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in GOOD state
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for rentals
    #When I click on sidebar sign out button

  ############################################# Regression ####################################################
  

  #CU4
  @ReturnRentalGoodCC
  Scenario: [GDC-10106] Verify User is able return CU-4 rental in GOOD state..
    Given Create CU4ReturnGood user 
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in GOOD state
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    


  #CU12
  @ReturnRentalGoodCC
  Scenario: [GDC-9994] Verify User is able return CU-12 rental in GOOD state.
    Given Create CU12ReturnGood user 
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in GOOD state
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    
    
    @UpdateRentalGoodState
  Scenario: [GDC-12986] Update Rental Contract with tracking information of Rental Return[Good State]
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
    When I return rental in GOOD state
    Then I verify if return rental details API is returning valid returnTrackingInfo
    Then I verify following details in API response
      | returnTrackingInfo[1].trackingId  |  not null |
      | returnTrackingInfo[1].carrier     |  not null |
      | rentalState                       |  CANCELLED|
      | rentalEvents[1].bookCondition     |  GOOD     |
      | rentalEvents[1].eventType         |  CANCELLED|
    And I log Test Data for rentals
   
   
   @UpdateRentalGoodState
  Scenario: [GDC-12988] Verfy "Notes" In rental return request payload is manditory
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
    Then Verify able to Update Rental Details WithoutReturnNotes  
    Then I verify following details in API response
      | errors.message  | Please provide a reason to modify the rental object. |
    And I log Test Data for discountedRentals
    
    
     @UpdateRentalGoodState
     Scenario: [GDC-12989] Verfy the when rental is updated with same TrackingId &CarrierId, no new returnTrackingInfo is created.
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
    Then Verify able to Update Rental Details With DuplicateID 
    Then I verify if return rental details API is returning valid returnTrackingInfo
    Then I verify following details in API response
      | returnTrackingInfo[0].trackingId  |  not null |
      | returnTrackingInfo[0].carrier     |  not null |
      | rentalState                       |  ACTIVE   |
      | rentalEvents[0].eventType         |  ORDERED  |
    Then Verify able to Update Rental Details With DuplicateID   
    Then I verify if return rental details API is returning valid returnTrackingInfo
    Then I verify following details in API response
      | returnTrackingInfo[0].trackingId  |  not null |
      | returnTrackingInfo[0].carrier     |  not null |
      | rentalState                       |  ACTIVE   |
      | rentalEvents[0].eventType         |  ORDERED  |
      
    And I log Test Data for discountedRentals
            
 #-------------------------------------------------Removed ---------------------------------------------------------------#
  #CU24
  Scenario: [GDC-9992] Verify User is able return CU-24 rental in GOOD state.
    Given Create CU24ReturnGood user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in GOOD state
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
  
    
    #----------------------Removed as a part of SAPECOMM-11358------------------------#
    #CUeT
  Scenario: [GDC-10014] Verify User is able return CUeT-4 rental in GOOD state.
    Given Create CUeTReturnGood user 
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in GOOD state
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button