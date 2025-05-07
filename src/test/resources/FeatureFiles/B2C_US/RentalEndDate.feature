Feature: Rental EndDate



  ###############################################Shipping - Standard (CC)############################################
  #StandAlone
  @RentalEndDateCC
  Scenario: [GDC-10070] Verify Start and End date of Standalone rental using cc
    Given Create STRenEnd user 
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I verify if start date of the rental is current date
    Then I Verify rental enddate is 180 days later
    And I log Test Data for rentals

  @RentalEndDateCC    
  Scenario: [GDC-9995] Verify Rental cancellation using Cancel API.    
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for rentals
    #When I click on sidebar sign out button
    
	
    

  #CU-4
  @RentalEndDateCC
  Scenario: [GDC-9998] Verify Start and End date of CU-4 rental using CC
    Given Create CU4RenEnd user 
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
    Then I verify if Rental Start date is start date of the Subscription
    Then I verify end date of discounted rental and end date Cu is same
    And I log Test Data for discountedRentals
  
  @RentalEndDateCC  
  Scenario: [GDC-10102] Verify CU-4 Rental cancellation using Cancel API.    
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    

  #									CU-12
  @RentalEndDateCC
  Scenario: [GDC-10037] Verify Start and End date of CU-12 rental using CC
    Given Create CU12RenEnd user 
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
    Then I verify if Rental Start date is start date of the Subscription
    Then I verify end date of discounted rental and end date Cu is same
    And I log Test Data for discountedRentals

	@RentalEndDateCC
  Scenario: [GDC-10107] Verify CU-12 Rental cancellation using Cancel API.    
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
   
    #-------------------------------------------------Removed ---------------------------------------------------------------#    

  #CU-24
  Scenario: [GDC-10066] Verify Start and End date of CU-24 rental using CC
    Given Create CU24RenEnd user 
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
    Then I verify if Rental Start date is start date of the Subscription
    Then Verify rental duration for 24 mon CU is maximum 1 year
    And I log Test Data for discountedRentals
    
  Scenario: [GDC-10041] Verify CU-24 Rental cancellation using Cancel API.    
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    
    
 #----------------------Removed as a part of SAPECOMM-11358------------------------#
	 Scenario: purchase single rental: CUet 4 months using standard shipping
    Given Create CuetRenEnd user 
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_3 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Discover card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I verify if Rental Start date is start date of the Subscription
    Then I verify end date of discounted rental and end date Cu is same

  Scenario: [GDC-10169] Verify CUeT-4 Rental cancellation using Cancel API.    
    Then Verify rental status in return list of rental API is ACTIVE
    And User hit update Api to CANCELLED Rental
    Then Verify rental status in return list of rental API is CANCELLED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
