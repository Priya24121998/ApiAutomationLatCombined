Feature: B2C EMEA Order Scenarios

  Background:
    Given I will read data in the tab "B2C_EMEA" of the excel named "B2C_PlaceOrder_Input.xlsx"

  @B2C_EMEA_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C EMEA - Place Order - Paypal - No promo code
    Given I Hit Api to create B2CEMEA Token
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
      |order | yamlFileName  | baseStore        | address      | deliveryMode                   |
      |1     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic |


  @B2C_EMEA_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C EMEA - Place Order - CC-Visa,Master - No promo code
    Given I Hit Api to create B2CEMEA Token
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
      |order | yamlFileName  | baseStore        | address      | deliveryMode |creditCard   |
      |7     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic | Master3    |
      |2     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic | Master3    |


  @B2C_EMEA_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C EMEA - Place Order - CC-Visa- No promo code
    Given I Hit Api to create B2CEMEA Token
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
      |order | yamlFileName  | baseStore        | address      | deliveryMode |creditCard   |
      |8     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic | Visa       |
      |3     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic |    Visa    |

  @B2C_EMEA_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C EMEA - Place Order - CC-Visa,Master - No promo code
    Given I Hit Api to create B2CEMEA Token
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
      |order | yamlFileName  | baseStore        | address      | deliveryMode |creditCardType   |
      |4     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic |Amex3           |


  @B2C_EMEA_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C EMEA - Place Order - 30% promo code
    Given I Hit Api to create B2CEMEA Token
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
      |order | yamlFileName  | baseStore      | address    | deliveryMode       |promoCode    |creditCardType |
      |4     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic  | B2CEMEA_30  | Amex3         |



  @B2C_EMEA_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C EMEA - Place Order - 100% promo code
    Given I Hit Api to create B2CEMEA Token
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
      |order | yamlFileName  | baseStore        | address      | deliveryMode                      |promoCode    |
      |4     |placeOrder.yaml| cengage-b2c-emea | emea_address | EMEA_Express_Shipping_Domestic  | B2CEMEA_100  |

