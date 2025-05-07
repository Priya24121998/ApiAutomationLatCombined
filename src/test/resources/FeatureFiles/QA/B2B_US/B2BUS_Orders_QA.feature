Feature: B2B US Order Scenarios

  #################################################  Smoke   ################################################################
  @B2B_Order_Smoke_QA
  Scenario: [GDC-9933] Verify that user is able to place order for multiple product using CC[VISA]
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9933 and order details

  @B2B_Order_Smoke_QA
  Scenario: [GDC-9929] Verify that user is able to place order with bulk Products using PO
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bMulQuantity_1  |
      | status    |            200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I verify paymentType
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9929 and order details

  @B2B_Order_Smoke_QA
  Scenario: [GDC-9931] [Partially Automated] Verify that IP Address field is updated in Backoffice if user place an order [using CC AMEX] with IP address.
    Given I Hit Api to create B2BUSNew Token
    When I create B2BUSNew cart with ip address
      | basestore | cengage-b2b-us |
      | IP        | testip         |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Amex card details
    When Accept Amex securit popup
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9931 and order details

  #################################################  Old Reggression   ###########################################################
  #Scenario: [SAPECOMM-8558] Verify that user should not be able to order without providing payment[CC] details
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        100114420 |
  #| billToAccountNumber |        100114420 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2bUsProduct   |
  #| status    |            200 |
  #When I hit API to Set  delivery modes
  #| basestore | cengage-b2b-us  |
  #| code      | GD |
  #| status    |             200 |
  #Then I hit API to Set drop ship address
  #| basestore | cengage-b2b-us  |
  #| address   | dropShipAddress |
  #| status    |             201 |
  #And I put PO number details using API
  #| basestore | cengage-b2b-us |
  #| PONumber  | PO1234567      |
  #| status    |            200 |
  #And I wait for 50 sec
  #Then User place order for B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            400 |
  #Then I verify error with given message
  #| Message | Payment info is not set |
  #And Test Data for SAPECOMM-8558 and Cart details
  #
  #Scenario: [SAPECOMM-8557] Verify that deliveryMode under order API response is send as per deliveryMode added in to the cart.
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        100114420 |
  #| billToAccountNumber |        100114420 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2bUsProduct   |
  #| status    |            200 |
  #When I hit API to Set  delivery modes
  #| basestore | cengage-b2b-us  |
  #| code      | GD |
  #| status    |             200 |
  #Then I hit API to Set drop ship address
  #| basestore | cengage-b2b-us  |
  #| address   | dropShipAddress |
  #| status    |             201 |
  #And I put PO number details using API
  #| basestore | cengage-b2b-us |
  #| PONumber  | PO1234567      |
  #| status    |            200 |
  #And I wait for 50 sec
  #And I launch dummy CyberSource
  #| basestore | cengage-b2b-us |
  #And User Enters Amex card details
  #And Accept AmEx securit popup
  #Then User verifies ACCEPT message
  #Then User place order for B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            200 |
  #When I hit API to get delivery mode in Order
  #| basestore    | cengage-b2b-us  |
  #| deliveryMode | GD |
  #| status       |             200 |
  #And Test Data for SAPECOMM-8557 and order details
  #
  #Scenario: [SAPECOMM-8656] Verify if user is able to set collectNumber and specialShippingInstructions during place order API and the same shows in backoffice.
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        100114420 |
  #| billToAccountNumber |        100114420 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2bUsProduct   |
  #| status    |            200 |
  #When I hit API to Set  delivery modes
  #| basestore | cengage-b2b-us  |
  #| code      | GD |
  #| status    |             200 |
  #Then I hit API to Set drop ship address
  #| basestore | cengage-b2b-us  |
  #| address   | dropShipAddress |
  #| status    |             201 |
  #And I put PO number details using API
  #| basestore | cengage-b2b-us |
  #| PONumber  | PO1234567      |
  #| status    |            200 |
  #And I launch dummy CyberSource
  #| basestore | cengage-b2b-us |
  #And User Enters Discover card details
  #Then User verifies ACCEPT message
  #Then Place B2B order with special shipping Instruction
  #| basestore                   | cengage-b2b-us                     |
  #| collectNumber               |                          285556317 |
  #| deferredShipDate            | 05/20/2023                         |
  #| specialShippingInstructions | special Shipping Instructions Text |
  #| status                      |                                200 |
  #And Test Data for SAPECOMM-8656 and order details
  #
  #Scenario: [SAPECOMM-8653] Verify if user is able to set collectNumber during place order API and the same shows in backoffice. [using PO]
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        100114420 |
  #| billToAccountNumber |        100114420 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2bUsProduct   |
  #| status    |            200 |
  #When I hit API to Set  delivery modes
  #| basestore | cengage-b2b-us  |
  #| code      | GD |
  #| status    |             200 |
  #Then I hit API to Set drop ship address
  #| basestore | cengage-b2b-us  |
  #| address   | dropShipAddress |
  #| status    |             201 |
  #And I put PO number details using API
  #| basestore | cengage-b2b-us |
  #| PONumber  | PO1234567      |
  #| status    |            200 |
  #Then Place B2B order with special shipping Instruction
  #| basestore                   | cengage-b2b-us                     |
  #| collectNumber               |                          285556317 |
  #| deferredShipDate            | 05/20/2023                         |
  #| specialShippingInstructions | special Shipping Instructions Text |
  #| status                      |                                200 |
  #And Test Data for SAPECOMM-8653 and order details
  #
  #Scenario: [SAPECOMM-8652] Verify that user is able to set default delivery mode & able to set shipping instructions and verify if the shipping instructions set in back office. [Using PO]
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        100114420 |
  #| billToAccountNumber |        100114420 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2bUsProduct   |
  #| status    |            200 |
  #When I hit API to Set  delivery modes
  #| basestore | cengage-b2b-us  |
  #| code      | GD |
  #| status    |             200 |
  #Then I hit API to Set drop ship address
  #| basestore | cengage-b2b-us  |
  #| address   | dropShipAddress |
  #| status    |             201 |
  #And I put PO number details using API
  #| basestore | cengage-b2b-us |
  #| PONumber  | PO1234567      |
  #| status    |            200 |
  #Then Place B2B order with special shipping Instruction
  #| basestore                   | cengage-b2b-us                     |
  #| collectNumber               |                          285556317 |
  #| deferredShipDate            | 05/20/2023                         |
  #| specialShippingInstructions | special Shipping Instructions Text |
  #| status                      |                                200 |
  #And Test Data for SAPECOMM-8652 and order details
  #################################################				QA				##############################################
  @B2B_Order_QA
  Scenario: [GDC-10177] Verify that user should not be able to order without providing PO  details
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-10177 and Cart details

  @B2B_Order_QA
  Scenario: [GDC-10172] Verify that deliveryMode under order API response is send as per deliveryMode added in to the cart.
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Amex card details
    When Accept Amex securit popup
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit API to get delivery mode in Order
      | basestore    | cengage-b2b-us               |
      | deliveryMode | GD |
      | status       |                          200 |
    And Test Data for GDC-10172 and order details

  @B2B_Order_QA
  Scenario: [GDC-10178] [Partially Automated] Verify if user is able to set collectNumber and specialShippingInstructions during place order API and the same shows in backoffice. [using CC MASTER]
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then Place B2B order with special shipping Instruction
      | basestore                   | cengage-b2b-us                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 05/20/2023                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                200 |
    And Test Data for GDC-10178 and order details

  @B2B_Order_QA
  Scenario: [GDC-10180] [Partially Automated] Verify if user is able to set collectNumber during place order API and the same shows in backoffice. [using PO]
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then Place B2B order with special shipping Instruction
      | basestore                   | cengage-b2b-us                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 05/20/2023                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                200 |
    And Test Data for GDC-10180 and order details

  @B2B_Order_QA
  Scenario: [GDC-10192] [Partially Automated] Verify that user is able to set default delivery mode & able to set shipping instructions and verify if the shipping instructions set in back office. [Using PO]
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then Place B2B order with special shipping Instruction
      | basestore                   | cengage-b2b-us                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 05/20/2023                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                200 |
    And Test Data for GDC-10192 and order details

  @B2B_Order_QA
  Scenario: [GDC-10465] Verify that user is able to enter different address as a delivery address other than shipTo address.
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
        And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to get Address details
      | basestore | cengage-b2b-us |
      | town      |   north canton |
      | line1     | 6200 frank ave nw|
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    When I hit API to get Address details
      | basestore | cengage-b2b-us     |
      | town      | Stamford           |
      | line1     | COPIAH-LINCOLN WAY |
      | status    |                200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD |
      | status    |                          200 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-10465 and order details

