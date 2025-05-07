Feature: B2B CA Carts Scenarios

  #################################################  Smoke   ################################################################
  @B2BCA_Carts_Smoke @Perf_B2BCA_Carts_Smoke
  Scenario: [GDC-929] Verify OCC API: /{baseSiteId}/orgCustomers throws error with invalid BillTo and ShipTo Account Number
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        4199993 |
      | billToAccountNumber |        4200945 |
      | status              |            400 |
    Then I verify user is gets an error on passing other ship to,bill to account number
    And Test Data for GDC-929 and Cart details

  @B2BCA_Carts_Smoke
  Scenario: [GDC-9786] Verify that user is able to delete cart
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       37722155 |
      | billToAccountNumber |       37722155 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-ca    |
      | entries   |                 1 |
      | entries_0 | 9781598633382@@NA |
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

  @B2BCA_Carts_Smoke
  Scenario: [GDC-9785] Verify that user should be able to check-out Multiple quantity Multiple product
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       37722155 |
      | billToAccountNumber |       37722155 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca   |
      | Product   | b2bMulQuantity_2 |
      | status    |              200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 2 |
      | deliveryItemsQuantity   |                30 |
      | entries[0].product.code | 9781598633382@@NA |
      | entries[1].product.code | 9780357363744@@NA |
    And Test Data for GDC-9785 and Cart details

  @Perf_B2BCA_Carts_Smoke
  Scenario: [GDC-9786] Verify that user is able to delete cart
    Given I Hit Api to create B2BCAPerf Token
    When I hit API to create B2BCAPerf cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84018552 |
      | billToAccountNumber |       84018552 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-ca    |
      | entries   |                 1 |
      | entries_0 | 9781598633382@@NA |
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

  @Perf_B2BCA_Carts_Smoke
  Scenario: [GDC-9785] Verify that user should be able to check-out Multiple quantity Multiple product
    Given I Hit Api to create B2BCAPerf Token
    When I hit API to create B2BCAPerf cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84018552 |
      | billToAccountNumber |       84018552 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca   |
      | Product   | b2bMulQuantity_2 |
      | status    |              200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 2 |
      | deliveryItemsQuantity   |                30 |
      | entries[0].product.code | 9781598633382@@NA |
      | entries[1].product.code | 9780357363744@@NA |
    And Test Data for GDC-9785 and Cart details

  #################################################  Reggression   ###########################################################
  @B2BCA_Carts
  Scenario: [GDC-1113] OCC API PUT: drop-ship throws error with invalid cartId
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       37722155 |
      | billToAccountNumber |       37722155 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
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

  @B2BCA_Carts_INT
  Scenario: [GDC-1113] OCC API PUT: drop-ship throws error with invalid cartId
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84000381 |
      | billToAccountNumber |       84000381 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
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
    
  @B2BCA_Carts
  Scenario: [GDC-994] B2B: Verify that error message should returned when try to add invalid product to the cart
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2BCA products to cart with invalid product code
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct8  |
      | status    |            200 |
    Then I verify error with given message
      | Message | No product with code [9781337905947@@NA] found. |
    And Test Data for GDC-994 and Cart details

    
  @B2BCA_Carts
  Scenario: [GDC-1114] Verify that user can update drop-ship by overriding the current drop-ship
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       37722155 |
      | billToAccountNumber |       37722155 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
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

  @B2BCA_Carts
  Scenario: [GDC-1110] Set Cart Accounts OCC API throws error with invalid cartId
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84002336 |
      | billToAccountNumber |       84002335 |
      | cartID              | invalid        |
      | status              |            400 |
    Then I verify error with given message
      | Message | Cart not found. |
    And Test Data for GDC-1110 and Cart details


  #------------------------------------------------- Removed ------------------------------------------------------#
  #Removed
  Scenario: [GDC-1000] Verify OCC merge cart API:  throws error with invalid toMergeCartGuid
    Given I Hit Api to create B2BCA Token
    When I want to create anonymous cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And I merge anonymous cart with invalid user cart
      | basestore | cengage-b2b-ca |
      | status    |            400 |
    Then I verify error with given message
      | Message | Cart is not current user's cart |
    And Test Data for GDC-1000 and Cart details

  #Removed
  Scenario: [GDC-313] Verify that If toMergeCartGuid is filled, then the anonymous cart is merged with the cart specified in that field.
    Given I Hit Api to create B2BCA Token
    When I want to create anonymous cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84002336 |
      | billToAccountNumber |       84002335 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct4  |
      | status    |            200 |
    And I merge anonymous cart with specified user cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 2 |
      | entries[0].product.code | 9780357020845@@NA |
      | entries[1].product.code | 9781598633382@@NA |
    And Test Data for GDC-313 and Cart details

  #Removed
  Scenario: [GDC-312] Verify that If oldCartId is filled with the anonymous cart guid, then this cart becomes the current active cart for the authenticated user.
    Given I Hit Api to create B2BCA Token
    When I want to create anonymous cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9781598633382@@NA |
    And I hit api to add anonymous cart to B2BCA user account
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9781598633382@@NA |
    And Test Data for GDC-312 and Cart details
    #------------------------------------------Removed code------------------------------------------
      #@B2BCA_Carts
  #Scenario: [GDC-994] B2B: Verify that error message should returned when try to add invalid product to the cart
    #Given I Hit Api to create B2BCA Token
    #When I hit API to create B2B cart
      #| basestore | cengage-b2b-ca |
      #| status    |            201 |
    #And User add B2B products to cart
      #| basestore | cengage-b2b-ca |
      #| Product   | b2busproduct8  |
      #| status    |            200 |
    #Then I verify error with given message
      #| Message | No product with code [9781337905947@@NA] found. |
    #And Test Data for GDC-994 and Cart details
    
    
    @SAPECOMM-11904
    Scenario: [SAPECOMM-11904] Verify that user is able to create cart, search product, add product to cart and delete cart
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And I hit search
      | basestore | cengage-b2b-ca |
      | query     |  9781598633382 |
      | status    |            200 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to get products in cart
      | basestore | cengage-b2b-ca    |
      | entries   |                 1 |
      | entries_0 | 9781598633382@@NA |
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