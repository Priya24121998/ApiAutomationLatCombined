Feature: 2. Prod B2C US

  @Prod_B2C_US_2
  Scenario: [GDC-10369] Verify that user is able to search product details [PDP] using API.
    Given I Hit Api to create B2CUS Token
    And I hit PDP search
      | basestore | cengage-b2c-us    |
      | product   | 9781337696456@@NA |
      | status    |               200 |
    Then I verify results in response
      | isbn13            | 9781337696456 |
      | price.currencyIso | USD           |

  @Prod_B2C_US_2
  Scenario: [GDC-10109] Verify CU 12 rental purchase using coupon code  [using Standard-us mode]
    Given Create user Prod_CU12Rental and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    Then User Apply Coupon B2CUS_100
    Then User place order and verify status code
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds B2C_US_Phy_01 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    Then User fetches cart details
    Then I verify following details in API response
      | totalItems              |              1 |
      | entries[0].product.type | NARRATIVE      |
      | totalPriceWithTax.value | not zero       |
      | subTotal.value          |            0.0 |
      | totalTax.value          | not zero       |
      | deliveryAddress         | not null       |
      | deliveryCost.value      | not zero       |
      | deliveryMode.code       | standard-us    |
      | store                   | cengage-b2c-us |
      | totalDiscounts.value    |              0 |
      | totalPrice.currencyIso  | USD            |
      | billingAddress          | not null       |
      | orderType               | REGULAR        |
    Then User Apply Coupon B2CUS_100
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    Then User get order details
    Then I verify following details in API response
      | totalItems                 |                 1 |
      | entries[0].product.code    | 9781133365419@@CU |
      | orderDiscounts.value       |               0.0 |
      | paymentInfo.billingAddress | not null          |
      | paymentMode                | Coupon Applied    |
      | totalPriceWithTax.value    |                 0 |
      | subTotal.value             |               0.0 |
      | totalTax.value             |                 0 |
      | deliveryAddress            | not null          |
      | deliveryCost.value         |                 0 |
      | deliveryMode.code          | standard-us       |
      | store                      | cengage-b2c-us    |
      | totalDiscounts.value       | 0.0               |
      | totalPrice.currencyIso     | USD               |
      | orderType                  | REGULAR           |
    And I log Test Data for discountedRentals
    When I click on sidebar sign out button

  @Prod_B2C_US_2
  Scenario: [GDC-10000] [API]Verify Standalone rental purchase using coupon code [Using Expedited-us mode]
    Given Create user Prod_CoupRental and login to application
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds B2C_US_Phy_02 product to cart
    And User adds Taxable_Address to delivery address
    Then I verify Delivery address is added to cart
    And Add Taxable_Address to billing address
    Then I verify Billing address is added to cart
    Then I get delivery modes
    Then I verify some delivery modes
      | codes  |            2 |
      | code_0 | standard-us  |
      | code_1 | expedited-us |
    Then I put expedited-us as shipping mode
    Then User fetches cart details
    Then I verify following details in API response
      | totalItems              |              1 |
      | entries[0].product.type | NARRATIVE      |
      | totalPriceWithTax.value | not zero       |
      | subTotal.value          | not zero       |
      | totalTax.value          | not zero       |
      | deliveryAddress         | not null       |
      | deliveryCost.value      | not zero       |
      | deliveryMode.code       | expedited-us   |
      | store                   | cengage-b2c-us |
      | totalDiscounts.value    |              0 |
      | totalPrice.currencyIso  | USD            |
      | billingAddress          | not null       |
      | orderType               | REGULAR        |
    Then User Apply Coupon B2CUS_100
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    Then User get order details
    Then I verify following details in API response
      | totalItems                 |                   1 |
      | entries[0].product.code    | 9780155063174@@180I |
      | orderDiscounts.value       | not zero            |
      | paymentInfo.billingAddress | not null            |
      | paymentMode                | Coupon Applied      |
      | totalPriceWithTax.value    |                   0 |
      | subTotal.value             |           not zero  |
      | totalTax.value             |                   0 |
      | deliveryAddress            | not null            |
      | deliveryCost.value         |                   0 |
      | deliveryMode.code          | expedited-us        |
      | store                      | cengage-b2c-us      |
      | totalDiscounts.value       | not zero            |
      | totalPrice.currencyIso     | USD                 |
      | orderType                  | REGULAR             |
    And I log Test Data for rentals
    When I click on sidebar sign out button
