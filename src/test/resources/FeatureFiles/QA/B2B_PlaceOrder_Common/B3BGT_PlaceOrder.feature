Feature: B2B GT Place Order Scenarios

  #without 3Ds enabled
  @B2BGT_PlaceOrder
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
      |  1    |B2BGTOne_SType| B2BGT_SType             | accountType-S | PlaceOrder.xlsx |  B2BGT_Order  | PO          |
      |  2    |B2BGTOrderOne | B2BGT                   | accountType-X |  PlaceOrder.xlsx|  B2BGT_Order  | PO          |

  @B2BGT_PlaceOrder
  Scenario Outline: B2B GT- PO+CC- Order-GD Delivery mode
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user         | billToShipToAccountDet  | accountType   |creditCardType | excelName      |  tabName      | paymentType |
      |  3    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Visa          |PlaceOrder.xlsx |  B2BGT_Order  | CC-Visa     |
      |  4    |B2BGTOrderOne | B2BGT                   | accountType-X | Discover      |PlaceOrder.xlsx |  B2BGT_Order  | CC-Discover |
      |  5    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Master3       |PlaceOrder.xlsx |  B2BGT_Order  | CC-Master   |



  @B2BGT_PlaceOrder
  Scenario Outline: B2B GT- PO+CC- Amex- Order-GD Delivery mode
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user         | billToShipToAccountDet  | accountType   |creditCardType | excelName       |  tabName      | paymentType |
      |  6    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Amex3         | PlaceOrder.xlsx |  B2BGT_Order  | CC-Amex     |
      |  7    |B2BGTOrderOne | B2BGT                   | accountType-X | Amex3         |PlaceOrder.xlsx |  B2BGT_Order  | CC-Amex |


  @B2BGT_PlaceOrder
  Scenario Outline: B2B GT- PO+CC- Single promo check
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleMulProduct_1      |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
      | status    |             200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
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
      | order | user         | billToShipToAccountDet  | accountType   |creditCardType | excelName       |  tabName      | paymentType |
      |  8    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Amex3         | PlaceOrder.xlsx |  B2BGT_Order  | CC-Amex     |
      |  9    |B2BGTOrderOne | B2BGT                   | accountType-X | Amex3         |PlaceOrder.xlsx |  B2BGT_Order   | CC-Amex     |


  @B2BGT_PlaceOrder
  Scenario Outline: B2B GT- PO+CC- Multiple promo check
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleMulProduct_1      |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
      | status    |             200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
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
      | order | user         | billToShipToAccountDet  | accountType   |creditCardType | excelName       |  tabName      | paymentType |
      |  10    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Amex3         | PlaceOrder.xlsx |  B2BGT_Order  | CC-Amex     |
      |  11    |B2BGTOrderOne | B2BGT                   | accountType-X | Amex3         |PlaceOrder.xlsx |  B2BGT_Order   | CC-Amex     |

      #with 3Ds enabled
  @B2BGT_PlaceOrder_3DS
  Scenario Outline: B2B GT- PO+CC- Order-GD Delivery mode-with 3d enabled in CC
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for place-order-sce and Order details
    And Store the key and value pairs of order and userId stored in place order hashmap for user <order> and of payment type "<paymentType>"
    And I will store the key and value pairs of "accountBillTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "accountShipTo" in place order hashmap for user <order>
    And I will store the key and value pairs of "deliveryMode" in place order hashmap for user <order>
    And I will store the key and value pairs of "<accountType>" in place order hashmap for user <order>
    And Write the order <order> details stored in hashmap in the excel named "<excelName>" , of tab name "<tabName>" and of payment type "<paymentType>"

    Examples:
      | order | user         | billToShipToAccountDet  | accountType   |creditCardType | excelName      |  tabName      | paymentType |
      |  1    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Visa3         |PlaceOrder.xlsx |  B2BGT_Order  | CC-Visa     |
      |  2    |B2BGTOrderOne | B2BGT                   | accountType-X | Amex4         |PlaceOrder.xlsx |  B2BGT_Order  | CC-Amex     |
      |  3    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Master        |PlaceOrder.xlsx |  B2BGT_Order  | CC-Master   |
      |  4    |B2BGTOrderOne | B2BGT                   | accountType-X | Visa3         |PlaceOrder.xlsx |  B2BGT_Order  | CC-Visa     |
      |  5    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Amex4         |PlaceOrder.xlsx |  B2BGT_Order  | CC-Amex     |
      |  6    |B2BGTOrderOne | B2BGT                   | accountType-X | Master        |PlaceOrder.xlsx |  B2BGT_Order  | CC-Master   |


  @B2BGT_PlaceOrder_3DS
  Scenario Outline: B2B GT- PO+CC- Single promo check-with 3d enabled in CC
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleMulProduct_1      |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
      | status    |             200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
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
      | order | user         | billToShipToAccountDet  | accountType   |creditCardType | excelName       |  tabName      | paymentType |
      |  7    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Amex4         | PlaceOrder.xlsx |  B2BGT_Order  | CC-Amex     |
      |  8    |B2BGTOrderOne | B2BGT                   | accountType-X | Master        |PlaceOrder.xlsx  |  B2BGT_Order   | CC-Master  |
      |  9    |B2BGTOrderOne | B2BGT                   | accountType-X | Visa3         |PlaceOrder.xlsx  |  B2BGT_Order   | CC-Visa   |


  @B2BGT_PlaceOrder_3DS
  Scenario Outline: B2B GT- PO+CC- Multiple promo check-with 3d enabled in CC
    Given I Hit Api to create <user> Token
    When I hit API to create <user> cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in <billToShipToAccountDet> store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt           |
      | Product   | b2bGaleMulProduct_1      |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt  |
      | promoCode | B2BGT_Free_Ship |
      | status    |             200 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO123479       |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters <creditCardType> card details
    When Accept <creditCardType> securit popup
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
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
      | order | user         | billToShipToAccountDet  | accountType   |creditCardType  | excelName        |  tabName      | paymentType  |
      |  10    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Amex4         | PlaceOrder.xlsx |  B2BGT_Order   | CC-Amex     |
      |  11    |B2BGTOrderOne | B2BGT                   | accountType-X | Master        |PlaceOrder.xlsx  |  B2BGT_Order   | CC-Master  |
      |  12    |B2BGTOne_SType| B2BGT_SType             | accountType-S | Visa3         | PlaceOrder.xlsx |  B2BGT_Order   | CC-Visa     |