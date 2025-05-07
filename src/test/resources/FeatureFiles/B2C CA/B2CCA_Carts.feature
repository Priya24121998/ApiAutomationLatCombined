Feature: B2C CA Carts Scenarios

  #################################################  Smoke   ################################################################
  #################################################  Reggression   ###########################################################
  @B2C_CA_Carts
  Scenario: [GDC-10285] Verify that user should able to merge the anonymous cart to authenticated user.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I want to create anonymous cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    And I hit api to add anonymous cart to B2CCA user account
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780176766009@@NA |
    And Test Data for GDC-10285 and Cart details

  @B2C_CA_Carts
  Scenario: [GDC-10291] Verify that user is able to create a cart with authenticated user.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And Test Data for GDC-10291 and Cart details

  @B2C_CA_Carts 
  Scenario: [GDC-10294] Verify that user should not be able to create cart with invalid user[other store's user]
    Given I Hit Api to create B2CCA Token
    When I hit API to create invalid cart
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    And Test Data for GDC-10294 and Cart details

  @B2C_CA_Carts
  Scenario: [GDC-10266] Verify user is able to get cart deatils using API:
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                         |                 1 |
      | entries[0].product                 | not null          |
      | entries[0].product.fullTitle       | not null          |
      | entries[0].product.edition         |               007 |
      | entries[0].product.copyrightYear   |              2020 |
      | entries[0].product.isbn13Formatted | 978-0-17-676600-9 |
      | entries[0].product.type            | NARRATIVE         |
      | entries[0].product.fullImage       | not null          |
      | totalPriceWithTax.value            |           not zero|
      | subTotal.value                     |           not zero|
      | totalTax.value                     |          not zero |
      | deliveryCost.value                 |                 0 |
      | paymentType.code                   | CARD              |
      | orderType                          | REGULAR           |
    And Test Data for GDC-10266 and Cart details

  @B2C_CA_Carts
  Scenario: [GDC-10272] Verify that user should able to add a product to the anonymous cart
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I want to create anonymous cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780176766009@@NA |
    And Test Data for GDC-10272 and Cart details

  @B2C_CA_Carts
  Scenario: [GDC-10289] Verify that user is able to delete cart
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10289 and Cart details

  @B2C_CA_Carts
  Scenario: [GDC-10284] Verify that user is not able to add the same product again.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    Then I verify user is not able to add same product twice
    And Test Data for GDC-10284 and Cart details

  @B2C_CA_Carts
  Scenario: [GDC-10268]  Verify that API throws error if user is trying to merge the anonymous cart to MergeCartGuid with invalid basestore/anonymous cartID.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I want to create anonymous cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | emeaProduct_1  |
      | status    |            200 |
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And I merge invalid anonymous cart B2CCA user account
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    Then I verify error with given message
      | Message | Cart is not anonymous |
    And Test Data for GDC-10268 and Cart details

  @B2C_CA_Carts
  Scenario: [GDC-10279]  Verify that user is not able to add the product more than 1 [quantity: 2 in payload]
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_8   |
      | status    |            200 |
    Then I verify error with given message
    | Message |This field must not be greater than 1 |
    And Test Data for GDC-10279 and Cart details


     @B2C_CA_Carts
  Scenario: [GDC-10269] Verify that user is able to get delivery modes using API:
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
   Then I verify some delivery modes
      | codes  |              2 |
      | code_0 | standard-ca    |
      | code_1 | standard-ca-po |
    And Test Data for GDC-10269 and Cart details
    
    @SAPECOMM-11904
  Scenario:  Verify that user is able to create cart, search product, add product to cart and delete cart
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And I hit PDP search
      | basestore | cengage-b2c-ca |
      | product   |  9780176766009 |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When I Hit the API to delete cart
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | Cart not found. |
    And Test Data for GDC-10289 and Cart details
