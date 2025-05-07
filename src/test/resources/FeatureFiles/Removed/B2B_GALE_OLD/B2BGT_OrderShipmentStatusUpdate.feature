Feature: B2BGT_OrderShipmentStatusUpdate

 
    Scenario: [GDC-12925] Verify Order status was moved to completed status once all the products in the order were shipped                 
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
    And I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus |  SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            1   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems |         1 |
      | status     | COMPLETED |
    And Test Data for GDC-12670 and Order details
    
    
    
    
    Scenario: [GDC-12929]Verify total shipped quantity in a different consignment entry Created
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
      | Product   | b2bGaleProduct_8 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | DefaultGT      |
      | status    |            200 |
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
      | totalItems          |       1 |
      | status              | PENDING |
      | unconsignedEntries[0].quantity      | 10      |
    And  I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | IN_PROCESS |
    And I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[1].quantity         | 5          |
      | consignments[0].entries[1].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
    
 
 
   
    Scenario: [GDC-12933] Verify if shipping quantity more than the ordered quantity error message is displayed
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
      | Product   | b2bGaleProduct_8 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | DefaultGT      |
      | status    |            200 |
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
      | totalItems          |       1 |
      | status              | PENDING |
      | unconsignedEntries[0].quantity             | 10      |
    And I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
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
       
     
    Scenario: [GDC-12935] Verify if cancelled few quantity from the ordered quantity, user should be able to ship the remaining quantity
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
      | Product   | b2bGaleProduct_8 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | DefaultGT      |
      | status    |            200 |
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
      | totalItems          |       1 |
      | status              | PENDING |
      | unconsignedEntries[0].quantity       | 10      |
    And I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus |   SHIPPED      |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                     | 1                 |
      | deliveryOrderGroups[0].entries[0].entryStatus  | SHIPPED         |
      | consignments[0].entries[0].quantity            | 5                 |
      #| consignments[0].status                        | READY             |
      | status                                         | IN_PROCESS        |
    And I want to update ShipmentStatus of order  
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus |     CANCELLED  |
      | status          |            200 |
      | qtyShipped      |            0   |
      | qtyCancelled    |            5   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
    
    
    
    
    Scenario: [GDC-12939] Verify if BackOrdered few quantity from the ordered quantity,later user should be able to ship ordered quantity when available
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
      | Product   | b2bGaleProduct_8 |
      | status    |              200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | DefaultGT      |
      | status    |            200 |
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
      | totalItems          |       1 |
      | status              | PENDING |
      | unconsignedEntries[0].quantity       | 10      |
    And I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus | BACKORDERED    |
      | status          |            200 |
      | qtyShipped      |            0   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            5   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                     | 1                 |
      | deliveryOrderGroups[0].entries[0].entryStatus  | BACKORDERED       |
      | consignments[0].entries[0].quantity            | 5                 |
      | consignments[0].status                         | WAITING           |
      | status                                         | IN_PROCESS        |
    And I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[0].quantity         | 5          |
      | consignments[0].entries[0].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | IN_PROCESS |
      And I want to update ShipmentStatus of order
      | basestore       | cengage-b2b-gt |
      | ISBN            |  9780787676674 |
      | orderlineStatus | SHIPPED        |
      | status          |            200 |
      | qtyShipped      |            5   |
      | qtyCancelled    |            0   |
      | qtyBackOrdered  |            0   |
    And I wait for 60 sec
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems                                  | 1          |
      | consignments[0].entries[1].quantity         | 5          |
      | consignments[0].entries[1].shippedQuantity  | 5          |
      | consignments[0].status                      | SHIPPED    |
      | status                                      | COMPLETED  |
    And Test Data for GDC-12670 and Order details
       