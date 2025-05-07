Feature: B2C EMEA Address API Scenarios

  @B2C_EMEA_Address
  Scenario: I create a Cart to get Adddress Id
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I get delivery address id and save it
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I get billing address id and save it

  @B2C_EMEA_Address
  Scenario: [GDC-672] Addresses OCC API: Verify that API successfully reads specific shipping address from a customer's account
    Given I Hit Api to create B2CEMEA Token
    And I want to read delivery address details
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When I verify delivery AddressId in Response
    Then I verify following details in API response
      | country.isocode | GB                |
      | firstName       | Test              |
      | lastName        | User              |
      | line1           | 9428 Windsor Road |
      | postalCode      | 42378             |
      | town            | London            |

  @B2C_EMEA_Address
  Scenario: [GDC-673] Addresses OCC API: Verify that API successfully updates shipping address from a customer's account
    Given I Hit Api to create B2CEMEA Token
    And I want to update delivery address details
      | basestore | cengage-b2c-emea     |
      | Address   | Updated_Address_Emea |
      | status    |                  200 |
    And I want to read delivery address details
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When I verify delivery AddressId in Response
    Then I verify following details in API response
      | country.isocode | GB                        |
      | firstName       | Update Test               |
      | lastName        | Updated User              |
      | line1           | Updated 9428 Windsor Road |
      | postalCode      | 42378                     |
      | town            | London                    |

  @B2C_EMEA_Address
  Scenario: [GDC-674] Addresses OCC API: Verify that API successfully deletes shipping address from a customers account
    Given I Hit Api to create B2CEMEA Token
    And Try to delete delivery address details
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    And I want to read delivery address details
      | basestore | cengage-b2c-emea |
      | status    |              400 |
    Then User get delivery address does not exist error
    
  @B2C_EMEA_Address
  Scenario: [GDC-450] Verify that Shipping charges are calculated after shipping method is set via Cart OCC API.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | totalItems                      |                              1 |
      | entries[0].product.code         | 9781285743141@@NA              |
      | deliveryMode.code               | EMEA_Express_Shipping_Domestic |
      | deliveryMode.deliveryCost.value |                           3.99 |
    And Test Data for GDC-450 and Cart details

    
   