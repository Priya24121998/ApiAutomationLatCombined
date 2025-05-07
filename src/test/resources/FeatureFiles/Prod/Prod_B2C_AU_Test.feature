Feature: 5. Prod B2C AU

  @Prod_B2C_AU
  Scenario: [GDC-10237]Verify that user is able to sort the searched result as per fullTitle keywords using API:
    Given I Hit Api to create B2CAU Token
    And I Want to search product with following details
      | basestore | cengage-b2c-au |
      | query     | History        |
      | sort      | fullTitle-desc |
      | status    |            200 |
    Then I check if result is sorted using fullTitle

  @Prod_B2C_AU
  Scenario: [GDC-10251] Verify user is able to add bulk product in cart using API
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | B2C_ANZ_Mul_01 |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems | 2 |
    And Test Data for GDC-10251 and Cart details

  @Prod_B2C_AU
  Scenario: [GDC-9957] Verify that user has to pay delivery cost $0.00 if user purchases product equals to or more than $200[Physical Book]
   Given I Hit Api to create B2CAU Token
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | B2C_ANZ_Mul_01 |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then I verify Delivery address is added to cart
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then I verify Billing address is added to cart
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify some delivery modes
      | codes  |           1 |
      | code_0 | standard-au |
    And I verify delivery cost is 0.0
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 0 |
    And Test Data for GDC-9957 and Cart details

  @Prod_B2C_AU
  Scenario: [GDC-9959] Verify that user should be able to remove voucher using API
    Given I Hit Api to create B2CAU Token
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | B2C_ANZ_Mul_01 |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au |
      | voucherID | B2CAU_100      |
      | status    |            200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-au |
      | voucherID | B2CAU_100      |
      | status    |            200 |
    When I try to remove promocode
      | basestore | cengage-b2c-au |
      | promoCode | B2CAU_100      |
      | status    |            204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-au |
      | promoCode | B2CAU_100      |
      | status    |            200 |
    And Test Data for GDC-9959 and Cart details

  @Prod_B2C_AU
  Scenario: [GDC-10361] Verify that user should be able apply multiple coupons on cart
   Given I Hit Api to create B2CAU Token
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | B2C_ANZ_Mul_01 |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au |
      | voucherID | B2CAU_Fixed_1  |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au |
      | voucherID | B2CAU_50  |
      | status    |            200 |
    Then I verify 2 B2C coupons are applied
      | basestore   | cengage-b2c-au |
      | voucherID_0 | B2CAU_Fixed_1  |
      | voucherID_1 | B2CAU_50  |
      | status      |            200 |
    And Test Data for GDC-10361 and Cart details  
  
  @Prod_B2C_AU
  Scenario: [GDC-9956] Verify that user has to pay delivery cost $11.00 if user purchases product less than $200[Physical Book]
    Given I Hit Api to create B2CAU Token
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | B2C_ANZ_Phy_01 |
      | status    |            200 |
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
    And I verify delivery cost is 11.0
    And Test Data for GDC-9956 and Cart details

  @Prod_B2C_AU
  Scenario: [GDC-9963] Verify that user is able to place order with $0 for using 100% coupon code.
    Given I Hit Api to create B2CAU Token
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | B2C_ANZ_Phy_01 |
      | status    |            200 |
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
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value                   | not zero          |
      | totalItems                         |                 1 |
      | entries[0].product.isbn13Formatted | 978-1-4180-2123-8 |
      | entries[0].product.type            | NARRATIVE         |
      | totalPriceWithTax.value            | not zero          |
      | subTotal.value                     | not zero          |
      | deliveryAddress                    | not null          |
      | deliveryCost.value                 |                11 |
      | deliveryMode.code                  | standard-au       |
      | store                              | cengage-b2c-au    |
      | totalDiscounts.value               | 0.0               |
      | totalPrice.currencyIso             | AUD               |
      | billingAddress                     | not null          |
      | orderType                          | REGULAR           |
    When I try to apply vouchers
      | basestore | cengage-b2c-au |
      | voucherID | B2CAU_100      |
      | status    |            200 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    When I hit get order details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                 |                 1 |
      | entries[0].product.code    | 9781418021238@@NA |
      | orderDiscounts.value       | not zero          |
      | paymentInfo.billingAddress | not null          |
      | paymentMode                | Coupon Applied    |
      | totalPriceWithTax.value    |                 0 |
      | subTotal.value             | not zero          |
      | deliveryAddress            | not null          |
      | deliveryCost.value         |                 0 |
      | deliveryMode.code          | standard-au       |
      | store                      | cengage-b2c-au    |
      | totalDiscounts.value       | not zero          |
      | totalPrice.currencyIso     | AUD               |
      | orderType                  | REGULAR           |
    And Test Data for GDC-9963 and order details
