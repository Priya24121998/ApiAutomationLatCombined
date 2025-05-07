Feature: Rental Buyout

 
  ###############################################   (Credit Card)   ############################################
  @RentalBuyoutCC
  Scenario: Verify User is able to purchase rental textbook to buyout using CC.
    Given Create RentalBuy user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    

  @RentalBuyoutCC
  Scenario: [GDC-10135] Verify User is able to buyout standalone rental.
    When I Hit the API to add cart to user account and verify status code
    And User hit rental buyout api
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is PURCHASED
    And I log Test Data for rentals
    #When I click on sidebar sign out button

  

  #									CU-4
  @RentalBuyoutCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-4
    Given Create CU4RentalBuy user 
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
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE

  @RentalBuyoutCC
  Scenario: [GDC-10059] Verify User is able to buyout CU-4 months rental .
    When I Hit the API to add cart to user account and verify status code
    And User hit rental buyout api
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is PURCHASED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #									CU-12
  @RentalBuyoutCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-12
    Given Create CU12RentalBuy user 
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
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE

  @RentalBuyoutCC
  Scenario: [GDC-10143] Verify User is able to buyout CU-12 months rental.
    When I Hit the API to add cart to user account and verify status code
    And User hit rental buyout api
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is PURCHASED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

#-------------------------------------------------Removed ---------------------------------------------------------------#  
  #									CU-24
  Scenario: Verify User is able to purchase discounted  rentals of CU-24
    Given Create CU24RentalBuy user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_5 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE

  Scenario: [GDC-10058] Verify User is able to buyout CU-24 months rental .
    When I Hit the API to add cart to user account and verify status code
    And User hit rental buyout api
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is PURCHASED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    
    
    
     #----------------------Removed as a part of SAPECOMM-11358------------------------#
    #Cuet
  Scenario: Verify User is able to purchase discounted  rentals of CUeT-4
    Given Create CUeTRentalBuy user 
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
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE

  Scenario: [GDC-10038] Verify User is able to buyout CUeT-4 months rental .
    When I Hit the API to add cart to user account and verify status code
    And User hit rental buyout api
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is PURCHASED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
     ###############################################    PayPal    ############################################
  #@RentalBuyoutPP
  #Scenario: Verify User is able to purchase rental textbook to buyout using Paypal.
    #Given Create PPRentalBuy user 
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
    #Then I place order using Paypal
    #Then Verify user is able to ship rental using API
    #Then Verify rental status in return list of rental API is ACTIVE
#
  #@RentalBuyoutPP
  #Scenario: [GDC-10110] Verify User is able to buyout rental using paypal.
    #When I Hit the API to add cart to user account and verify status code
    #And User hit rental buyout api
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is PURCHASED
    #And I log Test Data for rentals
    ##When I click on sidebar sign out button
#
  #Cuet
  #@RentalBuyoutPP
  #Scenario: Verify User is able to purchase discounted  rentals of CUeT-4 using Paypal.
    #Given Create PPCUeTRentalBuy user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase eTextbook120_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_2 product to cart
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
    #Then I verify shipping method is standard-us
    #Then Verify user is able to ship rental using API
    #Then Verify rental status in return list of rental API is ACTIVE
#
  #@RentalBuyoutPP
  #Scenario: [GDC-10152] Verify User is able to buyout CUeT-4 months rental using paypal.
    #When I Hit the API to add cart to user account and verify status code
    #And User hit rental buyout api
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is PURCHASED
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
#
  #@RentalBuyoutPP
  #Scenario: Verify User is able to purchase discounted  rentals of CU-4 using Paypal.
    #Given Create PPCU4RentalBuy user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 4Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-120
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
    #Then I verify shipping method is standard-us
    #Then Verify user is able to ship rental using API
    #Then Verify rental status in return list of rental API is ACTIVE
#
  #@RentalBuyoutPP
  #Scenario: [GDC-10092] Verify User is able to buyout CU-4 months rental using paypal.
    #When I Hit the API to add cart to user account and verify status code
    #And User hit rental buyout api
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is PURCHASED
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
#
  #@RentalBuyoutPP
  #Scenario: Verify User is able to purchase discounted  rentals of CU-12 using Paypal.
    #Given Create PPCU12RentalBuy user 
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
    #Then I place order using Paypal
    #Then I verify shipping method is standard-us
    #Then Verify user is able to ship rental using API
    #Then Verify rental status in return list of rental API is ACTIVE
#
  #@RentalBuyoutPP
  #Scenario: [GDC-10073] Verify User is able to buyout CU-12 months rental using paypal.
    #When I Hit the API to add cart to user account and verify status code
    #And User hit rental buyout api
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is PURCHASED
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
#
  #@RentalBuyoutPP
  #Scenario: Verify User is able to purchase discounted  rentals of CU-24 using Paypal.
    #Given Create PPCU24RentalBuy user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 24Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_4 product to cart
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
    #Then I verify shipping method is standard-us
    #Then Verify user is able to ship rental using API
    #Then Verify rental status in return list of rental API is ACTIVE
#
  #@RentalBuyoutPP
  #Scenario: [GDC-10062] Verify User is able to buyout CU-24 months rental using paypal.
    #When I Hit the API to add cart to user account and verify status code
    #And User hit rental buyout api
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    #Then Verify rental status in return list of rental API is PURCHASED
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
    
