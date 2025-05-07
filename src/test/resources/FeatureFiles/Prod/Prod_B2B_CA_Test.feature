Feature: 1. Prod B2B CA

  # confirmed with balla no shipping chages for b2b ca
  # no discount for b2b ca

  @Prod_B2B_CA
  Scenario: [GDC-10260] Verify that user is able to sort the searched result as per fullTitle keywords using API:
    Given I Hit Api to create B2BCA Token
    And I Want to search product with following details
      | basestore | cengage-b2b-ca |
      | query     | Maths          |
      | sort      | fullTitle-desc |
      | status    |            200 |
    Then I check if result is sorted using fullTitle

  @Prod_B2B_CA
  Scenario: [GDC-367] Verify that total tax should be calculated for multiple items
    Given I Hit Api to create B2BCA Token
    And I hit API to create B2BCA User
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca   |
      | shipToAccountNumber |       0100204223 |
      | billToAccountNumber |       0100204223 |
      | status              |            202   |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca     |
      | Product   | B2B_CA_MulQuantity |
      | status    |                200 |
   	 When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I want to check totalTax amount is not 0.0
    And Test Data for GDC-367 and Cart details
      
  @Prod_B2B_CA 
  Scenario: [GDC-10357] Verify user is able to place bulk products order using PO  
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryModes[0].code | 1D       |
      | deliveryModes[1].code | 2D       |
      | deliveryModes[2].code | GD       |
      | deliveryModes[3].code | MS       |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO-test-prod   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero       |
      | totalItems              |              2 |
      | entries[0].product.type | NARRATIVE      |
      | totalPriceWithTax.value | not zero       |
      | subTotal.value          | not zero       |
      | totalTax.value          | not zero       |
      | deliveryAddress         | not null       |
      | deliveryCost.value      |          22.34 |
      | deliveryMode.code       | GD          |
      | store                   | cengage-b2b-ca |
      | totalDiscounts.value    |            0.0 |
      | totalPrice.currencyIso  | CAD            |
      | billingAddress          | not null       |
      | paymentType.code        | ACCOUNT        |
      | orderType               | REGULAR        |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 2 |
      | entries[0].product.code | 9781598633382@@NA |
      | entries[1].product.code | 9780357363744@@NA |
      | orderDiscounts.value    |               0.0 |
      | totalPriceWithTax.value | not zero          |
      | subTotal.value          | not zero          |
      | totalTax.value          | not Zero          |
      | deliveryAddress         | not null          |
      | deliveryCost.value      |              22.34|
      | deliveryMode.code       | GD                |
      | store                   | cengage-b2b-ca    |
      | totalDiscounts.value    |               0.0 |
      | totalPrice.currencyIso  | CAD               |
      | orderType               | REGULAR           |
    And Test Data for GDC-10357 and Order details
