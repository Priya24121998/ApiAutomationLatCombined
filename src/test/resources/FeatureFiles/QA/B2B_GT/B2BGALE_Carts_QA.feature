Feature: B2B GT Carts Scenarios

  #################################################  Smoke   ################################################################
  @B2BGT_Carts_Smoke_QA
  Scenario: [GDC-9924] Verify that user should get error if try to set cart with other than default ship to/bill to account number
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |        4109932 |
      | billToAccountNumber |        4200945 |
      | status              |            400 |
    Then I verify user is gets an error on passing other ship to,bill to account number
    And Test Data for GDC-9924 and Cart details

  #################################################	 Reggression				##############################################
  @B2BGT_Carts_QA
  Scenario: [GDC-10365] Verify that user is able to create a cart with authenticated user
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And Test Data for GDC-10365 and Cart details

  @B2BGT_Carts_QA
  Scenario: [GDC-10382] Verify user is able to get cart details using API:
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   | b2bGaleMulProduct_2 |
      | status    |                 200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD      |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |         3 |
      | deliveryMode.code       | GD        |
      | deliveryCost.value      | not zero  |
      | totalTax.value          | not zero  |
      | totalPriceWithTax.value | not zero  |
      | paymentType.code        | CARD      |
      | orderType               | REGULAR   |
    And Test Data for GDC-10382 and Cart details

  @B2BGT_Carts_QA
  Scenario: [GDC-10380] Verify that user should be able to get all the delivery mode using API:
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_1 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryModes[0].code | 1D|
      | deliveryModes[1].code | 2D|
      | deliveryModes[2].code | GD|
      | deliveryModes[3].code | MS|
    And Test Data for GDC-10380 and Cart details

  @B2BGT_Carts_QA
  Scenario: [GDC-10408] Verify that user is able to delete cart
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_1 |
      | status    |              200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10408 and Cart details

  @B2BGT_Carts_QA
  Scenario: [GDC-11237] Verify that the user can retrieve the saved cart.
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bgtproductDel  |
      | status    |              200 |
    When I Hit API to Saved cart
      | basestore    | cengage-b2b-gt |
      | saveCartName | Gale2Cart24    |
      | status       |            200 |
    Then I verify following details in API response
      | savedCartData.entries[0].product.code | 9781538381373@@NA |
    And Test Data for GDC-11237 and Cart details

  @B2BGT_Carts_QA
  Scenario: [GDC-11238] Verify that the user can retrieve the saved cart.
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bgtproductDel |
      | status    |              200 |
    When I Hit API to Saved cart
      | basestore    | cengage-b2b-gt |
      | saveCartName | Gale2Cart24    |
      | status       |            200 |
    Then I verify following details in API response
      | savedCartData.entries[0].product.code | 9781538381373@@NA |
    When I Hit API to get Saved cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | savedCartData.entries[0].product.code | 9781538381373@@NA |
    And Test Data for GDC-11238 and Cart details

  #Need Refinement
  @B2BGT_Carts_QA
  Scenario: [GDC-11239] verify that the B2B Gale stores have an expiration time for the saved card that is 2 years from the Save time.
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I Hit API to Saved cart
      | basestore    | cengage-b2b-gt |
      | saveCartName | Gale2Cart24    |
      | status       |            200 |
    Then I verify following details in API response
      | savedCartData.entries[0].product.code |9780028655314@@NA |
    When I Hit API to get Saved cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | savedCartData.entries[0].product.code | 9780028655314@@NA |
    Then Verify expirationTime is 2 years from saveTime in resonse
    And Test Data for GDC-11239 and Cart details

  @B2BGT_Carts_QA
  Scenario: [SAPECOMM-11904] Verify that user is able to create cart, search product, add product to cart and delete cart
    Given I Hit Api to create B2BGTCartOne Token
    When I hit API to create B2BGTCartOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |         0100177038 |
      | billToAccountNumber |         0100177038 |
      | status              |            202 |
    And I hit search
      | basestore | cengage-b2b-gt |
      | query     | 9780028655314  |
      | status    |            200 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10408 and Cart details
