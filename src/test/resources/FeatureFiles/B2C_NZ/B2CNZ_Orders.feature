Feature: B2C NZ Order Scenarios

  #################################################  Smoke   ################################################################
  @B2C_NZ_Order_Smoke
  Scenario: [GDC-9936] Verify that user is able to place order for digital product using CC.
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | NZb2cDigital_3 |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-nz |
    And User Enters Amex card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And Test Data for GDC-9936 and order details

  @B2C_NZ_Order_Smoke
  Scenario: [GDC-9941] Verify user is able to checkout Value Pack+physical+digital from single Cart
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cValuePack_1 |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_2 |
      | status    |             200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | NZb2cDigital_3 |
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
    And I launch dummy CyberSource
      | basestore | cengage-b2c-nz |
    And User Enters Amex card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And Test Data for GDC-9941 and order details

  #################################################  Reggression   ###########################################################
  @B2C_NZ_Order
  Scenario: [GDC-10225] Verify that user is able to place order for single product using CC.
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
    And I launch dummy CyberSource
      | basestore | cengage-b2c-nz |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I wait for 30 sec
    Then User place order for B2C cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And Test Data for GDC-10225 and order details

  @B2C_NZ_Order
  Scenario: [GDC-10217] Verify that user should not be able to order without providing payment details
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
    And I launch dummy CyberSource
      | basestore | cengage-b2c-nz |
    Then User place order for B2C cart
      | basestore | cengage-b2c-nz |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-10217 and Cart details

  @B2C_NZ_Order
  Scenario: [GDC-10215] [Partially Automated] Verify if user is able to set collectNumber and specialShippingInstructions during place order API and the same shows in backoffice.
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
    And I launch dummy CyberSource
      | basestore | cengage-b2c-nz |
    And User Enters Master card details
    Then User verifies ACCEPT message
    And I wait for 25 sec
    Then Place B2C order with special shipping Instruction
      | basestore                   | cengage-b2c-nz                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 06/20/2023                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                201 |
    And Test Data for GDC-10215 and order details

  @B2C_NZ_Order
  Scenario: [GDC-10219] [Partially Automated] Verify if user is able to set collectNumber and specialShippingInstructions during place order API and the same shows in backoffice.
    Given I Hit Api to create B2CNZ Token
    When I hit get order details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    And Test Data for GDC-10219 and order details

  @B2C_NZ_Order
  Scenario: [GDC-10212] Verify user is able to checkout Value Pack from the Cart
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cValuePack_1 |
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
    And I launch dummy CyberSource
      | basestore | cengage-b2c-nz |
    And User Enters Amex card details
    Then User verifies ACCEPT message
    And I wait for 30 sec
    Then User place order for B2C cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And Test Data for GDC-10212 and order details
