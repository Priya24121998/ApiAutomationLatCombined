Feature: Duration Change

  ######################################### Smoke ######################################################
  @DurChange_Smoke
 	Scenario: [GDC-9980] User can change duration from CU-4 months to CU-12 months - Using credit card
    Given Create CU4ToCU12 user 
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 12Mon_SKU
    And Add Taxable_Address to billing address
    Then User fetches cart details
    Then I check totalDiscounts amount is 139.99
    Then I check totalPriceWithTax amount is 79.76
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    Then I check totalDiscounts amount is 139.99
    Then I check totalPriceWithTax amount is 79.76
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription
    
 	@DurChange_Smoke
  Scenario: [GDC-9999] User can change duration from CU 12 months to CU 4 months - Using credit card
    Given Create CU12ToCU4 user 
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 4Mon_SKU
    And Add NonTaxable_Address to billing address
   	Then User fetches cart details
    Then I check totalDiscounts amount is 214.99
    Then I check totalPriceWithTax amount is -75.0
    Then User place order and verify status code
    Then User get order details
    Then I check totalDiscounts amount is 214.99
    Then I check totalPriceWithTax amount is -75.0
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I log Test Data for subscription
    #When I click on sidebar sign out button

  ################################################ Regression ########################################################
  @DurChangeCC
  Scenario: [GDC-10123] Verify that tax is calculated for duration change from CU-4 months to CU-12 months.
    Given Create CU4ToCU12 user 
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 12Mon_SKU
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    Then User get order details
    And I want to check totalTax amount is not 0.0
    And I log Test Data for subscription

  ##### PayPal
  @DurChangePP 
  Scenario: [GDC-10001] Verify user can change duration from CU 4 to CU 12 months using Paypal
    Given Create PPCU4ToCU12 user 
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I will check order number is displayed after completion of paypal order
    When I get subscription deatils using API
    And I hit durationchange Api for 12Mon_SKU
    And Add NonTaxable_Address to billing address
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-us |
      | status    |            200 |
    And I wait for 15 sec
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    Then I will check order number is displayed after completion of paypal order
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    Then User get order details
    Then I check totalDiscounts amount is 139.99
    Then I check totalPriceWithTax amount is 75.0
    And I log Test Data for subscription
	
	@DurChangeCC
  Scenario: [GDC-10458] Verify that $100.00 totalDiscounts amount should  appear under Get Cart Details, Order Place, and Get Order Details APIs when user downgrades the subs[CU12 to CU4] and uses the 50% coupon code.
    #Given Create CU12ToCU4 user 
    Given Create user CU12ToCU4 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    Then User Apply Coupon B2CUS_50
    Then User fetches cart details
    Then I check totalDiscounts amount is 99.99
    Then I check totalPriceWithTax amount is 100.0
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 4Mon_SKU
    And Add NonTaxable_Address to billing address
    Then User fetches cart details
    Then I check totalDiscounts amount is 100.0
    Then I check totalPriceWithTax amount is 29.99
    And User launches CyberSource
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    Then User get order details
    Then I check totalDiscounts amount is 100.0
    Then I check totalPriceWithTax amount is 29.99
    And I log Test Data for subscription

 
 #-------------------------------------------------Removed ---------------------------------------------------------------#   
 
  Scenario: [GDC-10160] Verify user can change duration from CU 12 to CU 24 months using Paypal
    Given Create PPCU12ToCU24 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    When I get subscription deatils using API
    And I hit durationchange Api for 24Mon_SKU
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
    
     Scenario: [GDC-10098] Verify user can change duration from CU 4 to CU 24 months using Paypal
    Given Create PPCU4ToCU24 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    When I get subscription deatils using API
    And I hit durationchange Api for 24Mon_SKU
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    #When I click on Go To Dashboard link 
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
  Scenario: [GDC-10111] User can change duration from CU-24 months to CU-12 months
    Given Create CU24ToCU12 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 24Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 12Mon_SKU
    And Add NonTaxable_Address to billing address
    #And User launches CyberSource
    #And User Enters Visa2 card details
    #Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
  Scenario: [GDC-10099] User can change duration from CU-12 months to CU-24 months
    Given Create CU12ToCU24 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 24Mon_SKU
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
  Scenario: [GDC-9989] User can change duration from CU-4 months to CU-24 months
    Given Create CU4ToCU24 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 24Mon_SKU
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
  Scenario: [GDC-9917] User can change duration from CU 24 months to CU 12 months & CU 12 months to CU 4 months
    Given Create doubleDown user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 24Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 12Mon_SKU
    And Add NonTaxable_Address to billing address
    #And User launches CyberSource
    #And User Enters Master2 card details
    #Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I get subscription deatils using API
    And I hit durationchange Api for 4Mon_SKU
    And Add NonTaxable_Address to billing address
    #And User launches CyberSource
    #And User Enters Visa2 card details
    #Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
     Scenario: [GDC-9912] [API]User can change duration from CU 4 months to CU 12 months & CU 12 months to CU 24 months
    Given Create doubUpgrade user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Amex card details
    And Accept AmEx securit popup
    Then User verifies ACCEPT message
    Then User place order and verify status code
    When I get subscription deatils using API
    And I hit durationchange Api for 12Mon_SKU
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Discover card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I get subscription deatils using API
    And I hit durationchange Api for 24Mon_SKU
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for subscription
    #When I click on sidebar sign out button
