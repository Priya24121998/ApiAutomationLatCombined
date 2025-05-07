Feature: B2B CA Place Order Scenarios
 #################################################  Smoke and Regression  ###########################################################
  #Existing User
  @B2BCA_PlaceOrder
  Scenario Outline: B2B CA- PO Order-GD Delivery mode
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-ca |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca           |
      | Product   | b2bca_Product_ErpPhase   |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | GD             |
      | status    |            200 |
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
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
      |  1    |B2BCANew_SType| B2BCA_SType             | accountType-S | PlaceOrder.xlsx |  B2BCA_Order  | PO          |
      |  2    |B2BCANew      | B2BCA                   | accountType-X |  PlaceOrder.xlsx|  B2BCA_Order  | PO          |