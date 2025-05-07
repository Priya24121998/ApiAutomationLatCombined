Feature: B2C CA Promo Code Scenarios

  #################################################  Smoke   ################################################################
  @B2C_CA_Promo_Smoke
  Scenario: [GDC-9973] Verify that user is able to place order for using 100% coupon code.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_100      |
      | status    |            200 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And Test Data for GDC-9973 and order details

  @B2C_CA_Promo_Smoke
  Scenario: [GDC-9970] Verify that the user is able to place an order using Coupon code [less than 100% off]+Credit card.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Amex card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And Test Data for GDC-9970 and order details

  @B2C_CA_Promo_Smoke
  Scenario: [GDC-9971] Verify that the user is able to place an order using using Coupon code [less than 100% off]+PayPal.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-ca |
      | status    |            200 |
   # And I launch paypal for B2C stores
    #  | basestore | cengage-b2c-ca |
    #  | status    |            200 |
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I hit api to place B2C order using Paypal
      ##| basestore | cengage-b2c-ca |
    #  | status    |            200 |
    #And Test Data for GDC-9971 and order details

  #################################################  Reggression   ###########################################################
  @B2C_CA_Promo
  Scenario: [GDC-10290] Verify that user should be able to apply voucher code using API
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |     1 |
      | totalPriceWithTax.value | not zero |
    And I verify totalDiscounts amount is 50.47
    And Test Data for GDC-10290 and Cart details

  @B2C_CA_Promo
  Scenario: [GDC-10265] Verify that user is not able to add invalid voucher code using API:
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | Invalid_Promo  |
      | status    |            400 |
    Then I verifies Promocode Error massage
      | Msg | The coupon code is not valid. |
    And Test Data for GDC-10265 and Cart details

  @B2C_CA_Promo
  Scenario: [GDC-10274] Verify that user should get an error while applying multiple coupon codes
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            400 |
    Then I verifies Promocode Error massage
      | Msg | This cart is not valid for accepting multiple coupons |
    And Test Data for GDC-10274 and Cart details

  @B2C_CA_Promo
  Scenario: [GDC-10276] Verify that user should be able to remove voucher using API
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            200 |
    When I try to remove promocode
      | basestore | cengage-b2c-ca |
      | promoCode | B2CCA_50       |
      | status    |            204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-ca |
      | promoCode | B2CCA_50       |
      | status    |            200 |
    And Test Data for GDC-10276 and Cart details
