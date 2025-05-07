Feature: Subscription Purchase and Cacellation

  ########################################### PayPal ############################################
  @SubsPurchase_Smoke
  Scenario: [GDC-9916] Verify that last added sub will replace the already added sub in the cart
    Given Create SubsPur002 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds MulCuProduct product to cart
    Then User fetches cart details
    Then verify product in cart is Full-Access-120

  
  ############################################        Credit Card          ###################################################
  @SubsPurchaseCC_Smoke
  Scenario: [GDC-9906] Verify User is able to purchase CU Full 4 Months using 3DS enabled Visa credit card
    Given Create SubsPur006 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I log Test Data for subscription

  #When I click on sidebar sign out button
  @SubsPurchaseCC_Smoke
  Scenario: [GDC-9915] User is able to cancel CU 4 months sub purchased using 3DS disabled Master Credit Card
    Given Create SubsPur010 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    And I log Test Data for subscription

  #When I click on sidebar sign out button
  ############################################        Regression          ###################################################
 
  #CU12
  @SubsPurchaseCC
  Scenario: [GDC-9974] [API]Verify User is able to purchase CU Full 12 Months using 3DS disabled VISA credit card
    Given Create SubsPur007 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart with IP to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription

  @SubsPurchaseCC
  Scenario: [GDC-10061] Verify tax calculation for 4/12 months CU purchase using CC
    Then User get order details
    And I want to check totalTax amount is not 0.0
    And I log Test Data for subscription

  #CU12
  @SubsPurchaseCC
  Scenario: [GDC-10021] Verify that end date of CU-12 months subs is 12 months
    When I get subscription deatils using API
    And I Verify Subscription enddate is 365 days later
    And I log Test Data for subscription

  @SubsPurchaseCC
  Scenario: [GDC-10068] [Partially Automated] Verify that IP Address field is updated in Backoffice if user place an order with IP address for CU.
    Then User get order details
    And I log Test Data for subscription


  #CU4
  @SubsPurchasePP
  Scenario: [GDC-10108] Verify user is able to purchase CU 4 months using Paypal
    Given Create SubsPur003 user
    #Given I open cengage commerce page
    #And Add product to cart
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
    And I wait for 12 sec
    Then I will check order number is displayed after completion of paypal order
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I log Test Data for subscription
    
    #-----------for old paypal---------
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase

  #CU4
  @SubsPurchasePP
  Scenario: [GDC-10074] Verify that end date of CU-4 months subs is 4 months
    When I get subscription deatils using API
    And I Verify Subscription enddate is 4 months later
    And I log Test Data for subscription

  #When I click on sidebar sign out button
  @SubsPurchasePP
  Scenario: [GDC-10129] Verify user is able to purchase CU 24 months using Create sub API
    Given Create CU24_API user
    #Given I open cengage commerce page
    #And Add product to cart
    #When I Hit the API to add cart to user account and verify status code
    #And User adds 24Mon_Payload product to cart
    #And Add NonTaxable_Address to billing address
    #And launch paypal
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I verify order number is displayed
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    When I purchase 24Mon_SKU subscription plan through API
    When I get subscription deatils using API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for CU24

  #When I click on sidebar sign out button
  #CU24
  @SubsPurchasePP
  Scenario: [GDC-10114] Verify that end date of CU-24 months subs is 24 months from start date[Purchases using Create Sub API]
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I Verify Subscription enddate is 730 days later
    And I log Test Data for CU24

  @SubsPurchasePP
  Scenario: [GDC-10118] User is able to cancel 24 months sub purchased using Create Sub API
    When I get subscription deatils using API
    #Then User hit Cancel Api to cancel ACTIVE subscription
    When I update subscription status to CANCELLED
    Then User verify subscription is CANCELLED
    And I log Test Data for CU24

  #When I click on sidebar sign out button
  @SubsPurchasePP
  Scenario: [GDC-10120] Verify user is able to purchase CU 12 months using Paypal
    Given Create SubsPur005 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
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
    And I wait for 12 sec
    Then I will check order number is displayed after completion of paypal order
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription

  #When I click on sidebar sign out button
  #-------------------------------------------------Removed ---------------------------------------------------------------#
  Scenario: [GDC-9982] Verify User is able to purchase CU Full 24 Months using 3DS enabled Master credit card
    Given Create SubsPur008 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 24Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Master card details
    When Accept Master securit popup
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I log Test Data for subscription
    
     #-------------------------------------------------Removed as a part of SAPECOMM-11358----------------------------------------------------------------#
    #CUET
    @SAPECOMM-11358
  Scenario: [GDC-9908] Verify User is able to purchase CUeT using Paypal
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I log Test Data for subscription

    #CUET
    @SAPECOMM-11358
  Scenario: [GDC-9910] User is able to cancel CUeT purchased through paypal
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    And I log Test Data for subscription
  #When I click on sidebar sign out button
  
   #CUET
   @SAPECOMM-11358
  Scenario: [GDC-10089] Verify User is able to purchase CUeT using 3DS enabled amex credit card
    Given Create CUeTCancel user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart with IP to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Amex card details
    When Accept Amex securit popup
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I log Test Data for subscription

  #CUET
  @SAPECOMM-11358
  Scenario: [GDC-10028] Verify that end date of CUet-4 months subs is 4 months.
    When I get subscription deatils using API
    And I Verify Subscription enddate is 4 months later
    And I log Test Data for subscription

  #CUET
  @SAPECOMM-11358
  Scenario: [GDC-9985] User is able to cancel CUet 4 months sub.
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    And I log Test Data for subscription

  Scenario: [GDC-10081] [Partially Automated] Verify that IP Address field is updated in Backoffice if user place an order with IP address for CUet.
    Then User get order details
    And I log Test Data for subscription

  #When I click on sidebar sign out button
