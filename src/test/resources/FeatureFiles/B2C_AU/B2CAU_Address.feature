Feature: B2C AU Address API Scenarios

  @B2C_AU_Address 
  Scenario: I create a Cart to get Adddress Id
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_1 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    When I get delivery address id and save it
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    When I get billing address id and save it

  @B2C_AU_Address
  Scenario: [GDC-10238] Verify that user is able to update the address
    Given I Hit Api to create B2CAU Token
   Given I want to update delivery address details
      | basestore | cengage-b2c-au    |
      | Address   | AU_updatedaddress |
      | status    |               200 |
    And I want to read delivery address details
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When I verify delivery AddressId in Response
		Then I verify following details in API response
      | country.isocode | AU                  |
      | firstName       | Updated             |
      | lastName        | Details             |
      | line1           | 220 French Block    |
      | postalCode      |                6061 |
      | town            | Riverstone Terraces |
      
  @B2C_AU_Address
  Scenario: [GDC-10233] Verify user is able to update shipping information
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryAddress.firstName  | Automation         |
      | deliveryAddress.lastName   | User               |
      | deliveryAddress.line1      | 73 Nandewar Street |
      | deliveryAddress.line2      | Bowraville         |
      | deliveryAddress.postalCode |               2264 |
      | deliveryAddress.town       | New South Wales    |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au    |
      | address   | AU_updatedaddress |
      | status    |               201 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryAddress.firstName  | Updated             |
      | deliveryAddress.lastName   | Details             |
      | deliveryAddress.line1      | 220 French Block    |
      | deliveryAddress.line2      | Upper Hutt          |
      | deliveryAddress.postalCode |                6061 |
      | deliveryAddress.town       | Riverstone Terraces |
    And Test Data for GDC-10233 and Cart details
