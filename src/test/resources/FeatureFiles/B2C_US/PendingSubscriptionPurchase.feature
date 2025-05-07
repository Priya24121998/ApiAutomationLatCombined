Feature: Pending Subscription Purchase

  ############################################## Smoke ########################################################
  @PendingSubs_Smoke
  Scenario: [GDC-9905] Verify that user is able to cancel pending CU-4 months subscription if intial subscription in ACTIVE state
    Given Create PenCU4 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
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
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I verify pending Subscription is Full-Access-120
    Then User hit Cancel Api to cancel PENDING subscription
    Then User verify subscription is CANCELLED
    And I log Test Data for subscription
    

  ############################################### Regression ##########################################################
  @PendingSubs
  Scenario: [GDC-10128] User has an active CU 4 months and user purchases CU-4 months again
    Given Create PenCU4 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I verify pending Subscription is Full-Access-120

  @PendingSubs
  Scenario: [GDC-9984] User should be able activate pending subscription once original subscription has cancelled
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    When I Activate pending subscription
    Then I verify pending subscription status is ACTIVE
    And I log Test Data for subscription
    #When I click on sidebar sign out button

  @PendingSubs
  Scenario: [GDC-10004] User has an active CU 12 months and user purchases CU-12 months again
    Given Create PenCU12 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I verify pending Subscription is Full-Access-365

  @PendingSubs
  Scenario: [GDC-10084] Verify that user is able to cancel pending CU-12 months subscription if intial subscription in ACTIVE state
    Then User hit Cancel Api to cancel PENDING subscription
    Then I verify pending subscription status is CANCELLED
    And I log Test Data for subscription
    #When I click on sidebar sign out button

  @PendingSubs
  Scenario: [GDC-10163] User has an active CU 24 months and user purchases CU-24 months again
    Given Create PenCU24 user 
    When I purchase 24Mon_SKU subscription plan through API
    When I purchase 24Mon_SKU subscription plan through API
    #When I Hit the API to add cart to user account and verify status code
    #And User adds 24Mon_Payload product to cart
    #And Add NonTaxable_Address to billing address
    #And User launches CyberSource
    #And User Enters Visa2 card details
    #Then User verifies ACCEPT message
    #Then User place order and verify status code
    When I get subscription deatils using API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I verify pending Subscription is Full-Access-730
    And I log Test Data for CU24 Pending

  @PendingSubs
  Scenario: [GDC-10154] Verify that user is able to cancel pending CU-24 months subscription if intial subscription in ACTIVE state
    #Then User hit Cancel Api to cancel PENDING subscription
    When I update pending subscription status to CANCELLED
    Then I verify pending subscription status is CANCELLED
    And I log Test Data for CU24 Pending
    #When I click on sidebar sign out button

  @PendingSubs
  Scenario: [GDC-10105] [CU-12] Student should be able to Active pending subscription if current subscription has been cancelled/expired
    Given Create PenCUeT8371 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I verify pending Subscription is Full-Access-365
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    When I Activate pending subscription
    Then I verify pending subscription status is ACTIVE
    And I log Test Data for subscription
    #When I click on sidebar sign out button

  @PendingSubs
  Scenario: [GDC-10055] [CU-24 months] Student should be able to Active pending subscription if current subscription has been cancelled/expired (using Create sub API)
    Given Create PenCU10055 user 
    When I purchase 24Mon_SKU subscription plan through API
    When I purchase 24Mon_SKU subscription plan through API
    When I get subscription deatils using API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    And I verify pending Subscription is Full-Access-730    
    Then I update subscription status to CANCELLED
    Then User verify subscription is CANCELLED
    When I Activate pending subscription
    Then I verify pending subscription status is ACTIVE
    And I log Test Data for CU24 Pending
    
    #-------------------------Removed as a part of SAPECOMM-11358--------------------------------------------#
    Scenario: [GDC-10091] [CUet]Student should be able to Active pending subscription if current subscription has been cancelled/expired
    Given Create PenCUeT8280 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I verify pending Subscription is CU-ETextBook-120
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    When I Activate pending subscription
    Then I verify pending subscription status is ACTIVE
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    
    Scenario: [GDC-10085] User has an active CUet months and user purchases CUet months again.
    Given Create PenCUeT user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I verify pending Subscription is CU-ETextBook-120

    Scenario: [GDC-10075] Verify that user is able to cancel pending CUeT subscription if intial subscription in ACTIVE state
    Then User hit Cancel Api to cancel PENDING subscription
    Then I verify pending subscription status is CANCELLED
    And I log Test Data for subscription
    #When I click on sidebar sign out button

    Scenario: [GDC-10056] User has active 4/12 months CU and user purchase CU-ETextBook-120 again using CC.
    Given Create PenCUeT_A user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I verify pending Subscription is CU-ETextBook-120
    And I log Test Data for subscription
    #When I click on sidebar sign out button
