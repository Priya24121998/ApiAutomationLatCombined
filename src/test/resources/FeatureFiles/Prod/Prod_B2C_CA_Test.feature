Feature: 1. Prod B2C CA

  @Prod_B2C_CA
  Scenario: [GDC-10292] Verify that user is able to sort the searched result as per copyrightYear keywords using API
    Given I Hit Api to create B2CCA Token
    And I Want to search product with following details
      | basestore | cengage-b2c-ca     |
      | query     | maths              |
      | sort      | copyrightYear-desc |
      | status    |                200 |
    Then I verify search results are in descending order

  @Prod_B2C_CA
  Scenario: [GDC-9968]  Verify user is able to get the product details using API.
    Given I Hit Api to create B2CCA Token
    And I hit PDP search
      | basestore | cengage-b2c-ca |
      | product     |  9780176766009 |
      | status    |            200 |
    Then I verify results in response
      | isbn13                  |             9780176766009 |
      | purchaseOptions[0].code | 9780176766009@@NA         |
      | buyable                 | true                      |
      | fullTitle               | Becoming a Master Student |
      | copyrightYear           |                      2020 |
      | mediaType               | Print                     |
      | type                    | NARRATIVE                 |

  @Prod_B2C_CA
  Scenario: [GDC-10326] Verify the tax is getting calculated for Ebook/Bundle/Shippable products for taxable address.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | B2C_CA_Phy_01  |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    And I want to check totalTax amount is not 0.0
    And Test Data for GDC-9965 and cart details

  @Prod_B2C_CA
  Scenario: [GDC-10276] Verify that user should be able to remove voucher using API
    Given I Hit Api to create B2CCA Token
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | B2C_CA_Phy_01  |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_100      |
      | status    |            200 |
    Then I verify B2C coupon is applied
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_100      |
      | status    |            200 |
    When I try to remove promocode
      | basestore | cengage-b2c-ca |
      | promoCode | B2CCA_100      |
      | status    |            204 |
    Then I verify B2C coupon is Removed
      | basestore | cengage-b2c-ca |
      | promoCode | B2CCA_100      |
      | status    |            200 |
    And Test Data for GDC-10276 and Cart details

  @Prod_B2C_CA
  Scenario: [GDC-10316] Verify that a PayPal url is generated and user can navigate to the UI using the PayPal url.
    Given I Hit Api to create B2CCA Token
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | B2C_CA_Phy_01  |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch paypal for B2C stores
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    And Test Data for GDC-10316 and Cart details

  #Scenario: [GDC-10289] Verify that user is able to delete cart
  #Given I Hit Api to create B2CCA Token
  #When I Hit the API to delete cart
  #| basestore | cengage-b2c-ca |
  #| status    |            200 |
  #When I hit get cart details API
  #| basestore | cengage-b2c-ca |
  #| status    |            400 |
  #Then I verify following details in API response
  #| errors[0].message | Cart not found. |
  #And Test Data for GDC-10289 and Cart details
  @Prod_B2C_CA
  Scenario: [GDC-9973]  Verify that user is able to place order for using 100% coupon code.
    Given I Hit Api to create B2CCA Token
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | B2C_CA_Phy_01  |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then I verify Delivery address is added to cart
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then I verify Billing address is added to cart
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify some delivery modes
      | codes  |              2 |
      | code_0 | standard-ca    |
      | code_1 | standard-ca-po |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                         |                 1 |
      | entries[0].product.isbn13Formatted | 978-0-17-676600-9 |
      | entries[0].product.type            | NARRATIVE         |
      | totalPriceWithTax.value            | not zero          |
      | subTotal.value                     | not zero          |
      | totalTax.value                     | not zero          |
      | deliveryAddress                    | not null          |
      | deliveryCost.value                 |                 0 |
      | deliveryMode.code                  | standard-ca       |
      | store                              | cengage-b2c-ca    |
      | totalDiscounts.value               |                 0 |
      | totalPrice.currencyIso             | CAD               |
      | billingAddress                     | not null          |
      | orderType                          | REGULAR           |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_100      |
      | status    |            200 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    When I hit get order details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                 |                 1 |
      | entries[0].product.code    | 9780176766009@@NA |
      | orderDiscounts.value       | not zero          |
      | paymentInfo.billingAddress | not null          |
      | paymentMode                | Coupon Applied    |
      | totalPriceWithTax.value    |                 0 |
      | subTotal.value             | not zero          |
      | totalTax.value             |                 0 |
      | deliveryAddress            | not null          |
      | deliveryCost.value         |                 0 |
      | deliveryMode.code          | standard-ca       |
      | store                      | cengage-b2c-ca    |
      | totalDiscounts.value       | not zero          |
      | totalPrice.currencyIso     | CAD               |
      | orderType                  | REGULAR           |
    And Test Data for GDC-9973 and order details
