Feature: B2C AU Order Scenarios

  #################################################  Smoke   ################################################################@B2C_AU_PlaceOrder_UsingExcelInput
 Background:
   Given I will read data in the tab "B2C_AU" of the excel named "B2C_PlaceOrder_Input.xlsx"


  @B2C_AU_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C AU - Place Order - Paypal - No promo code
    Given I Hit Api to create B2CAU Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   |  <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   | <address>      |
      | status    |            201 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I navigate to paypal new url for B2C stores using GUID
      | basestore | <baseStore>    |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I should able to place B2C order using new Paypal workflow using UserGuid
      | basestore | <baseStore> |
      | status    |            200 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode |
      |1     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au  |

  @B2C_AU_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C AU - Place Order - CC-Visa,Master - No promo code
    Given I Hit Api to create B2CAU Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   |  <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   | <address>      |
      | status    |            201 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    And User Enters <creditCard> card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode |creditCard   |
      |2     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au  | Visa        |
      |3     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au  | Master3     |


  @B2C_AU_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C AU - Place Order - CC-Amex - No promo code
    Given I Hit Api to create B2CAU Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   |  <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   | <address>      |
      | status    |            201 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode |creditCardType   |
      |4     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au  | Amex3           |


  @B2C_AU_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C AU - Place Order - Paypal - with promo code
    Given I Hit Api to create B2CAU Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>    |
      | address   |  <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>    |
      | address   | <address>      |
      | status    |            201 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    When I will try to apply vouchers by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    Then I will verify B2C coupon is applied by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    And I navigate to paypal new url for B2C stores using GUID
      | basestore | <baseStore>    |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I should able to place B2C order using new Paypal workflow using UserGuid
      | basestore | <baseStore> |
      | status    |            200 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode | promoCode |
      |4     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au  |B2CAU_50   |

  @B2C_AU_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C AU - Place Order - CC-Visa,Master -  with promo code
    Given I Hit Api to create B2CAU Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   |  <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   | <address>      |
      | status    |            201 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    When I will try to apply vouchers by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status        |            200 |
    Then I will verify B2C coupon is applied by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    And User Enters <creditCard> card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode |creditCard   |promoCode |
      |5     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au  | Master3     |B2CAU_50  |



  @B2C_AU_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C AU - Place Order - CC-Amex -  with promo code
    Given I Hit Api to create B2CAU Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   |  <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   | <address>      |
      | status    |            201 |
    When I will try to apply vouchers by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status        |            200 |
    Then I will verify B2C coupon is applied by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode |creditCardType   |promoCode |
      |4     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au  | Amex3           | B2CAU_50 |


  @B2C_AU_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C AU - Place Order -  with 100 % promo code
    Given I Hit Api to create B2CAU Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   |  <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>  |
      | address   | <address>      |
      | status    |            201 |
    When I will try to apply vouchers by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status        |            200 |
    Then I will verify B2C coupon is applied by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode    |promoCode  |
      |5     |placeOrder.yaml| cengage-b2c-au | AU_address | standard-au     | B2CAU_100 |
