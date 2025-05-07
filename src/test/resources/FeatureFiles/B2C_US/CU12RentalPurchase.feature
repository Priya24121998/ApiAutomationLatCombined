Feature: CU12 Discounted Rental Purchase

 
  ###########################################(CC)#############################################################
  #Single
  @CU12RentalPurCC
  Scenario: [GDC-10124] Verify User is able to purchase single rental: CU 12 months using standard shipping.
    Given Create CU12Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
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

	@SAPECOMM-11575 @CU12RentalPurCC
	Scenario: Verify rental plan of the rental book price is fixed to CU
	  Then Verify rental plan id is fixed to CU
	  And I log Test Data for rentals
	  
  @CU12RentalPurCC
  Scenario: [GDC-10095] Verify User is able extend CU-12 months rental to 15 days.
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
    #When I click on sidebar sign out button
    
  @SAPECOMM-11575 @CU12RentalPurCC
	Scenario: Verify price of the 15 days extended rental book price is fixed to $15
	  	Then Verify rental price is fixed to 15.0
	  	And I log Test Data for rentals

  #Multiple
  @CU12RentalPurCC
  Scenario: [GDC-10009] Verify User is able to purchase multiple rental: CU 12 months using standard shipping.
    Given Create MulCU12Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_2 product to cart
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

  #Single
  @CU12RentalPurCC
  Scenario: [GDC-10002] Verify User is able to purchase single rental: CU 12 months using Expedited shipping.
    Given Create EXCU12Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_3 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals

  @CU12RentalPurCC
  Scenario: [GDC-10162] Verify User is able to extend CU-12 months rental to 30 days.
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
    #When I click on sidebar sign out button


	@SAPECOMM-11575 @CU12RentalPurCC
  Scenario: Verify price of the 30 days extended rental book price is fixed to $30
  	Then Verify rental price is fixed to 30.0
  	And I log Test Data for rentals
  	
  	
  #Multiple
  @CU12RentalPurCC
  Scenario: [GDC-10121] Verify User is able to purchase multiple rental: CU 12 months using expedited shipping.
    Given Create EXMulCU12Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is expedited-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    
    ######################### Removed
    
     #Multiple
  #@CU12RentalPur_Paypal
  #Scenario: [SAPECOMM-7052] Verify User is able to purchase multiple rental: CU 12 months using standard shipping using paypal.
    #Given Create PPMulCU12Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 12Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    #When I Hit the API to add cart to user account and verify status code
    #And User adds MulcuRental_1 product to cart
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #Then I get delivery modes
    #Then I put standard-us as shipping mode
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link   
    ##Then I place order using Paypal
    #Then Verify 2 rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button

  ###############################################Shipping - Expedited (Paypal)############################################
  #single


  #Multiple
  #@CU12RentalPur_Paypal
  #Scenario: [SAPECOMM-7056] Verify User is able to purchase multiple rental: CU 12 months using expedited shipping using paypal.
    #Given Create PPEXMulCU12Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 12Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    #When I Hit the API to add cart to user account and verify status code
    #And User adds MulcuRental_2 product to cart
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #Then I get delivery modes
    #Then I put expedited-us as shipping mode
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link   
    ##Then I place order using Paypal
    #Then Verify 2 rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
    
    
    ###############################################(Paypal)############################################
  #Single
  #@CU12RentalPur_PP 
  #Scenario: [GDC-10022] Verify User is able to purchase single rental: CU 12 months using paypal(standard shipping).
    #Given Create PPCU12Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 12Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_3 product to cart
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #Then I get delivery modes
    #Then I put standard-us as shipping mode
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link  
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals
    #
 #@CU12RentalPur_PP 
  #Scenario: [GDC-10024] Verify User is able to extend CU-12 months rental to 15 days using paypal.
    #Then Verify rental status in return list of rental API is ORDERED
    #Then Verify user is able to ship rental using API
    #Then Verify rental status in return list of rental API is ACTIVE
    #Then I get rentalEndDate
    #When I Hit the API to add cart to user account and verify status code
    #And user extend rental for 15 days
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link  
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ACTIVE
    #Then Verify rental duration is increased to 15
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button    
    #
      #@CU12RentalPur_PP
  #Scenario: [SAPECOMM-7033] Verify User is able to purchase  single rental: CU 12 months using paypal(Expedited).
    #Given Create PPEXCU12Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 12Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_4 product to cart
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #Then I get delivery modes
    #Then I put expedited-us as shipping mode
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link  
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals
#
 #@CU12RentalPur_PP
  #Scenario: [GDC-10064] Verify User is able to extend CU-12 months rental to 30 days using paypal .
    #Then Verify rental status in return list of rental API is ORDERED
    #Then Verify user is able to ship rental using API
    #Then Verify rental status in return list of rental API is ACTIVE
    #Then I get rentalEndDate
    #When I Hit the API to add cart to user account and verify status code
    #And user extend rental for 30 days
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link  
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ACTIVE
    #Then Verify rental duration is increased to 30
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
    
    
