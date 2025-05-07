Feature: 2. Prod B2B US

  @Prod_B2B_US
  Scenario: [GDC-9922] Verify that user is able to search using ISBN using API: https
    Given I Hit Api to create B2BUS Token
    And I hit search
      | basestore | cengage-b2b-us |
      | query     |  9780357378977 |
      | status    |            200 |
    Then I verify results in response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9780357378977 |

  @Prod_B2B_US
  Scenario: [GDC-9930]  Verify tax is calculated after adding the product in cart
    Given I Hit Api to create B2BUS Token
    And I hit API to create B2BUS User
    When I hit API to create B2BUS cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us    |
      | shipToAccountNumber |        0100209192 |
      | billToAccountNumber |        0100209192 |
      | status              |            202    |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | B2B_US_Mul_01  |
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    Then I verify DropShip address is added to cart
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I want to check totalTax amount is not 0.0
    And Test Data for GDC-9930 and Cart details

  @Prod_B2B_US
  Scenario: [GDC-9928] Verify that user is able to delete/update product from cart using API
    Given I Hit Api to create B2BUS Token
    When I hit API to get products in cart
      | basestore | cengage-b2b-us    |
      | entries   |                 2 |
      | entries_0 | 9781337905947@@NA |
      | entries_1 | 9781337911283@@NA |
      | status    |               200 |
    Then I hit API to delete cart entry at position
      | basestore | cengage-b2b-us |
      | position  |              0 |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-us    |
      | entries   |                 1 |
      | entries_0 | 9781337911283@@NA |
      | status    |               200 |
    And Test Data for GDC-9928 and Cart details

  @Prod_B2B_US
  Scenario: [GDC-9926] Verify that user is able set delivery mode again once deleted using API
    Given I Hit Api to create B2BUS Token
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryModes[0].code | 1D       |
      | deliveryModes[1].code | 2D       |
      | deliveryModes[2].code | GD       |
      | deliveryModes[3].code | MS       |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD |
      | status    |                          200 |
    When I hit API to get delivery mode in cart
      | basestore    | cengage-b2b-us               |
      | deliveryMode | GD |
      | status       |                          200 |
    Then I hit API to delete delivery modes
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us                                  |
      | code      | MS                                              |
      | status    |                                            200  |
    When I hit API to get delivery mode in cart
      | basestore    | cengage-b2b-us                                 |
      | deliveryMode | MS                                             |
      | status       |                                            200 |
    And Test Data for GDC-9926 and Cart details

  @Prod_B2B_US
  Scenario: [GDC-10363] Verify that user is able to place order using PO number
    Given I Hit Api to create B2BUS Token
    When I hit API to create B2BUS cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        0100209192 |
      | billToAccountNumber |        0100209192 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | B2B_US_Phy_02  |
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    Then I verify DropShip address is added to cart
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO-test-prod   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value                   | not zero                     |
      | totalItems                         |                            1 |
      | entries[0].product.isbn13Formatted | 978-1-337-91128-3            |
      | entries[0].product.type            | NARRATIVE                    |
      | totalPriceWithTax.value            | not zero                     |
      | subTotal.value                     | not zero                     |
      | totalTax.value                     | not zero                     |
      | deliveryAddress                    | not null                     |
      | deliveryMode.code                  | GD |
      | store                              | cengage-b2b-us               |
      | totalPrice.currencyIso             | USD                          |
      | billingAddress                     | not null                     |
      | paymentType.code                   | ACCOUNT                      |
      | orderType                          | REGULAR                      |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                            1 |
      | entries[0].product.code | 9781337911283@@NA            |
      | totalPriceWithTax.value | not Zero                     |
      | subTotal.value          | not zero                     |
      | totalTax.value          | not Zero                     |
      | deliveryAddress         | not null                     |
      | deliveryMode.code       | GD |
      | store                   | cengage-b2b-us               |
      | totalPrice.currencyIso  | USD                          |
      | orderType               | REGULAR                      |
    And Test Data for GDC-10363 and Order details
