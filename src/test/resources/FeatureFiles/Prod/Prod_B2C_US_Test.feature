Feature: 1. Prod B2C US

  @Prod_B2C_US_1
  Scenario: [GDC-10323] Verify that user has to pay discounted amount for CU purchase if already have Ebook
    Given Create user Prod_DPS10323 and login to application
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
#    When I click on sidebar sign out button

     #-------------------------------------------------Removed as a part of SAPECOMM-11358----------------------------------------------------------------#

  Scenario: [GDC-10367] Verify that a PayPal url is generated and user can navigate to the UI using the PayPal url.
    Given Create user PPCuetToCU4 and login to application
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
    And I log Test Data for Cart


  Scenario: [GDC-10324] Verify user can upgrade from CUet [ purchases using coupon code] to CU 4 months subscriptions.
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
    And I log Test Data for Cart


  Scenario: [GDC-10325]  Verify that user is able to cancel the subscription [Using Coupon code]
    When I get subscription deatils using API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    Then User hit Cancel Api to cancel ACTIVE subscription
    Then User verify subscription is CANCELLED
    And I log Test Data for subscription
    When I click on sidebar sign out button
