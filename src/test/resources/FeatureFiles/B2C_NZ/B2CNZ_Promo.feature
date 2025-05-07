Feature: B2C NZ Promo Code Scenarios

  #################################################  Smoke   ################################################################
  @B2C_NZ_Promo_Smoke
  Scenario: [GDC-9935] Verify that user is able to place order with $0 for using 100% coupon code.
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_3 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_100      |
      | status    |            200 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And Test Data for GDC-9935 and order details

  @B2C_NZ_Promo_Smoke
  Scenario: [GDC-9939] Verify that user able to apply product based coupon code along with Fixed/Percent coupon code
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | NZb2cDigital_3 |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz  |
      | voucherID | B2CNZ_Product_2 |
      | status    |             200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_50       |
      | status    |            200 |
    Then I verify 2 B2C coupons are applied
      | basestore   | cengage-b2c-nz  |
      | voucherID_0 | B2CNZ_Product_2 |
      | voucherID_1 | B2CNZ_50        |
      | status      |             200 |
    And Test Data for GDC-9939 and Cart details

  @B2C_NZ_Promo_Smoke
  Scenario: [GDC-9934] Verify that user should be able to apply multiple voucher code[Fixed/Percent] & get discount based on coupon code priority
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_4 |
      | status    |             200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_Fixed_1  |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_50       |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify 2 B2C coupons are applied
      | basestore   | cengage-b2c-nz |
      | voucherID_0 | B2CNZ_Fixed_1  |
      | voucherID_1 | B2CNZ_50       |
      | status      |            200 |
    And Test Data for GDC-9934 and Cart details

  @B2C_NZ_Promo_Smoke
  Scenario: [GDC-9937] Verify that user should be able to remove voucher using API
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_2 |
      | status    |             200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_50       |
      | status    |            200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_50       |
      | status    |            200 |
    When I try to remove promocode
      | basestore | cengage-b2c-nz |
      | promoCode | B2CNZ_50       |
      | status    |            204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-nz |
      | promoCode | B2CNZ_50       |
      | status    |            200 |
    And Test Data for GDC-9937 and Cart details

  #################################################  Reggression   ###########################################################
  @B2C_NZ_Promo
  Scenario: [GDC-10197] Verify that user should be able to apply voucher code using API
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_4 |
      | status    |             200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_Fixed_2  |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |      1  |
      | totalPriceWithTax.value |not zero |
    And I verify totalDiscounts amount is 5.0
    And Test Data for GDC-10197 and Cart details

  @B2C_NZ_Promo
  Scenario: [GDC-10203] Verify that user is not able to add invalid promo code using API:
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_1 |
      | status    |             200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | Invalid_Promo  |
      | status    |            400 |
    Then I verifies Promocode Error massage
      | Msg | The coupon code is not valid. |
    And Test Data for GDC-10203 and Cart details
