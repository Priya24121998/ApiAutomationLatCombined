Feature: B2C EMEA Carts Scenarios

  @B2C_EMEA_Cart
  Scenario: [GDC-311] Verify that The API /{baseSiteId}/users/{userId}/carts should be used to create a cart for authenticated and anonymous users
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And Test Data for GDC-311 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-312] Verify that If oldCartId is filled with the anonymous cart guid, then this cart becomes the current active cart for the authenticated user.
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9781111129002@@NA |
    And I hit api to add anonymous cart to B2CEMEA user account
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9781111129002@@NA |
    And Test Data for GDC-312 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-313] Verify that If toMergeCartGuid is filled, then the anonymous cart is merged with the cart specified in that field.
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    And I merge anonymous cart with specified user cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | totalItems              |                 2 |
      | entries[0].product.code | 9781285743141@@NA |
      | entries[1].product.code | 9781111129002@@NA |
    And Test Data for GDC-313 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-442] B2C: Verify that user is able to add multiple products to the particular cart according to their price type.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | totalItems              |                 2 |
      | entries[0].product.code | 9781285743141@@NA |
      | entries[1].product.code | 9781111129002@@NA |
    And Test Data for GDC-442 and Cart details

  @B2C_EMEA_Cart @examp
  Scenario: [GDC-986] B2C: Verify that error message should returned when try to add invalid product to the cart
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | invalidProduct   |
      | status    |              200 |
    Then I verify error with given message
      | Message | No result for the given query |
    And Test Data for GDC-450 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-999] Verify OCC merge cart API throws error with invalid oldCartId
    Given I Hit Api to create B2CEMEA Token
    And I merge invalid anonymous cart B2CEMEA user account
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then I verify error with given message
      | Message | Cart is not anonymous |
    And Test Data for GDC-999 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-1000] Verify OCC merge cart API:  throws error with invalid toMergeCartGuid
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And I merge anonymous cart with invalid user cart
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then I verify error with given message
      | Message | Cart is not current user's cart |
    And Test Data for GDC-1000 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-1157] Verify user is not able to add the same product twice.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    Then I verify user is not able to add same product twice
    And Test Data for GDC-1157 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-9811] Verify that user is able to delete cart
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-9811 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-9835] Verify that user should not be able to create cart with invalid base-store id
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-invalid |
      | status    |                 400 |
    And Test Data for GDC-9835 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-985] B2C: Verify that user not able to proceed further without adding billing and shipping address to the cart.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    And I launch paypal for B2C stores
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then I verify invalid payment info for cart error
    And Test Data for GDC-985 and Cart details

  @B2C_EMEA_Cart
  Scenario: [GDC-9839] User should not be able to place order without providing billing/delivery address
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    Then I verify error on payment page
    And Test Data for GDC-9839 and Cart details

  @SAPECOMM-11904
  Scenario: Verify that user is able to create cart, search product, add product to cart and delete cart
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And I hit search
      | basestore | cengage-b2c-emea |
      | query     |    9781111129002 |
      | status    |              200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-9811 and Cart details
