Feature: B2B US Order Scenarios


  @B2B_Order_load_test @B2B_Order_load_test_setone
  Scenario Outline: [GDC-9929] Verify that user is able to place order with bulk Products using PO
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    | 201            |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4200508 |
      | billToAccountNumber |        4200508 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9933 and order details

    Examples:
      | user |
      |B2BUSOne|
      |B2BUSTwo|
      |B2BUSThree|
      |B2BUSFour|
      |B2BUSFive|
      |B2BUSSix|
      |B2BUSSeven|
      |B2BUSEight|
      |B2BUSNine|
      |B2BUSTen|

  @B2B_Order_load_test @B2B_Order_load_test_settwo
  Scenario Outline: [GDC-9929] Verify that user is able to place order with bulk Products using PO
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    | 201            |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4200508 |
      | billToAccountNumber |        4200508 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9933 and order details

    Examples:
      | user |
      |B2BUSEleven|
      |B2BUSTwelve|
      |B2BUSThirtheen|
      |B2BUSFourteen|
      |B2BUSFifteen|
      |B2BUSSixteen|
      |B2BUSSeventeen|
      |B2BUSEighteen|
      |B2BUSNineteen|
      |B2BUSTwenty|


  @B2B_Order_load_test @B2B_Order_load_test_setthree
  Scenario Outline: [GDC-9929] Verify that user is able to place order with bulk Products using PO
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    | 201            |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4200508 |
      | billToAccountNumber |        4200508 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9933 and order details

    Examples:
      | user |
      |B2BUSTwentyOne|
      |B2BUSTwentyTwo|
      |B2BUSTwentyThree|
      |B2BUSTwentyFour|
      |B2BUSTwentyFive|
      |B2BUSTwentySix|
      |B2BUSTwentySeven|
      |B2BUSTwentyEight|
      |B2BUSTwentyNine|
      |B2BUSThirthy|

  @B2B_Order_load_test @B2B_Order_load_test_setfour
  Scenario Outline: [GDC-9929] Verify that user is able to place order with bulk Products using PO
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    | 201            |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4200508 |
      | billToAccountNumber |        4200508 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9933 and order details

    Examples:
      | user |
      |B2BUSThirthyOne|
      |B2BUSThirthyTwo|
      |B2BUSThirthyThree|
      |B2BUSThirthyFour|
      |B2BUSThirthyFive|
      |B2BUSThirthySix|
      |B2BUSThirthySeven|
      |B2BUSThirthyEight|
      |B2BUSThirthyNine|
      |B2BUSFourty|

  @B2B_Order_load_test @B2B_Order_load_test_setfive
  Scenario Outline: [GDC-9929] Verify that user is able to place order with bulk Products using PO
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    | 201            |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4200508 |
      | billToAccountNumber |        4200508 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9933 and order details

    Examples:
      | user |
      |B2BUSFourtyOne|
      |B2BUSFourtyTwo|
      |B2BUSFourtyThree|
      |B2BUSFourtyFour|
      |B2BUSFourtyFive|
      |B2BUSFourtySix|
      |B2BUSFourtySeven|
      |B2BUSFourtyEight|
      |B2BUSFourtyNine|
      |B2BUSFifty|


