Feature: B2B GT Order Scenarios

  #################################################  Smoke   ################################################################

  @B2BGT_Order_Smoke_Int
  Scenario: [GDC-10388] Verify that user is able to place an order using CC VISA
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_4 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10388 and order details

  @B2BGT_Order_Smoke_Int
  Scenario: [GDC-10480] Verify that user is able to place an order using Thorndike ISBNs. [CC]
    Given I Hit Api to create B2BGThorndikeOne Token
    When I hit API to create B2BGThorndikeOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt        |
      | Product   | b2bThornDikeProduct_1 |
      | status    |                   200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Discover2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10480 and order details

  @B2BGT_Order_Smoke_Int
  Scenario: [GDC-10423] [Partially Automated] Verify that Outbound payload is created successfully.
    Given I Hit Api to create B2BGThorndikeOne Token
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780062843050@@NA |
      | totalPriceWithTax.value | not Zero          |
      | subTotal.value          | not zero          |
      | deliveryAddress         | not null          |
      | deliveryMode.code       | GD                |
      | store                   | cengage-b2b-gt    |
      | totalPrice.currencyIso  | USD               |
      | orderType               | REGULAR           |
    And Test Data for GDC-10423 and Order details

  #@B2BGT_Order_Smoke
  #Scenario: [GDC-10479] Verify that user is able to place an order using Thorndike ISBNs. [PO]
  #Given I Hit Api to create B2BThorndike Token
  #When I hit API to create B2BThorndike cart
  #| basestore | cengage-b2b-gt |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-gt |
  #| shipToAccountNumber |         375223 |
  #| billToAccountNumber |         375223 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-gt        |
  #| Product   | b2bThornDikeProduct_1 |
  #| status    |                   200 |
  #When I hit API to Set  delivery modes
  #| basestore | cengage-b2b-gt |
  #| code      | DefaultGT      |
  #| status    |            200 |
  #And I put PO number details using API
  #| basestore | cengage-b2b-gt |
  #| PONumber  | PO1234567      |
  #| status    |            200 |
  #And I wait for 50 sec
  #Then User place order for B2B cart
  #| basestore | cengage-b2b-gt |
  #| status    |            200 |
  #And Test Data for GDC-10479 and order details
  #################################################  Reggression   ################################################################
  @B2BGT_Order_Int
  Scenario: [GDC-10391] Verify that user is able to place an order using CC DISCOVER
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_1 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Discover2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10391 and order details

  @B2BGT_Order_Int
  Scenario: [GDC-10390] Verify that user is able to place an order using CC AMEX
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    When I enter Amex3 credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10390 and order details

  @B2BGT_Order_Int
  Scenario: [GDC-10389] Verify that user is able to place an order using CC MASTER
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_3 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Master2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10389 and order details

  @B2BGT_Order_Int
  Scenario: [GDC-10407] Verify user should be able to get order details once placed.
    Given I Hit Api to create B2BGTOne Token
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |                 1 |
      | entries[0].product.code | 9780028658834@@NA |
      | totalPriceWithTax.value | not Zero          |
      | subTotal.value          | not zero          |
      | totalTax.value          |               0.0 |
      | deliveryAddress         | not null          |
      | deliveryMode.code       | GD                |
      | store                   | cengage-b2b-gt    |
      | totalPrice.currencyIso  | USD               |
      | orderType               | REGULAR           |
    And Test Data for GDC-10407 and Order details

  @B2BGT_Order_Int
  Scenario: [GDC-10387] Verify that user is able to place an order using PO mode.
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_5 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I verify paymentType
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10387 and order details

  @B2BGT_Order_Int
  Scenario: [GDC-10398] [Partially Automated] Verify order Confirmation email payload under Business Processes for gale user.
    Given I Hit Api to create B2BGTOne Token
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |              1 |
      | totalPriceWithTax.value | not Zero       |
      | subTotal.value          | not zero       |
      | deliveryAddress         | not null       |
      | deliveryMode.code       | GD             |
      | store                   | cengage-b2b-gt |
      | totalPrice.currencyIso  | USD            |
      | orderType               | REGULAR        |
    And Test Data for GDC-10398 and Order details

  @B2BGT_Order_Int
  Scenario: [GDC-10384] Verify that user should not be able to order without providing PO details
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_3 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-10384 and Cart details

  @B2BGT_Order_Int
  Scenario: [GDC-10180] [Partially Automated] Verify if user is able to set collectNumber during place order API and the same shows in backoffice. [using PO]
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then Place B2B order with special shipping Instruction
      | basestore                   | cengage-b2b-gt                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 01/20/2024                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                200 |
    And Test Data for GDC-10180 and order details

  @B2BGT_Order_Int
  Scenario: [GDC-10394] [Partially Automated] Verify that IP Address field is updated in Backoffice if user place an order with IP address
    Given I Hit Api to create B2BGTOne Token
    When I create B2BGTOne cart with ip address
      | basestore | cengage-b2b-gt |
      | IP        | testip         |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_5 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10394 and order details

    Scenario: [GDC-12670] [Partially Automated] Verify shippment confirmation email payload under Business Processes for gale user
    Given I Hit Api to create B2BGT Token
    When I hit API to create B2BGT cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |         375223 |
      | billToAccountNumber |         375223 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | DefaultGT      |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |       1 |
      | status     | PENDING |
    And I want to update status of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |         1 |
      | status     | COMPLETED |
    And Test Data for GDC-12670 and Order details

  @B2BGT_Order_Int
  Scenario: [GDC-12667] [Partially Automated] Verify order Confirmation email payload under Business Processes for thorndike user.
    Given I Hit Api to create B2BGThorndikeOne Token
    When I hit API to create B2BGThorndikeOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt        |
      | Product   | b2bThornDikeProduct_1 |
      | status    |                   200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Discover2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-12667 and order details

#  @B2BGT_Order_Int
  Scenario: [GDC-12671] [Partially Automated] Verify shippment confirmation email payload under Business Processes for thorndike user
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
  And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |       1 |
      | status     | PENDING |
    And I want to update status of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780062843050 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
    And I wait for 70 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |         1 |
      | status     | COMPLETED |
    And Test Data for GDC-12671 and Order details
