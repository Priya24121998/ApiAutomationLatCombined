Feature: B2BCA_OrderShipmentStatusUpdate

@B2BCA_OrderShipmentStatusUpdate
    Scenario: [GDC-12926] Verify that the user is able to place an order using Credit card [Visa]
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2bProduct_1   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        84000381 |
      | billToAccountNumber |        84000381 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |       1    |
      | status     | IN_PROCESS |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus |  SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            1   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |         1 |
      | status     | COMPLETED |
    And Test Data for GDC-12670 and Order details
    
    
@B2BCA_OrderShipmentStatusUpdate_QA
    Scenario: [GDC-12926] Verify that the user is able to place an order using Credit card [Visa]
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2bProduct_1   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        37722155 |
      | billToAccountNumber |        37722155 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |       1    |
      | status     | IN_PROCESS |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus |  SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            1   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |         1 |
      | status     | COMPLETED |
    And Test Data for GDC-12670 and Order details
    
    
    @B2BCA_OrderShipmentStatusUpdate
    Scenario: [GDC-12928] Verify total shipped quantity in a different consignment entry Created
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        84000381 |
      | billToAccountNumber |        84000381 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1    |
      | status              | IN_PROCESS |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | IN_PROCESS |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[1].quantity         | 5          |
      | consignments[0].entries[1].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
    
     @B2BCA_OrderShipmentStatusUpdate_QA
    Scenario: [GDC-12928] Verify total shipped quantity in a different consignment entry Created
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        37722155 |
      | billToAccountNumber |        37722155 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1    |
      | status              | IN_PROCESS |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | IN_PROCESS |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[1].quantity         | 5          |
      | consignments[0].entries[1].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
    
 
 
   @B2BCA_OrderShipmentStatusUpdate
    Scenario: [GDC-12931] Verify if shipping quantity more than the ordered quantity error message is displayed
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        84000381 |
      | billToAccountNumber |        84000381 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1    |
      | status              | IN_PROCESS |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            400 |
      | qtyShipped      |            15  |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    Then I verify following details in API response
      | errors[0].reason          | invalid |
      | errors[0].subject         | 15      |
    And Test Data for GDC-12670 and Order details
    
    @B2BCA_OrderShipmentStatusUpdate_QA
    Scenario: [GDC-12931] Verify if shipping quantity more than the ordered quantity error message is displayed
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        37722155 |
      | billToAccountNumber |        37722155 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1    |
      | status              | IN_PROCESS |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            400 |
      | qtyShipped      |            15  |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    Then I verify following details in API response
      | errors[0].reason          | invalid |
      | errors[0].subject         | 15      |
    And Test Data for GDC-12670 and Order details
       
     @B2BCA_OrderShipmentStatusUpdate
    Scenario: [GDC-12934] Verify if cancelled few quantity from the ordered quantity, user should be able to ship the remaining quantity
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        84000381 |
      | billToAccountNumber |        84000381 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1 |
      | status              | PENDING |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus |   SHIPPED      |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                     | 1                 |
      | deliveryOrderGroups[0].entries[0].entryStatus  | SHIPPED         |
      | consignments[0].entries[0].quantity            | 5                 |
      #| consignments[0].status                        | READY             |
      | status                                         | IN_PROCESS        |
    And I want to update ShipmentStatus of order  
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus |     CANCELLED  |
      | status          |            200 |
      | qtyShipped      |            0   |
      | qtyCancelled    |            5   |
      | qtyBackOrdered  |            0   |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
    
    
     @B2BCA_OrderShipmentStatusUpdate_QA
    Scenario: [GDC-12934] Verify if cancelled few quantity from the ordered quantity, user should be able to ship the remaining quantity
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9  |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        37722155 |
      | billToAccountNumber |        37722155 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1    |
      | status              | IN_PROCESS |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus |   SHIPPED      |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                     | 1                 |
      | deliveryOrderGroups[0].entries[0].entryStatus  | SHIPPED         |
      | consignments[0].entries[0].quantity            | 5                 |
      #| consignments[0].status                        | READY             |
      | status                                         | IN_PROCESS        |
    And I want to update ShipmentStatus of order  
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus |     CANCELLED  |
      | status          |            200 |
      | qtyShipped      |            0   |
      | qtyCancelled    |            5   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
    
    @B2BCA_OrderShipmentStatusUpdate
    Scenario: [GDC-12937] Verify if BackOrdered few quantity from the ordered quantity,later user should be able to ship ordered quantity when available
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        84000381 |
      | billToAccountNumber |        84000381 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1    |
      | status              | IN_PROCESS |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | BACKORDERED    |
      | status          |            200 |
      | qtyShipped      |            0   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            5   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                     | 1                 |
      | deliveryOrderGroups[0].entries[0].entryStatus  | BACKORDERED       |
      | consignments[0].entries[0].quantity            | 5                 |
      | consignments[0].status                         | WAITING           |
      | status                                         | IN_PROCESS        |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | IN_PROCESS |
      And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[1].quantity         | 5          |
      | consignments[0].entries[1].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
    
    
    @B2BCA_OrderShipmentStatusUpdate_QA
    Scenario: [GDC-12937] Verify if BackOrdered few quantity from the ordered quantity,later user should be able to ship ordered quantity when available
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | B2BCAproduct9   |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |        37722155 |
      | billToAccountNumber |        37722155 |
      | status              |            202 |
     When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems          |       1    |
      | status              | IN_PROCESS |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | BACKORDERED    |
      | status          |            200 |
      | qtyShipped      |            0   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            5   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                     | 1                 |
      | deliveryOrderGroups[0].entries[0].entryStatus  | BACKORDERED       |
      | consignments[0].entries[0].quantity            | 5                 |
      | consignments[0].status                         | WAITING           |
      | status                                         | IN_PROCESS        |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | IN_PROCESS |
      And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-ca |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[1].quantity         | 5          |
      | consignments[0].entries[1].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
       
