Feature: 4. Prod B2C NZ

  @Prod_B2C_NZ
  Scenario: [GDC-10209]Verify that user is able to sort the searched result as per fullTitle keywords using API:
    Given I Hit Api to create B2CNZ Token
    And I Want to search product with following details
      | basestore | cengage-b2c-nz |
      | query     | History        |
      | sort      | fullTitle-desc |
      | status    |            200 |
    Then I check if result is sorted using fullTitle

  @Prod_B2C_NZ
  Scenario: [GDC-10199] Verify user is able to add multiple product in cart using API
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | B2C_ANZ_Mul_01 |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems | 2 |
    And Test Data for GDC-10199 and Cart details

  @Prod_B2C_NZ
  Scenario: [GDC-9943] Verify that user has to pay delivery cost $0.00 if user purchases product equals to or more than $200[Physical Book]
    Given I Hit Api to create B2CNZ Token
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | B2C_ANZ_Mul_01 |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then I verify Delivery address is added to cart
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then I verify Billing address is added to cart
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify some delivery modes
      | codes  |           1 |
      | code_0 | standard-nz |
    And I verify delivery cost is 0.0
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 0 |
    And Test Data for GDC-9943 and Cart details

  @Prod_B2C_NZ
  Scenario: [GDC-9937]  Verify that user should be able to remove voucher using API
    Given I Hit Api to create B2CNZ Token
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | B2C_ANZ_Mul_01 |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_100      |
      | status    |            200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_100      |
      | status    |            200 |
    When I try to remove promocode
      | basestore | cengage-b2c-nz |
      | promoCode | B2CNZ_100      |
      | status    |            204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-nz |
      | promoCode | B2CNZ_100      |
      | status    |            200 |
    And Test Data for GDC-9937 and Cart details

  @Prod_B2C_NZ
  Scenario: [GDC-10362]  Verify that user should be able apply multiple coupons on cart
    Given I Hit Api to create B2CNZ Token
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | B2C_ANZ_Phy_02 |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID |  B2CNZ_50			 |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_Fixed_1  |
      | status    |            200 |
    Then I verify 2 B2C coupons are applied
      | basestore   | cengage-b2c-nz |
      | voucherID_0 | B2CNZ_50  		 |
      | voucherID_1 | B2CNZ_Fixed_1  |
      | status      |            200 |
    And Test Data for GDC-10362 and Cart details

  @Prod_B2C_NZ
  Scenario: [GDC-9944]  Verify that user has to pay delivery cost $11.00 if user purchases product less than $200[Physical Book]
    Given I Hit Api to create B2CNZ Token
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | B2C_ANZ_Phy_02 |
      | status    |            200 |
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
    And I verify delivery cost is 11.0
    And Test Data for GDC-9944 and Cart details

  @Prod_B2C_NZ
  Scenario: [GDC-9935]  Verify that user is able to place order with $0 for using 100% coupon code.
     When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | B2C_ANZ_Phy_02 |
      | status    |            200 |
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
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value                   | not zero          |
      | totalItems                         |                 1 |
      | entries[0].product.isbn13Formatted | 978-0-8019-8325-2 |
      | entries[0].product.type            | NARRATIVE         |
      | totalPriceWithTax.value            | not zero          |
      | subTotal.value                     | not zero          |
      | deliveryAddress                    | not null          |
      | deliveryCost.value                 |                11 |
      | deliveryMode.code                  | standard-nz       |
      | store                              | cengage-b2c-nz    |
      | totalDiscounts.value               | 0.0		           |
      | totalPrice.currencyIso             | NZD               |
      | billingAddress                     | not null          |
      | orderType                          | REGULAR           |
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_100      |
      | status    |            200 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    When I hit get order details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                 |                 1 |
      | entries[0].product.code    | 9780801983252@@NA |
      | orderDiscounts.value       | not zero          |
      | paymentInfo.billingAddress | not null          |
      | paymentMode                | Coupon Applied    |
      | totalPriceWithTax.value    |                 0 |
      | subTotal.value             | not zero          |
      | deliveryAddress            | not null          |
      | deliveryCost.value         |                 0 |
      | deliveryMode.code          | standard-nz       |
      | store                      | cengage-b2c-nz    |
      | totalDiscounts.value       | not zero          |
      | totalPrice.currencyIso     | NZD               |
      | orderType                  | REGULAR           |
    And Test Data for GDC-9935 and order details
