Feature: B2B US Place Order Scenarios
 #################################################  Smoke and Regression  ###########################################################
  #Existing User
  @B2B_US_PlaceOrder_Perf
  Scenario Outline: B2B US- PO+CC Order-GD Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us           |
      | Product   | b2busproductDel          |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us |
      | code      | GD             |
      | status    |            200 |
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
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user              | billToShipToAccountDet   |accountType   | excelName       |  tabName      | paymentType   |
      |  1    |B2BUSOrderOne      | B2BUS                    |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |
      |  2    |B2BUSOrderOne      | B2BUS                    |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |
      |  3    |B2BUSOrderOne      | B2BUS                    |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |


  @B2B_US_PlaceOrder_Perf
  Scenario Outline: B2B US- PO+CC Order-MS Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us           |
      | Product   | b2busproductDel          |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us |
      | code      | MS             |
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user              | billToShipToAccountDet  |accountType   | excelName       |  tabName      | paymentType   |
      |  4    |B2BUSOrderOne      | B2BUS                   |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |

  @B2B_US_PlaceOrder_Perf
  Scenario Outline: B2B US- PO+CC Order-1D Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us           |
      | Product   | b2busproductDel          |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us |
      | code      | 1D             |
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user              | billToShipToAccountDet  |accountType   | excelName       |  tabName      | paymentType   |
      |  7    |B2BUSOrderOne      | B2BUS                   |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |
      |  8    |B2BUSOrderOne      | B2BUS                   |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |
      |  9    |B2BUSOrderOne      | B2BUS                   |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |

  @B2B_US_PlaceOrder_Perf
  Scenario Outline: B2B US- PO+CC Order-2D Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us           |
      | Product   | b2busproductDel          |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us |
      | code      | 2D             |
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user              | billToShipToAccountDet  |accountType   | excelName       |  tabName      | paymentType   |
      |  10   |B2BUSOrderOne      | B2BUS                   |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |
      |  11   |B2BUSOrderOne      | B2BUS                   |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |
      |  12   |B2BUSOrderOne      | B2BUS                   |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | PO            |

