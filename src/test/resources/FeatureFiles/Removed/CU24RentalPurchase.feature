Feature: CU24 Discounted Rental Purchase

  

  ###########################################Shipping - Standard (CC)#############################################################
  #Single
  
  Scenario: [GDC-10043] Verify User is able to purchase single rental: CU 24 months using standard shipping.
    Given Create CU24Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals

  
  Scenario: [GDC-10067] Verify User is able to extend CU-24 months rental to 15 days.
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

  #Multiple
  
  Scenario: [GDC-10050] Verify User is able to purchase multiple rental: CU 24 months using standard shipping.
    Given Create MulCU24Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  ###########################################Shipping - Expedited (CC)#############################################################

 Scenario: [GDC-10140] Verify User is able to purchase single rental: CU 24 months(Expedited)
    Given Create EXCU24Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
  
  Scenario: [GDC-9986] Verify User is able to extend CU-24 months rental to 30 days.
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


  #Multiple
  
  Scenario: [GDC-10101] Verify User is able to purchase multiple rental: CU 24 months using expedited shipping
    Given Create EXMulCU24Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    
    
    ###########################################Shipping - Standard (Paypal)#############################################################
  #Single
  #CU24RentalPurPP
  #Scenario: [SAPECOMM-7026] Verify User is able to purchase single rental: CU 24 months using paypal(standard shipping).
    #Given Create PPCU24Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 24Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals


 #CU24RentalPurPP
  #Scenario: [GDC-10019] Verify User is able to extend CU-24 months rental to 15 days using Paypal.
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

  #Multiple
  #CU24RentalPur_Paypal
  #Scenario: [SAPECOMM-7053] [API]Verify User is able to purchase multiple rental: CU 24 months using standard shipping (Paypal).
    #Given Create PPMulCU24Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 24Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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

  ###########################################Shipping - Expedited (Paypal)#############################################################
  #single
  #CU24RentalPurPP
  #Scenario: [SAPECOMM-7034] [API]Verify User is able to purchase single rental: CU 24 months using paypal(Expedited).
    #Given Create EXPPCU24Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 24Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals
#
 #CU24RentalPurPP
  #Scenario: [GDC-9991] Verify User is able to extend CU-24 months rental to 30 days using Paypal.
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


  #Multiple
  #CU24RentalPur_Paypal
  #Scenario: [SAPECOMM-7057] Verify User is able to purchase multiple rental: CU 24 months using expedited shipping (Paypal).
    #Given Create EXPPMulCU24Rental user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 24Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    ##Then I place order using Paypal
    #When I click on Go To Dashboard link   
    #Then Verify 2 rental status in return list of rental API is ORDERED
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
  
   #-------------------------------------------------Removed ---------------------------------------------------------------#     
      #Single
 
