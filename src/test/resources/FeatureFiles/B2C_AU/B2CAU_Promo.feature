Feature: B2C AU Promo Code Scenarios

  #################################################  Smoke   ################################################################
  @B2C_AU_Promo_Smoke
  Scenario: [GDC-9959] Verify that user should be able to remove voucher using API
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au           |
      | voucherID | B2CAU_Fixed_1 |
      | status    |                      200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-au           |
      | voucherID | B2CAU_Fixed_1 |
      | status    |                      200 |
    When I try to remove promocode
      | basestore | cengage-b2c-au           |
      | promoCode | B2CAU_Fixed_1 |
      | status    |                      204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-au           |
      | promoCode | B2CAU_Fixed_1 |
      | status    |                      200 |
    And Test Data for GDC-9959 and Cart details

  @B2C_AU_Promo_Smoke
  Scenario: [GDC-9963] Verify that user is able to place order with $0 for using 100% coupon code.
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_3 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au       |
      | voucherID | B2CAU_100 |
      | status    |                  200 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And Test Data for GDC-9963 and order details

  @B2C_AU_Promo_Smoke
  Scenario: [GDC-9954] Verify that user should be able to apply multiple voucher code[Fixed/Percent] & get discount based on coupon code priority
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_4 |
      | status    |             200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au      |
      | voucherID | B2CAU_50 |
      | status    |                 200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au            |
      | voucherID | B2CAU_Fixed_1 |
      | status    |                       200 |
    Then I verify 2 B2C coupons are applied
      | basestore   | cengage-b2c-au            |
      | voucherID_0 | B2CAU_50       |
      | voucherID_1 | B2CAU_Fixed_1 |
      | status      |                       200 |
    And Test Data for GDC-9954 and Cart details

  @B2C_AU_Promo_Smoke
  Scenario: [GDC-9951] Verify that user able to apply product based coupon code along with Fixed/Percent coupon code
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | QA_AUb2cDigital_4 |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au      |
      | voucherID | B2CAU_50 |
      | status    |                 200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au                    |
      | voucherID | B2CAU_Product_1 |
      | status    |                               200 |
    Then I verify 2 B2C coupons are applied
      | basestore   | cengage-b2c-au                    |
      | voucherID_0 | B2CAU_50               |
      | voucherID_1 | B2CAU_Product_1 |
      | status      |                               200 |
    And Test Data for GDC-9951 and Cart details

  #################################################  Reggression   ###########################################################
  @B2C_AU_Promo
  Scenario: [GDC-10253] Verify that user should be able to apply voucher code using API
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au           |
      | voucherID | B2CAU_Fixed_2 |
      | status    |                      200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |     1    |
      | totalPriceWithTax.value | not zero |
    And I verify totalDiscounts amount is 5.0
    And Test Data for GDC-10253 and Cart details

  @B2C_AU_Promo
  Scenario: [GDC-10229] Verify that user is not able to add invalid voucher code using API:
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au      |
      | voucherID | Invalid_Promo |
      | status    |                 400 |
    Then I verifies Promocode Error massage
      | Msg | The coupon code is not valid. |
    And Test Data for GDC-10229 and Cart details
    
  @B2C_AU_Promo
  Scenario: [GDC-10239] Verify that user should be charged with $11 after applying coupon code to total price which makes total price less than $200.
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_4 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    And I verify delivery cost is 0.0
    When I try to apply vouchers
      | basestore | cengage-b2c-au           |
      | voucherID | B2CAU_50 |
      | status    |                      200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    And I verify delivery cost is 11.0
    And Test Data for GDC-10239 and Cart details
