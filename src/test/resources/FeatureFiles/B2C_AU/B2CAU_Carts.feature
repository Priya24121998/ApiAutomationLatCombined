Feature: B2C AU Carts Scenarios

  #################################################  Smoke   ################################################################
  @B2C_AU_Carts_Smoke
  Scenario: [GDC-9955] Verify that user should able to merge the anonymous cart to authenticated user.
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I want to create anonymous cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | QA_AUb2cDigital_4 |
      | status    |             200 |
    And I hit api to add anonymous cart to B2CAU user account
      | basestore | cengage-b2c-au |
      | status    |            201 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780170421294@@1800D |
    And Test Data for GDC-9955 and Cart details
    
@B2C_AU_Carts_Smoke
  Scenario: [GDC-10257] Verify that user is able to delete cart
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_2 |
      | status    |             200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10257 and Cart details

  #################################################  Reggression   ###########################################################
  @B2C_AU_Carts
  Scenario: [GDC-10249] Verify that user is able to create a cart with authenticated user.
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And Test Data for GDC-10249 and Cart details

  @B2C_AU_Carts
  Scenario: [GDC-10242] Verify user is able to get cart deatils using API:
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                         |                 1 |
      | entries[0].product                 | not null          |
      | entries[0].product.fullTitle       | not null          |
      | entries[0].product.edition         |               002 |
      | entries[0].product.copyrightYear   |              2009 |
      | entries[0].product.isbn13Formatted | 978-1-4180-2123-8 |
      | entries[0].product.clAuthorsNames  | Louise Simmers    |
      | entries[0].product.type            | NARRATIVE         |
      | entries[0].product.fullImage       | not null          |
      | totalPrice.value                   |          not zero |
      | subTotal.value                     |          not zero |
      | totalTax.value                     |                 0 |
      | deliveryCost.value                 |          not zero |
      | paymentType.code                   | CARD              |
      | orderType                          | REGULAR           |
    And Test Data for GDC-10242 and Cart details

  @B2C_AU_Carts
  Scenario: [GDC-10251] Verify user is able to add bulk product in cart using API
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_Mul |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems | 2 |
    And Test Data for GDC-10251 and Cart details

  @B2C_AU_Carts
  Scenario: [GDC-10235] Verify that user is able to get delivery modes using API:
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
		Then I verify some delivery modes
      | codes  |           1 |
      | code_0 | standard-au |
    And Test Data for GDC-10235 and Cart details

  @B2C_AU_Carts
  Scenario: [GDC-10234] Verify that user should able to add a product to the anonymous cart
    Given I Hit Api to create B2CAU Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_2 |
      | status    |             200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780170416771@@NA |
    And Test Data for GDC-10234 and Cart details

  @B2C_AU_Carts
  Scenario: [GDC-10241] Verify user is not able to add the same product twice.
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | QA_AUb2cDigital_4 |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | QA_AUb2cDigital_4 |
      | status    |            200 |
    Then I verify user is not able to add same product twice
    And Test Data for GDC-10241 and Cart details

    
     @SAPECOMM-11904
  Scenario:  Verify that user is able to create cart, search product, add product to cart and delete cart
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And I hit search
      | basestore | cengage-b2c-au |
      | query     | math           |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_2 |
      | status    |             200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10257 and Cart details

    
