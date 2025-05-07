Feature: B2B US Place Order Scenarios
 #################################################  Smoke and Regression  ###########################################################
  #Existing User
  @B2B_US_PlaceOrder
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
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
      | order | user              | billToShipToAccountDet  |  creditCardType |accountType   | excelName       |  tabName      | paymentType   |
      |  1    |B2BUSOrderOne      | B2BUS                   |  Visa           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  2    |B2BUSOrderOne      | B2BUS                   |  Discover       |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Discover   |
      |  3    |B2BUSOrderOne      | B2BUS                   |  Master3         |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |


  @B2B_US_PlaceOrder
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
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
      | order | user              | billToShipToAccountDet  |  creditCardType |accountType   | excelName       |  tabName      | paymentType   |
      |  4    |B2BUSOrderOne      | B2BUS                   |  Visa           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  5    |B2BUSOrderOne      | B2BUS                   |  Discover       |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Discover   |
      |  6    |B2BUSOrderOne      | B2BUS                   |  Master3         |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |

  @B2B_US_PlaceOrder
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
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
      | order | user              | billToShipToAccountDet  |  creditCardType |accountType   | excelName       |  tabName      | paymentType   |
      |  7    |B2BUSOrderOne      | B2BUS                   |  Visa           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  8    |B2BUSOrderOne      | B2BUS                   |  Discover       |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Discover   |
      |  9    |B2BUSOrderOne      | B2BUS                   |  Master3         |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |

  @B2B_US_PlaceOrder
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
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
      | order | user              | billToShipToAccountDet  |  creditCardType |accountType   | excelName       |  tabName      | paymentType   |
      |  10   |B2BUSOrderOne      | B2BUS                   |  Visa           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  11   |B2BUSOrderOne      | B2BUS                   |  Discover       |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Discover   |
      |  12   |B2BUSOrderOne      | B2BUS                   |  Master3        |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |

  @B2B_US_PlaceOrder
  Scenario Outline: B2B US- PO+CC -Amex- Order-All Delivery modes
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
      | basestore | cengage-b2b-us   |
      | code      | <deliveryType>   |
      | status    |            200   |
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
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
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
      | order  | user               | billToShipToAccountDet  |  creditCardType   |accountType      | excelName         |  tabName        | paymentType   |deliveryType |
      |  13    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | GD         |
      |  14    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | 1D         |
      |  15    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | 2D         |
      |  16    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | MS         |

  @B2B_US_PlaceOrder
  Scenario Outline: B2B US- PO+CC -Amex- Order-All Delivery modes - Promo code check
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us           |
      | Product   | b2bMulQuantity_1         |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us   |
      | code      | <deliveryType>   |
      | status    |            200   |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-us      |
      |promoCode  | B2BGT_Prod_Promo    |
      | status    |            200      |
    Then I verify coupon is applied
      | basestore | cengage-b2b-us     |
      | promoCode | B2BGT_Prod_Promo   |
      | status    |             200    |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "couponCode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order  | user               | billToShipToAccountDet  |  creditCardType   |accountType      | excelName         |  tabName        | paymentType   |deliveryType |
      |  17    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | GD         |
      |  18    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | 1D         |
      |  19    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | 2D         |
      |  20    |B2BUSOrderOne       | B2BUS                   |  Amex3             |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | MS         |

  @B2B_US_PlaceOrder
  Scenario Outline: B2B US- PO+CC -Visa , master and discover - Order-All Delivery modes - Promo code check
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us           |
      | Product   | b2bMulQuantity_1         |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us   |
      | code      | <deliveryType>   |
      | status    |            200   |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-us      |
      |promoCode  | B2BGT_Prod_Promo  |
      | status    |            200      |
    Then I verify coupon is applied
      | basestore | cengage-b2b-us     |
      | promoCode | B2BGT_Prod_Promo |
      | status    |             200    |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "couponCode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order  | user               | billToShipToAccountDet  |  creditCardType   |accountType      | excelName         |  tabName        | paymentType   |deliveryType |
      |  21    |B2BUSOrderOne       | B2BUS                   |  Master3           |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | GD         |
      |  22    |B2BUSOrderOne       | B2BUS                   |  Master3           |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | 1D         |
      |  23    |B2BUSOrderOne       | B2BUS                   |  Visa              |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | 2D         |
      |  24    |B2BUSOrderOne       | B2BUS                   |  Discover          |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | MS         |

# 3d's enabled popup
  @B2B_US_PlaceOrder_3DS
  Scenario Outline: B2B US- PO+CC Order-GD Delivery mode - with 3d's enabled
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
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
      | order  | user               | billToShipToAccountDet  |  creditCardType  |accountType   | excelName       |  tabName      | paymentType    |
      |  1     |B2BUSOrderOne      | B2BUS                    |  Visa3           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  2     |B2BUSOrderOne      | B2BUS                    |  Master          |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |
      |  3     |B2BUSOrderOne      | B2BUS                    |  Amex4           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Amex       |



  @B2B_US_PlaceOrder_3DS
  Scenario Outline: B2B US- PO+CC Order-MS Delivery mode - with 3d's enabled
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
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
      | order | user              | billToShipToAccountDet  |  creditCardType |accountType   | excelName       |  tabName      | paymentType   |
      |  4    |B2BUSOrderOne      | B2BUS                   |  Visa3          |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  5    |B2BUSOrderOne      | B2BUS                   |  Amex4          |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Amex       |
      |  6    |B2BUSOrderOne      | B2BUS                   |  Master         |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |

  @B2B_US_PlaceOrder_3DS
  Scenario Outline: B2B US- PO+CC Order-2D Delivery mode - with 3d's enabled
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
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
      | order | user              | billToShipToAccountDet  |  creditCardType  |accountType   | excelName       |  tabName      | paymentType   |
      |  7    |B2BUSOrderOne      | B2BUS                   |  Visa3           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  8    |B2BUSOrderOne      | B2BUS                   |  Amex4           |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Amex       |
      |  9    |B2BUSOrderOne      | B2BUS                   |  Master          |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |

  @B2B_US_PlaceOrder_3DS
  Scenario Outline: B2B US- PO+CC Order-1D Delivery mode - with 3d's enabled
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
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
      | order | user              | billToShipToAccountDet  |  creditCardType |accountType   | excelName       |  tabName      | paymentType   |
      |  10   |B2BUSOrderOne      | B2BUS                   |  Visa3          |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Visa       |
      |  11   |B2BUSOrderOne      | B2BUS                   |  Amex4          |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Amex       |
      |  12   |B2BUSOrderOne      | B2BUS                   |  Master         |accountType-X | PlaceOrder.xlsx |  B2BUS_Order  | CC-Master     |

  @B2B_US_PlaceOrder_3DS
  Scenario Outline: B2B US- PO+CC -Order-All Delivery modes - Promo code check- with 3d's enabled
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us           |
      | Product   | b2bMulQuantity_1         |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us   |
      | code      | <deliveryType>   |
      | status    |            200   |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-us      |
      |promoCode  | B2BGT_Prod_Promo  |
      | status    |            200      |
    Then I verify coupon is applied
      | basestore | cengage-b2b-us     |
      | promoCode | B2BGT_Prod_Promo |
      | status    |             200    |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
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
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "couponCode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order  | user               | billToShipToAccountDet  |  creditCardType   |accountType      | excelName         |  tabName        | paymentType   |deliveryType |
      |  13    |B2BUSOrderOne       | B2BUS                   |  Master           |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Master    | GD         |
      |  14    |B2BUSOrderOne       | B2BUS                   |  Visa3            |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Visa      | 2D         |
      |  15    |B2BUSOrderOne       | B2BUS                   |  Amex4            |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | MS         |
      |  16    |B2BUSOrderOne       | B2BUS                   |  Amex4            |accountType-X     | PlaceOrder.xlsx  |  B2BUS_Order     | CC-Amex      | 1D         |
