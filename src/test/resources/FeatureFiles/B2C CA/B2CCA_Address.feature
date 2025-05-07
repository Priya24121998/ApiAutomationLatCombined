Feature: B2C CA Address API Scenarios

  @B2C_CA_Address
  Scenario: I create a Cart to get Adddress Id
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
    When I get delivery address id and save it
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    When I get billing address id and save it

  @B2C_CA_Address
  Scenario: [GDC-10267] Verify that user is able to update the address
    Given I Hit Api to create B2CCA Token
    And I want to update delivery address details
      | basestore | cengage-b2c-ca    |
      | Address   | CA_updatedaddress |
      | status    |               200 |
    And I want to read delivery address details
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When I verify delivery AddressId in Response
    Then I verify following details in API response
      | country.isocode | CA              |
      | firstName       | Updated         |
      | lastName        | Details         |
      | line1           | 3171 Reserve St |
      | postalCode      | V8X 3X4        |
      | town            | Arden           |

  @B2C_CA_Address
  Scenario: [GDC-10263] Verify that delivery address can be deleted using API
    Given I Hit Api to create B2CCA Token
    And Try to delete delivery address details
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    And I want to read delivery address details
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    Then User get delivery address does not exist error

  @B2C_CA_Address
  Scenario: [GDC-10277] Verify that API return Country assoicted with billing address usingAPI
    Given I Hit Api to create B2CCA Token
    And I hit API to get a list countries
      | basestore | cengage-b2c-ca |
      | type      | BILLING        |
      | status    |            200 |
    Then I verify following details in API response
      | countries[36].isocode | CA     |
      | countries[36].name    | Canada |
      
  @B2C_CA_Address
  Scenario: [GDC-12665] Verify that API: [/{baseSiteId}/countries] return 'Country' assoicted with shipping address 
    Given I Hit Api to create B2CCA Token
    And I hit API to get a list countries
      | basestore | cengage-b2c-ca |
      | type      | SHIPPING        |
      | status    |            200 |
    Then I verify following details in API response
      | countries[0].isocode | CA     |
      | countries[0].name    | Canada |
