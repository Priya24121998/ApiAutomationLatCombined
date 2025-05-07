Feature: B2C NZ Address API Scenarios

  @B2C_NZ_Address
  Scenario: I create a Cart to get Adddress Id
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_1 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    When I get delivery address id and save it
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    When I get billing address id and save it

  @B2C_NZ_Address
  Scenario: [GDC-10226] Verify that user is able to update the address
    Given I Hit Api to create B2CNZ Token
    And I want to update delivery address details
      | basestore | cengage-b2c-nz    |
      | Address   | NZ_updatedaddress |
      | status    |               200 |
    And I want to read delivery address details
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    When I verify delivery AddressId in Response
    Then I verify following details in API response
      | country.isocode | NZ                  |
      | firstName       | Updated             |
      | lastName        | Details             |
      | line1           | 220 French Block    |
      | postalCode      |                0592 |
      | town            | Riverstone Terraces |

  @B2C_NZ_Address
  Scenario: [GDC-10195] Verify that API return Country assoicted with shipping address
    Given I Hit Api to create B2CNZ Token
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And I hit API to get a list countries
      | basestore | cengage-b2c-nz |
      | type      | SHIPPING       |
      | status    |            200 |
    Then I verify following details in API response
      | countries[0].isocode | NZ          |
      | countries[0].name    | New Zealand |
    And Test Data for GDC-10195 and Cart details

  @B2C_NZ_Address
  Scenario: [GDC-10206] Verify that API return State assoicted with shipping address
    Given I Hit Api to create B2CNZ Token
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And I hit API to get states assosiated with country
      | basestore   | cengage-b2c-nz |
      | countryCode | NZ             |
      | status      |            200 |
    Then I verify states in API response
      | NZ-NZ | New Zealand |
    And Test Data for GDC-10206 and Cart details

  @B2C_NZ_Address
  Scenario: [GDC-10205] Verify user is able to update shipping information
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
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryAddress.firstName  | Automation        |
      | deliveryAddress.lastName   | User              |
      | deliveryAddress.line1      | 224 Inglis Street |
      | deliveryAddress.line2      | Beach Haven       |
      | deliveryAddress.postalCode |              1050 |
      | deliveryAddress.town       | North Shore       |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz    |
      | address   | NZ_updatedaddress |
      | status    |               201 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryAddress.firstName  | Updated             |
      | deliveryAddress.lastName   | Details             |
      | deliveryAddress.line1      | 220 French Block    |
      | deliveryAddress.line2      | Upper Hutt          |
      | deliveryAddress.postalCode |                0592 |
      | deliveryAddress.town       | Riverstone Terraces |
    And Test Data for GDC-10205 and Cart details
