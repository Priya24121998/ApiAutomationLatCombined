Feature: CUeT Discounted Rental Purchase

  
  ###########################################Shipping - Standard(CC)#############################################################
  #Single
 
  @CUeTRentalPurCC
  Scenario: [GDC-10156] [API]Verify User is able to purchase single rental: CUet 4 months using standard shipping - using 3DS disabled Disover credit card.
    Given Create CuetRental user 
    #Given I open cengage commerce page
    #And Add product to cart
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
    
    
    @SAPECOMM-11575 @CUeTRentalPurCC
	Scenario: Verify rental plan of the rental book price is fixed to CU
	  Then Verify rental plan id is fixed to CU
	  And I log Test Data for rentals
	  
     @CUeTRentalPurCC 
  Scenario: [GDC-9983] Verify User is able to extend rental textbook to 15 days.
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
    
   @SAPECOMM-11575 @CUeTRentalPurCC
	 Scenario: Verify price of the 15 days extended rental book price is fixed to $15
	  	Then Verify rental price is fixed to 15.0
	  	And I log Test Data for rentals
    

  #Multiple
  @CUeTRentalPurCC
  Scenario: [GDC-10013] Verify User is able to purchase multiple rental: CUet 4 months using standard shipping.
    Given Create CuetMulRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
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
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  ###########################################Shipping - Expedited (CC)#############################################################
  #Single
  @CUeTRentalPurCC
  Scenario: [GDC-10168] Verify User is able to purchase Single rental: CUet 4 months (expedited).
    Given Create EXCuetRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_4 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify 1 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
   
  @CUeTRentalPurCC
  Scenario: [GDC-10053] Verify User is able to extend CUeT-4 months rental to 30 days.
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
    
  @SAPECOMM-11575 @CUeTRentalPurCC
  Scenario: Verify price of the 30 days extended rental book price is fixed to $30
  	Then Verify rental price is fixed to 30.0
  	And I log Test Data for rentals
  	

  #Multiple
  @CUeTRentalPurCC
  Scenario: [GDC-10029] Verify User is able to purchase rental: CUet 4 months using expedited shipping.
    Given Create EXMulCuetRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is expedited-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    ###########################################Shipping - Standard(Paypal)#############################################################
  #Single
  #@CUeTRentalPurPP
  #Scenario: [GDC-10150] Verify User is able to purchase single rental: CUet 4 months using paypal(Standard shipping).
    #Given Create PPCuetRental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase eTextbook120_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_1 product to cart
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #Then I get delivery modes
    #Then I put standard-us as shipping mode
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link  
#		#Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals

 #@CUeTRentalPurPP
  #Scenario: [GDC-10146] Verify User is able to extend CUeT-4 months rental to 15 days using paypal
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
#		#Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ACTIVE
    #Then Verify rental duration is increased to 15
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button

  #Multiple
  #@CUeTRentalPur_Paypal
  #Scenario: [SAPECOMM-7050] Verify User is able to purchase multiple rental: CUet 4 months using standard shipping(PayPal).
  #Given Create PPMulCuetRental user 
  ##Given I open cengage commerce page
  ##And Add product to cart
  #When I purchase eTextbook120_SKU subscription plan through API
  #Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
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
  #Then I verify shipping method is standard-us
  #Then Verify rental status in return list of rental API is ORDERED
  #And I log Test Data for discountedRentals
  ##When I click on sidebar sign out button
  ###########################################Shipping - Expedited(Paypal)#############################################################
 
  #Single
  #@CUeTRentalPurPP
  #Scenario: [SAPECOMM-7027] Verify User is able to purchase single rental: CUet 4 months using paypal(Expedited).
    #Given Create PPEXCuetRental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase eTextbook120_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_2 product to cart
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #Then I get delivery modes
    #Then I put expedited-us as shipping mode
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link  
#		#Then I place order using Paypal
    #Then I verify shipping method is expedited-us
    #Then Verify rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals
#
 #@CUeTRentalPurPP
  #Scenario: [GDC-10076] Verify User is able to extend CUeT-4 months rental to 30 days using paypal.
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
#		#Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ACTIVE
    #Then Verify rental duration is increased to 30
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button

  #multiple
  #@CUeTRentalPur_Paypal
  #Scenario: [SAPECOMM-7054] Verify User is able to purchase rental: CUet 4 months using standard shipping(PayPal).
  #Given Create PPEXMulCuetRental user 
  ##Given I open cengage commerce page
  ##And Add product to cart
  #When I purchase eTextbook120_SKU subscription plan through API
  #Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
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
  #Then I verify shipping method is expedited-us
  #Then Verify rental status in return list of rental API is ORDERED
  #And I log Test Data for discountedRentals
  ##When I click on sidebar sign out button
