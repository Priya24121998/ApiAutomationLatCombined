Feature: Coupons Scenario

################################################# Smoke ######################################################

@Coupons_Smoke
Scenario: [GDC-9909] Verify User is able to purchase CU Full 4 Months using coupon code.
Given Create CoupCU4 user 
#Given I open cengage commerce page
#And Add product to cart
When I Hit the API to add cart to user account and verify status code
And User adds 4Mon_Payload product to cart
And Add Taxable_Address to billing address
Then User Apply Coupon rental100
Then User place order and verify status code
Then I verify get state API response value of subscriptionPlan field is Full-Access-120
And I log Test Data for subscription
#When I click on sidebar sign out button


  #############################################   Subs-Purchase    ##########################################################

  
  

  #############################################   Rental-Purchase    ##########################################################
  
  @Coupons
  Scenario: [GDC-9979] Verify User is able to purchase CU Full 12 Months using coupon code.
    Given Create CoupCU12 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add Taxable_Address to billing address
    Then User Apply Coupon rental100
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription
    #When I click on sidebar sign out button
  
  @Coupons
  Scenario: [GDC-10000] Verify Standalone rental purchase using coupon code.
    Given Create CoupSTRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    Then User Apply Coupon rental100
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    #When I click on sidebar sign out button
    

  #CU4
  @Coupons
  Scenario: [GDC-10147] Verify CU-4 rental purchase using coupon code.
    Given Create CoupCU4Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    Then User Apply Coupon rental100
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU12
  @Coupons
  Scenario: [GDC-10109] Verify CU 12 rental purchase using coupon code  [using Standard-us mode]
    Given Create CoupCU12Rental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_3 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    Then User Apply Coupon rental100
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button


    
@Coupons
  Scenario: [GDC-10049] User should not be able to apply incorrect Coupon code
    Given Create Coup001 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add Taxable_Address to billing address
    And User adds Taxable_Address to delivery address
    Then User Apply Coupon invalid
    Then I verify Coupon Error Msg
    #When I click on sidebar sign out button

  @Coupons
  Scenario: [GDC-10030]: User should not be able to apply incorrect Coupon code
    Given Create Coup002 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental_3 product to cart
    And Add Taxable_Address to billing address
    And User adds Taxable_Address to delivery address
    Then User Apply Coupon invalid
    Then I verify Coupon Error Msg
    #When I click on sidebar sign out button
    

  
  #-------------------------------------------------Removed ---------------------------------------------------------------#   
    
     
    
    Scenario: [GDC-10025] Verify User is able to purchase CU Full 24 Months using coupon code.
    Given Create CoupCU24 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 24Mon_Payload product to cart
    And Add Taxable_Address to billing address
    Then User Apply Coupon rental100
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    

    #Removed as a part of SAPECOMM-11358
     #CUET  
    Scenario: [GDC-10158] Verify User is able to purchase CUeT using coupon code.
    Given Create CoupCUet user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add Taxable_Address to billing address
    Then User Apply Coupon rental100
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
     #CUET  
   Scenario: [GDC-10325]  Verify that user is able to cancel the subscription [Using Coupon code]
    Given Create user Coup003 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    Then User fetches cart details
    Then I check totalDiscounts amount is 0.0
    Then I check totalTax amount is 0.0
    And launch paypal
    Then I verify PayPal portal has launched successfully
    Then User Apply Coupon B2CUS_100
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then User fetches cart details
    And I want to check totalDiscounts amount is not 0.0
    And I want to check totalTax amount is not 0.0
    When I get subscription deatils using API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    And I log Test Data for subscription
    When I click on sidebar sign out button
    
    #CUET  
   Scenario: [GDC-10153] Verify CUeT-4 rental purchase using coupon code.
    Given Create CoupCUeTRental user 
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
    Then User Apply Coupon rental100
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button