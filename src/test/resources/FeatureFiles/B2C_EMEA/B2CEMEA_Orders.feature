Feature: B2C EMEA Order Scenarios

  #################################################  Smoke   ################################################################
  @Emea_Smoke
  Scenario: [GDC-237] Verify that user is able to complete transaction through paypal
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
   And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-emea |
      | status    |            200   |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-emea |
      | status    |            200   | 
    #------------old paypal---------------#
    #And I launch paypal for B2C stores
      #| basestore | cengage-b2c-emea |
      #| status    |              200 |
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I hit api to place B2C order using Paypal
      #| basestore | cengage-b2c-emea |
      #| status    |              200 |

  # Removed
  #Scenario: [GDC-714] Verify that user is able to place an order using 3DS enabled Visa credit card.
  #Given I Hit Api to create B2CEMEA Token
  #Given I hit API to create B2CEMEA user
  #When I hit API to create B2CEMEA cart
  #| basestore | cengage-b2c-emea |
  #| status    |              201 |
  #And User add B2C products to cart
  #| basestore | cengage-b2c-emea |
  #| Product   | emeaProduct_2    |
  #| status    |              200 |
  #When User adds delivery address to cart
  #| basestore | cengage-b2c-emea |
  #| address   | emea_address     |
  #| status    |              201 |
  #And User adds billing address to cart
  #| basestore | cengage-b2c-emea |
  #| address   | emea_address     |
  #| status    |              201 |
  #Then User gets all delivery modes
  #| basestore | cengage-b2c-emea |
  #| status    |              200 |
  #When User puts delivery mode
  #| basestore | cengage-b2c-emea               |
  #| mode      | EMEA_Express_Shipping_Domestic |
  #| status    |                            200 |
  #And I launch dummy CyberSource
  #| basestore | cengage-b2c-emea |
  #And User Enters Visa4 card details
  #	And Accept Visa securit popup
  #Then User verifies ACCEPT message
  #Then User place order for B2C cart
  #| basestore | cengage-b2c-emea |
  #| status    |              201 |
  #And Test Data for GDC-714 and order details
  @Emea_Smoke
  Scenario: [GDC-9821] Verify that tax is getting calculated if user uses the taxable address.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_4    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea     |
      | address   | emea_address_taxable |
      | status    |                  201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea     |
      | address   | emea_address_taxable |
      | status    |                  201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea      |
      | mode      | EMEA_Express_Shipping |
      | status    |                   200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    And I want to check totalTax amount is not 0.0
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    When I hit get order details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | totalTax.value | not zero |
    And Test Data for GDC-9821 and order details

  @Emea_Smoke
  Scenario: [GDC-9827] Verify that user is able to place an order for Ebook using 3DS disabled Master credit card
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaEbook        |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9827 and order details

  @Emea_Smoke
  Scenario: [GDC-9830]  Verify that user is able to place an order for Bundle using 3DS disbled Master Credit Card
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaBundle       |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9830 and order details

  @Emea_Smoke @Emea_Smoke_order
  Scenario: [GDC-9832] Verify that tax is not getting calculated if user uses the non-taxable address.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    When I hit get order details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
     | totalTax.value | 0.0 |
    And Test Data for GDC-9832 and order details

  #################################################  Smoke   ################################################################
  @B2C_EMEA_Order
  Scenario: [GDC-9804] Verify that user is able to place an order using 3DS enabled Master credit card
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Master card details
    And Accept Master securit popup
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9804 and order details

  @B2C_EMEA_Order
  Scenario: [GDC-9805]  Verify that user is able to place an order using 3DS enabled amex credit card
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Amex card details
    And Accept Amex securit popup
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9805 and order details

  @B2C_EMEA_Order
  Scenario: [GDC-895] OCC Order Cancellation API throws error when orderId Consignment status is not in FULFILLED state
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User hit Cancel Api to cancel order
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then I verify error with given message
      | Message | Cancellation is not possible as order is not having any consignment |
    And Test Data for GDC-895 and order details

  @B2C_EMEA_Order
  Scenario: [GDC-9838] User should not be able to place order without providing payment info
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-9838 and Cart details

  @B2C_EMEA_Order
  Scenario: [GDC-9828] Verify that user is able to place an order for Paperback.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9828 and order details

  @B2C_EMEA_Order
  Scenario: [GDC-9820] Verify that user is able to place an order using different billing and Delivery addresses.
    Given I Hit Api to create B2CEMEA Token
    #Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea     |
      | address   | emea_address_taxable |
      | status    |                  201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9820 and order details

  @B2C_EMEA_Order
  Scenario: [GDC-9829]  Verify that user is able to place an order with Shippable + eBook products using 3DS disbled Disover credit card.
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaEbook        |
      | status    |              200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_3    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Amex3 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9829 and order details

  @B2C_EMEA_Order
  Scenario: [GDC-9871] Verify that user is able to place an order using 3DS disabled AMEX card
    Given I Hit Api to create B2CEMEA Token
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Amex2 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-9871 and order details

  @B2C_EMEA_Order
  Scenario: [GDC-1035] Verify that order history API should return pagination, total pages and total orders.
    Given I Hit Api to create B2CEMEA Token
    When I hit api to get B2CEMEA user order history
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | pagination              | not null |
      | pagination.totalPages   | not zero |
      | pagination.totalResults | not zero |

  # ERP PHASE 2 TICKET - ADDED NEWLY
  @sapecomm-11252 @B2C_EMEA_Order
  Scenario: [GDC-12884] Verifying the Paypal full Authentication scenario for B2C EMEA
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaEbook        |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-emea |
      | status    |              200 |

  @sapecomm-11252 @B2C_EMEA_Order
  Scenario: [GDC-12891] Verifying the Paypal full Authentication scenario for B2C EMEA With Promo code
   Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I try to apply vouchers
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_20       |
      | status    |              200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_20       |
      | status    |              200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-emea |
      | status    |              200 |
