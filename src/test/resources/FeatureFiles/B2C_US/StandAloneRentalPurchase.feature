Feature: Standanlone Rental Purchase

  ################################################## Smoke ###############################################################
  @RentalPur_Smoke
  Scenario: [GDC-9913] Verify User is able to purchase multiple rental textbook using a 3DS disbled Discover credit card- Expedited Shipping
    Given Create StandMulRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds MulRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
  	 Then User fetches cart details
    Then I check deliveryCost amount is 9.99
		And User launches CyberSource
    And User Enters Discover card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is expedited-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    #When I click on sidebar sign out button

  ############################################### Regression #################################################
  @RentalPurCC
  Scenario: [GDC-10015] [API]Verify User is able to purchase multiple rental textbook using Credit Card..
    Given Create StandMulRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds MulRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
		And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    #When I click on sidebar sign out button

  @RentalPurCC
  Scenario: [GDC-10103] Verify User is able to purchase rental textbook using CC.
    Given Create StandRental user 
    #Given I open cengage commerce page
    #And Add product to cart
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
    #When I click on sidebar sign out button

  @RentalPurCC
  Scenario: [GDC-10148] Verify User is able to purchase rental textbook using CC-expedited-us Shipping  
    Given Create StandEXRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put expedited-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    #When I click on sidebar sign out button

  @RentalPurCC
  Scenario: [GDC-10117] Verify User is able to purchase rental textbook using standard shipping.
    Given Create StanRental user 
    #Given I open cengage commerce page
    #And Add product to cart
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
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    
    
  @SAPECOMM-11575 @RentalPurCC
	Scenario: Verify price of the rental book price is fixed to $75
	  Then Verify rental price is fixed to 75.0
	  And I log Test Data for rentals
	  
	@SAPECOMM-11575 @RentalPurCC
	Scenario: Verify rental plan of the rental book price is fixed to 1063
	  Then Verify rental plan id is fixed to 1063
	  And I log Test Data for rentals

  @RentalPurCC
  Scenario: [GDC-9996] Verify User is able to extend rental textbook to 15 days.
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
    And I log Test Data for rentals
    #When I click on sidebar sign out button

	@SAPECOMM-11575 @RentalPurCC 
	Scenario: Verify price of the 15 days extended rental book price is fixed to $15
	  	Then Verify rental duration is increased to 15
	  	Then Verify rental price is fixed to 15.0
	  	And I log Test Data for rentals


  @RentalPurCC
  Scenario: [GDC-10034] Verify User is able to purchase rental textbook using expedited shipping.
    Given Create ExpRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental_2 product to cart
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
    And I log Test Data for rentals
    
  @SAPECOMM-11575 @RentalPurCC
	Scenario: Verify price of the rental book price is fixed to $75
	  Then Verify rental price is fixed to 75.0
	  And I log Test Data for rentals
	  
	@SAPECOMM-11575 @RentalPurCC
	Scenario: Verify rental plan of the rental book price is fixed to 1063
	  Then Verify rental plan id is fixed to 1063
	  And I log Test Data for rentals

  @RentalPurCC
  Scenario: [GDC-10007] Verify User is able to extend rental textbook to 30 days.
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
    And I log Test Data for rentals
    #When I click on sidebar sign out button
    

  @SAPECOMM-11575 @RentalPurCC
  Scenario: Verify price of the 30 days extended rental book price is fixed to $30
  	Then Verify rental duration is increased to 30
  	Then Verify rental price is fixed to 30.0
  	And I log Test Data for rentals
  	
    
  @RentalPurCC
  Scenario: [GDC-10063] [Partially Automated] Verify that IP Address field is updated in Backoffice if user place an order with IP address for Rental.
    Given Create StandRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart with IP to user account and verify status code
    And User adds StandAloneRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    #When I click on sidebar sign out button
    
    
      #Scenario: [GDC-10133] Verify User is able to extend rental textbook to 15 days using paypal.
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
    #And I log Test Data for rentals
    ##When I click on sidebar sign out button
#
  #Scenario: [GDC-10083] Verify User is able to extend rental textbook to 30 days using paypal.
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
    #And I log Test Data for rentals
    ##When I click on sidebar sign out button
    