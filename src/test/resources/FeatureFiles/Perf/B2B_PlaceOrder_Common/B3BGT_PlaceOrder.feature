Feature: B2B GT Place Order Scenarios

  @B2BGT_PlaceOrder_Perf
  Scenario Outline: B2B GT- PO Order-GD Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleProduct_4         |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I wait for 30 sec
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user         | billToShipToAccountDet  | accountType   | excelName       |  tabName      | paymentType |
      |  1    |B2BGTOrderOne | B2BGT                   | accountType-X | PlaceOrder.xlsx |  B2BGT_Order  | PO          |
      |  2    |B2BGTOrderOne | B2BGT                   | accountType-X |  PlaceOrder.xlsx|  B2BGT_Order  | PO          |


  @B2BGT_PlaceOrder_Perf
  Scenario Outline: B2B GT- PO Order-GD Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleProduct_4         |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I wait for 30 sec
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user         | billToShipToAccountDet  | accountType   | excelName       |  tabName      | paymentType |
      |  3    |B2BGTOrderOne | B2BGT                   | accountType-X | PlaceOrder.xlsx |  B2BGT_Order  | PO          |
      |  4    |B2BGTOrderOne | B2BGT                   | accountType-X |  PlaceOrder.xlsx|  B2BGT_Order  | PO          |


  @B2BGT_PlaceOrder_Perf
  Scenario Outline: B2B GT- PO Order-GD Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleProduct_4         |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I wait for 30 sec
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user         | billToShipToAccountDet  | accountType   | excelName       |  tabName      | paymentType |
      |  5    |B2BGTOrderOne | B2BGT                   | accountType-X | PlaceOrder.xlsx |  B2BGT_Order  | PO          |
      |  6    |B2BGTOrderOne | B2BGT                   | accountType-X |  PlaceOrder.xlsx|  B2BGT_Order  | PO          |


  @B2BGT_PlaceOrder_Perf
  Scenario Outline: B2B GT- PO Order-GD Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleProduct_4         |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I wait for 30 sec
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user         | billToShipToAccountDet  | accountType   | excelName       |  tabName      | paymentType |
      |  7    |B2BGTOrderOne | B2BGT                   | accountType-X | PlaceOrder.xlsx |  B2BGT_Order  | PO          |
      |  8    |B2BGTOrderOne | B2BGT                   | accountType-X |  PlaceOrder.xlsx|  B2BGT_Order  | PO          |
