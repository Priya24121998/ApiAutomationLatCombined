Feature: CU4 Discounted Rental Purchase

  ###########################################Shipping - Standard(CC)#############################################################
  #Multiple
  @CU4RentalPurCC
  Scenario: [GDC-10138] Verify User is able to purchase multiple rental: CU 4 months using standard shipping.
    Given Create MulCU4Rental user
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
    And I log Test Data for discountedRentals

  #When I click on sidebar sign out button
  ###########################################Shipping - Expedited (CC)#############################################################
  #multiple
  @CU4RentalPurCC
  Scenario: [GDC-10057] Verify User is able to purchase multiple rental: CU 4 months using expedited shipping.
    Given Create EXMulCU4Rental user
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is expedited-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals

  #When I click on sidebar sign out button
  #Single
  @CU4RentalPurCC
  Scenario: [GDC-9981] [API]Verify User is able to purchase single rental: CU 4 months(Expedited).
    Given Create EXCU4Rental user
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_4 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    And User launches CyberSource
    And User Enters Master3 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify 1 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    
    
  @SAPECOMM-11575 @CU4RentalPurCC
	Scenario: Verify rental plan of the rental book price is fixed to CU
	  Then Verify rental plan id is fixed to CU
	  And I log Test Data for rentals

  #Extend 30 days
  @CU4RentalPurCC
  Scenario: [GDC-10060] Verify User is able to extend CU-4 months rental to 30 days.
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 30 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 30
    And I log Test Data for discountedRentals
    
  @SAPECOMM-11575 @CU4RentalPurCC
  Scenario: Verify price of the 30 days extended rental book price is fixed to $30
  	Then Verify rental price is fixed to 30.0
  	And I log Test Data for rentals
  	

  #When I click on sidebar sign out button
  #Single
  @CU4RentalPurCC
  Scenario: [GDC-10020] [API] User is able to purchase single discounted rental: CU 4 months using standard shipping - Using 3DS disabled AMEX credit card
    Given Create CU4Rental user
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
    And User Enters Amex2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    

  #Extend 15 days
  @CU4RentalPurCC
  Scenario: [GDC-10071] Verify User is able extend CU-4 months rental to 15 days.
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 15
    And I log Test Data for discountedRentals
    
   @SAPECOMM-11575 @CU4RentalPurCC
	 Scenario: Verify price of the 15 days extended rental book price is fixed to $15
	  	Then Verify rental price is fixed to 15.0
	  	And I log Test Data for rentals
