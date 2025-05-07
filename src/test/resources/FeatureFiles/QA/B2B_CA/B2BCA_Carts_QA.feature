Feature: B2B CA Carts Scenarios

  #################################################  Smoke   ################################################################
  @B2BCA_Carts_Smoke_QA
  Scenario: [GDC-929] Verify OCC API: /{baseSiteId}/orgCustomers throws error with invalid BillTo and ShipTo Account Number
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        4199993 |
      | billToAccountNumber |        4200945 |
      | status              |            400 |
    Then I verify user is gets an error on passing other ship to,bill to account number
    And Test Data for GDC-929 and Cart details

  @B2BCA_Carts_Smoke_QA
  Scenario: [GDC-9786] Verify that user is able to delete cart
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BCA store
      | basestore           | cengage-b2b-ca |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2bProduct_2_ErpPhase   |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-ca    |
      | entries   |                 1 |
      | entries_0 | 9780176912260@@NA |
      | status    |               200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-9786 and Cart details

  @B2BCA_Carts_Smoke_QA
  Scenario: [GDC-9785] Verify that user should be able to check-out Multiple quantity Multiple product
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BCA store
      | basestore           | cengage-b2b-ca |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca   |
      | Product   | b2bProduct_2     |
      | status    |              200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                1  |
      | deliveryItemsQuantity   |                3  |
      | entries[0].product.code | 9780176911140@@NA |
    And Test Data for GDC-9785 and Cart details


  #################################################  Reggression   ###########################################################
  @B2BCA_Carts_QA
  Scenario: [GDC-1113] OCC API PUT: drop-ship throws error with invalid cartId
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BCA store
      | basestore           | cengage-b2b-ca |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2bProduct_2_ErpPhase   |
      | status    |            200 |
    And I hit API to Set drop ship address
      | basestore | cengage-b2b-ca |
      | cartID    | invalid        |
      | address   | CA_address2    |
      | status    |            400 |
    Then I verify error with given message
      | basestore | cengage-b2b-ca  |
      | Message   | Cart not found. |
    And Test Data for GDC-1113 and Cart details

  @B2BCA_Carts_QA
  Scenario: [GDC-994] B2B: Verify that error message should returned when try to add invalid product to the cart
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2BCA products to cart with invalid product code
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct8  |
      | status    |            200 |
    Then I verify error with given message
      | Message | No product with code [9781337905947@@NA] found. |
    And Test Data for GDC-994 and Cart details


  @B2BCA_Carts_QA
  Scenario: [GDC-1114] Verify that user can update drop-ship by overriding the current drop-ship
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BCA store
      | basestore           | cengage-b2b-ca |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca          |
      | Product   | b2bProduct_2_ErpPhase   |
      | status    |            200          |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-ca |
      | address   | CA_address     |
      | status    |            201 |
    When I hit API to get Address details
      | basestore | cengage-b2b-ca  |
      | town      | Arden           |
      | line1     | 3171 Reserve St |
      | status    |             200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-ca |
      | address   | CA_address2    |
      | status    |            201 |
    When I hit API to get Address details
      | basestore | cengage-b2b-ca    |
      | town      | La Prairie        |
      | line1     | 2903 rue St-Henri |
      | status    |               200 |
    And Test Data for GDC-1114 and Cart details

  @B2BCA_Carts_QA
  Scenario: [GDC-1110] Set Cart Accounts OCC API throws error with invalid cartId
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca  |
      | shipToAccountNumber |       0100159015 |
      | billToAccountNumber |       0100159015 |
      | cartID              | invalid         |
      | status              |            400  |
    Then I verify error with given message
      | Message | Cart not found. |
    And Test Data for GDC-1110 and Cart details

