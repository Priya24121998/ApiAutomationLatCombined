Feature: 2. Prod B2C EMEA

  @Prod_B2C_EMEA
  Scenario: [GDC-9817] Verify that user is able to search product details [PDP] using API.
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea  |
      | product     | 9781337696456@@NA |
      | status    |               200 |
    Then I verify results in response
      | isbn13            | 9781337696456 |
      | price.currencyIso | GBP           |

  @Prod_B2C_EMEA
  Scenario: [GDC-9819] Verify that user is able to remove the applied promo code from Cart.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | B2C_Emea_Phy_02  |
      | status    |              200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_100      |
      | status    |              200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_100      |
      | status    |              200 |
    When I try to remove promocode
      | basestore | cengage-b2c-emea |
      | promoCode | B2CEMEA_100      |
      | status    |              204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-emea |
      | promoCode | B2CEMEA_100      |
      | status    |              200 |
    And Test Data for GDC-9819 and Cart details

  @Prod_B2C_EMEA
  Scenario: [GDC-10368]Verify that a PayPal url is generated and user can navigate to the UI using the PayPal url.
    Given I Hit Api to create B2CEMEA Token
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | B2C_Emea_Phy_01  |
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
    Then I verify some delivery modes
      | codes  |                              1 |
      | code_0 | EMEA_Express_Shipping_Domestic |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify totalTax amount is 0.0
    And I launch paypal for B2C stores
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify PayPal portal has launched successfully
    And Test Data for GDC-10316 and cart details

  @Prod_B2C_EMEA @Emea_Smoke
  Scenario: [GDC-10318] Verify that user is able to complete transaction with multiple products through 100% off Coupon code
    Given I Hit Api to create B2CEMEA Token
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | B2C_EMEA_Mul_01  |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea     |
      | address   | emea_address_taxable |
      | status    |                  201 |
    Then I verify Delivery address is added to cart
    And User adds billing address to cart
      | basestore | cengage-b2c-emea     |
      | address   | emea_address_taxable |
      | status    |                  201 |
    Then I verify Billing address is added to cart
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify some delivery modes
      | codes  |                     1 |
      | code_0 | EMEA_Express_Shipping |
    When User puts delivery mode
      | basestore | cengage-b2c-emea      |
      | mode      | EMEA_Express_Shipping |
      | status    |                   200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    And I want to check totalTax amount is not 0.0
    Then I verify following details in API response
      | totalItems                         |                     2 |
      | entries[0].product.isbn13Formatted | 978-1-4080-8308-6     |
      | entries[1].product.isbn13Formatted | 978-1-285-74314-1     |
      | entries[1].product.type            | NARRATIVE             |
      | entries[0].product.type            | NARRATIVE             |
      | totalPriceWithTax.value            | not zero              |
      | subTotal.value                     | not zero              |
      | totalTax.value                     | not zero              |
      | deliveryAddress                    | not null              |
      | deliveryCost.value                 | not zero              |
      | deliveryMode.code                  | EMEA_Express_Shipping |
      | store                              | cengage-b2c-emea      |
      | totalDiscounts.value               |                     0 |
      | totalPrice.currencyIso             | GBP                   |
      | billingAddress                     | not null              |
      | orderType                          | REGULAR               |
    When I try to apply vouchers
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_100      |
      | status    |              200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-emea |
      | voucherID | B2CEMEA_100      |
      | status    |              200 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    When I hit get order details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | totalItems                 |                     2 |
      | entries[0].product.code    | 9781408083086@@NA     |
      | entries[1].product.code    | 9781285743141@@NA     |
      | orderDiscounts.value       | not zero              |
      | paymentInfo.billingAddress | not null              |
      | paymentMode                | Coupon Applied        |
      | totalPriceWithTax.value    |                     0 |
      | subTotal.value             | not zero              |
      | totalTax.value             |                     0 |
      | deliveryAddress            | not null              |
      | deliveryCost.value         |                     0 |
      | deliveryMode.code          | EMEA_Express_Shipping |
      | store                      | cengage-b2c-emea      |
      | totalDiscounts.value       | not zero              |
      | totalPrice.currencyIso     | GBP                   |
      | orderType                  | REGULAR               |
    And Test Data for GDC-10318 and order details
