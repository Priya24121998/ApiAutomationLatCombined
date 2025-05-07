Feature: B2C EMEA Promo Code Scenarios

  #################################################  Smoke   ################################################################
  @Emea_Smoke
  Scenario: [GDC-891] Verify that user is able to place an order with Coupon code + using 3DS disabled VISA credit card.
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
      | voucherID | B2CEMEA_30       |
      | status    |              200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_30       |
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
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-891 and order details
    
  @Emea_Smoke
  Scenario: [GDC-9816] Verify that user is able to complete transaction through PayPal + Coupon code
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
    When I try to apply vouchers
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_30       |
      | status    |              200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_30       |
      | status    |              200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-emea |
      | status    |            200   |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-emea |
      | status    |            200   | 
    And Test Data for GDC-9816 and order details

  #################################################  Smoke   ################################################################
  @B2C_EMEA_Promo
  Scenario: [GDC-9818] Verify that user isn’t able to apply multiple promo codes in single order.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
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
      | voucherID | B2CEMEA_30       |
      | status    |              200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-emea |
      | voucherID |   B2CEMEA_30     |
      | status    |              200 |
    And I try to apply vouchers
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_Fixed    |
      | status    |              400 |
    Then I verifies Promocode Error massage
      | Msg | This cart is not valid for accepting multiple coupons |
    And Test Data for GDC-9818 and cart details
   
  @B2C_EMEA_Promo
  Scenario: [GDC-9819] Verify that user is able to remove the applied promo code from Cart.
    Given I Hit Api to create B2CEMEA Token
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
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
      | basestore | cengage-b2c-emea        |
      | voucherID | B2CEMEA_30 |
      | status    |                     200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-emea        |
      | voucherID | B2CEMEA_30 |
      | status    |                     200 |
    When I try to remove promocode
      | basestore | cengage-b2c-emea        |
      | promoCode | B2CEMEA_30 |
      | status    |                     204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-emea        |
      | promoCode | B2CEMEA_30 |
      | status    |                     200 |
    And Test Data for GDC-9819 and Cart details
       
   
