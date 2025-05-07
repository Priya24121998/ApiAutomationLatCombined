Feature: B2C CA Order Scenarios

  #################################################  Smoke   ################################################################
  Background:
    Given I will read data in the tab "B2C_CA" of the excel named "B2C_PlaceOrder_Input.xlsx"

  @B2C_CA_PlaceOrder_UsingExcelInput
   Scenario Outline: B2B CA - Place Order - Paypal - No promo code
     Given I Hit Api to create B2CCA Token
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
       | basestore | <baseStore> |
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
     |5     |placeOrder.yaml| cengage-b2c-ca | CA_address | standard-ca  |

  @B2C_CA_PlaceOrder_UsingExcelInput
  Scenario Outline: Place Order - CC Order -Discover,Visa,Master - No promo code
    Given I Hit Api to create B2CCA Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore> |
      | address   | <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>    |
      | address   | <address>      |
      | status    |            201 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>    |
      | mode      | <deliveryMode> |
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
      |order | creditCard | yamlFileName   |baseStore      |address    |deliveryMode |
      |1     | Visa       |placeOrder.yaml |cengage-b2c-ca |CA_address |standard-ca  |
      |3     | Master3    |placeOrder.yaml |cengage-b2c-ca |CA_address |standard-ca  |
      |4     | Discover   |placeOrder.yaml |cengage-b2c-ca |CA_address |standard-ca |

  @B2C_CA_PlaceOrder_UsingExcelInput
  Scenario Outline: Place Order - CC Order -Amex  - No promo code
    Given I Hit Api to create B2CCA Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>    |
      | address   | <address>      |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>    |
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
      |order | creditCardType | yamlFileName   | baseStore      |address    | deliveryMode |
      |2     | Amex3          |placeOrder.yaml | cengage-b2c-ca |CA_address |standard-ca  |



  @B2C_CA_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2B CA - Place Order - Paypal - with 50% promo code
    Given I Hit Api to create B2CCA Token
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
    And I navigate to paypal new url for B2C stores using GUID
      | basestore | <baseStore>   |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I should able to place B2C order using new Paypal workflow using UserGuid
      | basestore | <baseStore>    |
      | status    |            200 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order  | yamlFileName  | baseStore      | address      | promoCode | deliveryMode|
      |8      |placeOrder.yaml| cengage-b2c-ca | CA_address   | B2CCA_50  |standard-ca  |

  @B2C_CA_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: B2B CA - Place Order -with 100% promo code
    Given I Hit Api to create B2CCA Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore>    |
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
      | status        |            200 |
     Then I will verify B2C coupon is applied by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    And I wait for 10 sec
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And Test Data for GDC-9967 and order details
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order  | yamlFileName  | baseStore      | address      | promoCode | deliveryMode |
      |2      |placeOrder.yaml| cengage-b2c-ca  | CA_address   | B2CCA_100 |standard-ca  |


  @B2C_CA_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: Place Order - CC Order -Discover,Visa,Master - with 50% promo code
    Given I Hit Api to create B2CCA Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore> |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore> |
      | address   | <address>     |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>    |
      | address   | <address>      |
      | status    |            201 |
    When I will try to apply vouchers by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    Then I will verify B2C coupon is applied by passing UserGuid
      | basestore | <baseStore>    |
      | voucherID | <promoCode>    |
      | status    |            200 |
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>    |
      | mode      | <deliveryMode> |
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
      |order | creditCard | yamlFileName   |baseStore      |address    |deliveryMode |promoCode |
      |6     | Visa       |placeOrder.yaml |cengage-b2c-ca |CA_address |standard-ca  |B2CCA_50  |
      |8     | Master3    |placeOrder.yaml |cengage-b2c-ca |CA_address |standard-ca  |B2CCA_50  |
      |9     | Discover   |placeOrder.yaml |cengage-b2c-ca |CA_address |standard-ca |B2CCA_50  |

  @B2C_CA_PlaceOrder_WithPromoCode_UsingExcelInput
  Scenario Outline: Place Order - CC Order -Amex  - with 50% promo code
    Given I Hit Api to create B2CCA Token
    When I hit API to create user cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            201 |
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds billing address to cart by passing userGuid
      | basestore | <baseStore>    |
      | address   | <address>      |
      | status    |            201 |
    And User adds delivery address to cart by passing userGuid
      | basestore | <baseStore>    |
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
      |order | creditCardType | yamlFileName   | baseStore      |address    | deliveryMode |promoCode |
      |7     | Amex3          |placeOrder.yaml | cengage-b2c-ca |CA_address |standard-ca   |B2CCA_50  |

