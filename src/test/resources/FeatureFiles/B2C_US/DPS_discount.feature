Feature: DPS Discount Scenarios

  #DPS discount we need to create user through OKTA API.
  #because DPS to work, user should be registered in OLR.
  @DPS_discountSmoke
  Scenario: [GDC-10144] Verify that user has to pay discounted amount for CU purchase if already have Ebook
    Given I Hit Api to create B2CUS Token
    Given I hit API to create B2CUS user
    When I hit API to create B2CUS cart
      | basestore | cengage-b2c-us |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-us |
      | Product   | EbkStpRental   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-us  |
      | address   | Taxable_Address |
      | status    |             201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-us  |
      | address   | Taxable_Address |
      | status    |             201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-us |
      | status    |            200 |
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
    Then User get order details
    And I want to check totalTax amount is not 0.0
    Then I get cuEligible price and save it
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalPriceWithTax amount is 214.99
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
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365


  @DPS_discountCC
  Scenario: [GDC-10137] Verify that user has to pay discounted amount for CU purchase if already have CU eligible product
    Given Create user DPSdiscount_3 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds CUeligibleProduct product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    Then I verify totalTax amount is 0.0
    Then I get cuEligible price and save it
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is cuEligible
    Then I check totalPriceWithTax amount is 37.99
    And Add NonTaxable_Address to billing address
    And I navigate to paypal new url for B2C stores using GUID
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    #When I click on Go To Dashboard link
    #Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I log Test Data for subscription
    When I click on sidebar sign out button


  @DPS_discountCC
  Scenario: [GDC-10042] Verify that user should not get discount twice when upgrade CU product to CU
    Given Create user DPSdiscount_4 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    Then I verify totalTax amount is 0.0
    Then I get cuEligible price and save it
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is cuEligible
    Then I check totalPriceWithTax amount is 84.0
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is 0.0
    Then I check totalPriceWithTax amount is 199.99
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription
    When I click on sidebar sign out button

  @DPS_discountCC @exone
  Scenario: [GDC-10323] Verify that user has to pay discounted amount for CU purchase if already have Ebook
    Given Create user DPSdiscount_5 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook_2 product to cart
    And Add Taxable_Address to billing address
    Then User Apply Coupon B2CUS_100
    Then User place order and verify status code
    Then User get order details
    Then I get cuEligible price and save it
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is cuEligible
    And I log Test Data for Cart
    When I click on sidebar sign out button

  @DPS_discountCC
  Scenario: [GDC-12793] Verify the previous order number details while upgrading Ebook> CU 4> CU 12
    Given Create user DPSdiscount_1 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    Then I get previousOrder from response
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    Then User fetches cart details
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I get previousOrder from response
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I get previousOrder from response
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I log Test Data for subscription

  #When I click on sidebar sign out button
  #----------------------Removed as a part of SAPECOMM-11358-----------------------------------------------------#
  #CUeT
  Scenario: [GDC-10125] Verify that user has to pay discounted amount for CUet purchase if already have Ebook
    Given Create user DPSdiscount_1 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    Then I verify totalTax amount is 0.0
    Then I get cuEligible price and save it
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is cuEligible
    Then I check totalPriceWithTax amount is 34.0
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I log Test Data for subscription
    When I click on sidebar sign out button

  Scenario: [GDC-10044] Verify that user should not get discount twice when upgrade CU product to CUeT
    Given Create user DPSdiscount_5 and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook_2 product to cart
    And Add Taxable_Address to billing address
    And User adds Taxable_Address to delivery address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I want to check totalTax amount is not 0.0
    Then I get cuEligible price and save it
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is cuEligible
    Then I check totalPriceWithTax amount is 34.0
    And Add NonTaxable_Address to billing address
    And User adds NonTaxable_Address to delivery address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I get subscription deatils using API
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is 0.0
    Then I check totalPriceWithTax amount is 69.99
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I log Test Data for subscription
    When I click on sidebar sign out button