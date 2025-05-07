Feature: 3. Prod B2B GT

  @Prod_B2B_GT
  Scenario: [GDC-10404] Verify that user is able to search result with ISBN using API:
    Given I Hit Api to create B2BGT Token
    And I Want to search product with following details
      | basestore | cengage-b2b-gt |
      | query     |  9781432885410 |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9781432885410 |

  @Prod_B2B_GT
  Scenario: [GDC-10364] Verify that user is able to create a user:
    Given I Hit Api to create B2BGT Token
    And I hit b2b User creation API
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | gale           |
      | status    |            201 |
    Then I verify gale customer is registered

  @Prod_B2B_GT
  Scenario: [GDC-11238] Verify that the user can retrieve the saved cart.
    Given I Hit Api to create B2BGT Token
    And I hit API to create B2BGT User
    When I hit API to create B2BGT cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |         0100278524 |
      | billToAccountNumber |         0100278524 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | B2B_Gale_Mul     |
      | status    |              200 |
    When I Hit API to Saved cart
      | basestore    | cengage-b2b-gt |
      | saveCartName | Gale2Cart24    |
      | status       |            200 |
    Then I verify following details in API response
      | savedCartData.entries[0].product.code | 9780028658834@@NA |
    When I Hit API to get Saved cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | savedCartData.entries[0].product.code | 9780028658834@@NA |
    And Test Data for GDC-11238 and Cart details

  @Prod_B2B_GT
  Scenario: [GDC-10479] Verify that user is able to place an order using Thorndike ISBNs. [PO]
    Given I Hit Api to create B2BThorndike Token
    And I hit API to create B2BThorndike User
    When I hit API to create B2BThorndike cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |         0100278524 |
      | billToAccountNumber |         0100278524 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt    |
      | Product   | B2B_Thorndike_Mul |
      | status    |               200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD      |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | prod-gale-po   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero       |
      | totalItems              |              2 |
      | totalPriceWithTax.value | not zero       |
      | subTotal.value          | not zero       |
      | totalTax.value          | 0.0            |
      | deliveryAddress         | not null       |
      | deliveryMode.code       | GD      |
      | store                   | cengage-b2b-gt |
      | totalPrice.currencyIso  | USD            |
      | billingAddress          | not null       |
      | paymentType.code        | ACCOUNT        |
      | orderType               | REGULAR        |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |              2 |
      | totalPriceWithTax.value | not Zero       |
      | subTotal.value          | not zero       |
      | totalTax.value          | 0.0            |
      | deliveryAddress         | not null       |
      | deliveryMode.code       | GD      |
      | store                   | cengage-b2b-gt |
      | totalPrice.currencyIso  | USD            |
      | orderType               | REGULAR        |
    And Test Data for GDC-10479 and order details

  @Prod_B2B_GT
  Scenario: [GDC-10393] Verify that user is able to place an order for Gale+Thorndike using PO + Promo code.
    Given I Hit Api to create B2BGT Token
    When I hit API to create B2BGT cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |         0100278524 |
      | billToAccountNumber |         0100278524 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt |
      | Product   | B2B_Gale_Mul   |
      | status    |            200 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt       |
      | Product   | B2B_Thorndike_Mul    |
      | status    |                  200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD      |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I verify totalDiscounts amount is 0.0
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | prod-gale-po   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0.0
    Then I verify following details in API response
      | totalPrice.value        | not zero       |
      | totalItems              |              5 |
      | totalPriceWithTax.value | not zero       |
      | subTotal.value          | not zero       |
      | totalTax.value          | 0.0            |
      | deliveryAddress         | not null       |
      | deliveryMode.code       | GD      |
      | store                   | cengage-b2b-gt |
      | totalPrice.currencyIso  | USD            |
      | billingAddress          | not null       |
      | paymentType.code        | ACCOUNT        |
      | orderType               | REGULAR        |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |              5 |
      | totalPriceWithTax.value | not Zero       |
      | subTotal.value          | not zero       |
      | totalTax.value          | 0.0            |
      | totalDiscounts.value    | not Zero       |
      | deliveryAddress         | not null       |
      | deliveryMode.code       | GD      |
      | store                   | cengage-b2b-gt |
      | totalPrice.currencyIso  | USD            |
      | orderType               | REGULAR        |
    And Test Data for GDC-10393 and Order details

  @Prod_B2B_GT
  Scenario: [GDC-10467] Verify that user is able to apply multiple promo codes[Item Level/Free Shipping] on a cart & able to place order.
    Given I Hit Api to create B2BGT Token
    When I hit API to create B2BGT cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |         0100278524 |
      | billToAccountNumber |         0100278524 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt |
      | Product   | B2B_Gale_Mul   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD      |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I verify totalDiscounts amount is 0.0
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
      | status    |             200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | prod-po-test   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0.0
    Then I verify following details in API response
      | totalPrice.value        | not zero       |
      | totalItems              |              3 |
      | totalPriceWithTax.value | not zero       |
      | subTotal.value          | not zero       |
      | totalTax.value          | 0.0            |
      | deliveryAddress         | not null       |
      | deliveryMode.code       | GD      |
      | store                   | cengage-b2b-gt |
      | totalPrice.currencyIso  | USD            |
      | billingAddress          | not null       |
      | paymentType.code        | ACCOUNT        |
      | orderType               | REGULAR        |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10467 and Order details

