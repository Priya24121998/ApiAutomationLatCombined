Feature: B2C NZ Order Scenarios

  Background:
    Given I will read data in the tab "B2C_NZ" of the excel named "B2C_PlaceOrder_Input.xlsx"

  @B2C_NZ_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C NZ - Place Order - CC-Visa,Master - No promo code
    Given I Hit Api to create B2CNZ Token
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
      |order | yamlFileName  | baseStore      | address    | deliveryMode | creditCard |
      |1     |placeOrder.yaml| cengage-b2c-nz | NZ_address  | standard-nz  | Visa      |
      |2     |placeOrder.yaml| cengage-b2c-nz | NZ_address  | standard-nz  | Master3   |


  @B2C_NZ_PlaceOrder_UsingExcelInput
  Scenario Outline: B2C NZ - Place Order - CC-Amex - No promo code
    Given I Hit Api to create B2CNZ Token
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
      |order | yamlFileName  | baseStore      | address    | deliveryMode | creditCardType |
      |3    |placeOrder.yaml| cengage-b2c-nz | NZ_address  | standard-nz  | Amex3         |
      |4     |placeOrder.yaml| cengage-b2c-nz | NZ_address  | standard-nz  | Amex3         |

  @B2C_NZ_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C NZ - Place Order - 100% promo code
    Given I Hit Api to create B2CNZ Token
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
      |order | yamlFileName  | baseStore      | address    | deliveryMode |promoCode  |
      |5     |placeOrder.yaml| cengage-b2c-nz | NZ_address | standard-nz  | B2CNZ_100 |


  @B2C_NZ_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C NZ - Place Order - 50% promo code + CC Order
    Given I Hit Api to create B2CNZ Token
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
    And User Enters <creditCard> card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore      | address    | deliveryMode |promoCode  | creditCard |
      |6     |placeOrder.yaml| cengage-b2c-nz | NZ_address | standard-nz  | B2CNZ_50  | Visa       |
      |6     |placeOrder.yaml| cengage-b2c-nz | NZ_address | standard-nz  | B2CNZ_50  | Master     |

  @B2C_NZ_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2C NZ - Place Order - 50% promo code + CC Order - Amex
    Given I Hit Api to create B2CNZ Token
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
      |order | yamlFileName  | baseStore      | address    | deliveryMode |promoCode  | creditCardType |
      |6     |placeOrder.yaml| cengage-b2c-nz | NZ_address | standard-nz  | B2CNZ_50  | Amex3          |

