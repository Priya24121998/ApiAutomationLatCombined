Feature: B2C NZ Carts Scenarios

  #################################################  Smoke   ################################################################
  @B2C_NZ_Carts_Smoke
  Scenario: [GDC-9947] Verify that user should able to merge the anonymous cart to authenticated user.
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I want to create anonymous cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_1 |
      | status    |             200 |
    And I hit api to add anonymous cart to B2CNZ user account
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780357374108@@NA |
    And Test Data for GDC-9947 and Cart details

  #################################################  Reggression   ###########################################################
  @B2C_NZ_Carts
  Scenario: [GDC-10196] Verify that user is able to create a cart with authenticated user.
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And Test Data for GDC-10196 and Cart details

  @B2C_NZ_Carts
  Scenario: [GDC-10210] Verify user is able to get cart deatils using API:
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
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
    And Test Data for GDC-10210 and Cart details

  @B2C_NZ_Carts
  Scenario: [GDC-10199] Verify user is able to add multiple product in cart using API
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cProduct_Mul |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems | 2 |
    And Test Data for GDC-10199 and Cart details

  @B2C_NZ_Carts
  Scenario: [GDC-10227] Verify that user should able to add a product to the anonymous cart
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I want to create anonymous cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_2 |
      | status    |             200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780170416771@@NA |
    And Test Data for GDC-10227 and Cart details

  @B2C_NZ_Carts
  Scenario: [GDC-10224] Verify that user is able to delete cart
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_2 |
      | status    |             200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10224 and Cart details

  @B2C_NZ_Carts
  Scenario: [GDC-10223] Verify user is not able to add the same product twice.
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | NZb2cDigital_3 |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | NZb2cDigital_3 |
      | status    |            200 |
    Then I verify user is not able to add same product twice
    And Test Data for GDC-10223 and Cart details
    
    
    @SAPECOMM-11904
  Scenario:  Verify that user is able to create cart, search product, add product to cart and delete cart
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And I hit PDP search
      | basestore | cengage-b2c-nz |
      | product   |  9780170416771 |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_2 |
      | status    |             200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10224 and Cart details
