Feature: Upgrade Subscription


  ######################################### Regression ######################################

  #Cancel after upgrade
  @SubsUpgrade_PP
  Scenario: [GDC-10045] User should be able to cancel subscription after upgrading
    Given Create FullUpgradeSub user
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    And I log Test Data for subscription
    #When I click on sidebar sign out button
    And I log Test Data for subscription
    #When I click on sidebar sign out button



  #####################################       Credit Card      ########################################################
   #CU4 -> CU12
  @SubsUpgradeCC
  Scenario: [GDC-10016] User can upgrade CU 4 month to 12 months using CC
    Given Create FullUpgrade user
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
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is 129.99
    Then I check totalPriceWithTax amount is 70.0
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    #When I click on sidebar sign out button


 #-------------------------------------------------Removed as a part of SAPECOMM-11358 ---------------------------------------------------------------#
 #CUeT Tax
  @SAPECOMM-11358
  Scenario: [GDC-10005] Verify tax is calculated for CUet-4 months Purchase using Paypal.
    Given Create PPCuetToCU12 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add Taxable_Address to billing address
    And User adds Taxable_Address to delivery address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    Then User get order details
    And I want to check totalTax amount is not 0.0
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I log Test Data for subscription

  #CUeT to CU12
  @SAPECOMM-11358
  Scenario: [GDC-10164] Verify user can change duration from CUet to CU 12 months using Paypal
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is 79.99
    Then I check totalPriceWithTax amount is 120.0
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription

    #CUeT to CU4
  @SAPECOMM-11358
  Scenario: [GDC-10032] User can change duration from CUet to CU 4 months
    Given Create CuetToCU4 user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is 79.99
    Then I check totalPriceWithTax amount is 50.0
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I log Test Data for subscription
    #When I click on sidebar sign out button

  #CUeT to CU12
  @SAPECOMM-11358
  Scenario: [GDC-10023] User can change duration from CUet to CU 12 months
    Given Create CuetToCU12 user
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
    And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is 79.99
    Then I check totalPriceWithTax amount is 120.0
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription
    #When I click on sidebar sign out button

 

