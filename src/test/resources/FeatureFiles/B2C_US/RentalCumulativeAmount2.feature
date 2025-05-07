Feature: Rental Cumulative[Purchase+Extend+ Return in BAD state]

 ###############################################Shipping - Standard (CC)############################################

@CumulativeCC
  Scenario: [GDC-10082] Verify Standalone Rental Purchase + Extend + Return in BAD state using CC
    Given Create STRenComm_2 user 
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
    Then I get purchased latest price and save it
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
    Then Verify rental duration is increased to 15
    Then I get extended latest price and save it
    Then Verify rental status in return list of rental API is ACTIVE
		When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    Then I get forcedpurchased latest price and save it
    Then I verify cumulative total price with listPrice when forcedpurchased
    And I log Test Data for rentals
    #When I click on sidebar sign out button
	 
	

  #CU-4
  @CumulativeCC
  Scenario: [GDC-10112] [API]Verify CU-4/12 Rental Purchase + Extend + Return in BAD state using CC
    Given Create CU4RenComm_2 user 
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
    Then I get purchased latest price and save it
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
    Then Verify rental duration is increased to 15
    Then I get extended latest price and save it
    Then Verify rental status in return list of rental API is ACTIVE
		When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    Then I get forcedpurchased latest price and save it
    Then I verify cumulative total price with listPrice when forcedpurchased
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    
     #----------------------Removed as a part of SAPECOMM-11358-----------------------------------#
     #CUeT
  Scenario: [GDC-9978] Verify CUeT-4 Rental Purchase + Extend + Return in BAD state using CC.
    Given Create CUeTRenComm_2 user 
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
    Then I get purchased latest price and save it
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
    Then Verify rental duration is increased to 15
    Then I get extended latest price and save it
    Then Verify rental status in return list of rental API is ACTIVE
		When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    Then I get forcedpurchased latest price and save it
    Then I verify cumulative total price with listPrice when forcedpurchased
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
     ###############################################Shipping - Standard (Paypal)############################################
  #									StandAlone
  #@CumulativePP 
  #Scenario: [GDC-10096] Verify Standalone Rental Purchase[Using CC] + Extend[Using Paypal] + Return in BAD state 
    #Given Create PPSTRenComm_2 user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I Hit the API to add cart to user account and verify status code
    #And User adds StandAloneRental product to cart
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
#		And User launches CyberSource
    #And User Enters Amex2 card details
    #Then User verifies ACCEPT message
    #Then User place order and verify status code
    #Then I get purchased latest price and save it
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
    #Then Verify rental duration is increased to 15
    #Then I get extended latest price and save it
    #Then Verify rental status in return list of rental API is ACTIVE
#		When I return rental in BAD state
    #Then Verify rental status in return list of rental API is FORCEDPURCHASE
    #Then I get forcedpurchased latest price and save it
    #Then I verify cumulative total price with listPrice when forcedpurchased
    #And I log Test Data for rentals
    ##When I click on sidebar sign out button

  #									CUeT
  #@CumulativePP 
  #Scenario: [GDC-9977] Verify CUeT-4 Rental Purchase[Using CC] + Extend[Using Paypal] + Return in BAD state 
    #Given Create PPCUeTRenComm_2 user 
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
#		And User launches CyberSource
    #And User Enters Discover2 card details
    #Then User verifies ACCEPT message
    #Then User place order and verify status code
    #Then I get purchased latest price and save it
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
    #Then Verify rental duration is increased to 15
    #Then I get extended latest price and save it
    #Then Verify rental status in return list of rental API is ACTIVE
    #When I return rental in BAD state
    #Then Verify rental status in return list of rental API is FORCEDPURCHASE
    #Then I get forcedpurchased latest price and save it
    #Then I verify cumulative total price with listPrice when forcedpurchased
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button

  #									CU-4
  #@CumulativePP
  #Scenario: [GDC-10069] Verify CU-4/12/24 Rental Purchase[Using CC] + Extend[Using Paypal] + Return in BAD state
    #Given Create PPCU4RenComm_2 user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 4Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-120
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
#		#Then I place order using Paypal
#		And User launches CyberSource
    #And User Enters Visa2 card details
    #Then User verifies ACCEPT message
    #Then User place order and verify status code
    #Then I get purchased latest price and save it
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
    #Then Verify rental duration is increased to 15
    #Then I get extended latest price and save it
    #Then Verify rental status in return list of rental API is ACTIVE
#		When I return rental in BAD state
    #Then Verify rental status in return list of rental API is FORCEDPURCHASE
    #Then I get forcedpurchased latest price and save it
    #Then I verify cumulative total price with listPrice when forcedpurchased
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button

  #@CumulativePP
  #Scenario:  Verify CU-12 Rental Purchase + Extend+ Return in BAD state using paypal.
    #Given Create PPCU12RenComm_2 user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 12Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_5 product to cart
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
    #Then I get purchased latest price and save it
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
		##Then I place order using Paypal
    #Then Verify rental duration is increased to 15
    #Then I get extended latest price and save it
    #Then Verify rental status in return list of rental API is ACTIVE
#		When I return rental in BAD state
    #Then Verify rental status in return list of rental API is FORCEDPURCHASE
    #Then I get forcedpurchased latest price and save it
    #Then I verify cumulative total price with listPrice when forcedpurchased
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button



    