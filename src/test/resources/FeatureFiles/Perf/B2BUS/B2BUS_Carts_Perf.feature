Feature: B2B US Carts Scenarios

  #################################################  Smoke   ################################################################
  @B2B_Carts_Smoke_Perf
  Scenario: [GDC-9924] Verify that user should get error if try to set cart with other than default ship to/bill to account number
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        41999932 |
      | billToAccountNumber |        4200945 |
      | status              |            400 |
    Then I verify user is gets an error on passing other ship to,bill to account number
    And Test Data for GDC-9924 and Cart details

  @B2B_Carts_Smoke_Perf
  Scenario: [GDC-9928] Verify that user is able to delete/update product from cart using API
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct2  |
      | status    |            200 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct3  |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-us    |
      | entries   |                 2 |
      | entries_0 | 9781598633382@@NA |
      | entries_1 | 9780357132869@@NA |
      | status    |               200 |
    Then I hit API to delete cart entry at position
      | basestore | cengage-b2b-us |
      | position  |              0 |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-us    |
      | entries   |                 1 |
      | entries_0 | 9780357132869@@NA |
      | status    |               200 |
    And Test Data for GDC-9928 and Cart details


  #################################################				QA				##############################################
  @B2B_Carts_Perf
  Scenario: [GDC-10185] Verify that user is able to create a cart with authenticated user
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And Test Data for GDC-10185 and Cart details

  @B2B_Carts_Perf
  Scenario: [GDC-10183] User should not be able to create cart with invalid base-store id
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us1 |
      | status    |             400 |
    And Test Data for GDC-10183 and Cart details

  @B2B_Carts_Perf
  Scenario: [GDC-10175] Verify user is able to get cart deatils using API:
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |       2 |
      | totalPriceWithTax.value |  not zero |
      | paymentType.code        | CARD    |
      | orderType               | REGULAR |
    And Test Data for GDC-10175 and Cart details

  @B2B_Carts_Perf
  Scenario: [GDC-10170] Verify that user should be able to get all the delivery mode using API:
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryModes[0].code | 1D|
      | deliveryModes[1].code | 2D|
      | deliveryModes[2].code | GD|
      | deliveryModes[3].code | MS|
    And Test Data for GDC-10170 and Cart details

    @B2B_Carts_Perf
    Scenario: [SAPECOMM-11904] Verify that user is able to create cart, search product, add product to cart and delete cart
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
      And User will call set bill to ship to Put Api in B2BUS store
        | basestore           | cengage-b2b-us |
        | status              |            202 |
    And I hit PDP search
      | basestore | cengage-b2b-us |
      | product   |  9781598633382 |
      | status    |            200 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct2   |
      | status    |            200 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct3  |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-us    |
      | entries   |                 2 |
      | entries_0 | 9781598633382@@NA |
      | entries_1 | 9780357132869@@NA |
      | status    |               200 |
    Then I hit API to delete cart entry at position
      | basestore | cengage-b2b-us |
      | position  |              0 |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-us    |
      | entries   |                 1 |
      | entries_0 | 9780357132869@@NA |
      | status    |               200 |
    And Test Data for GDC-9928 and Cart details