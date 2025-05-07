Feature: B2B GT New Delivery Mode Scenarios

  #################################################  Smoke and Regression   ################################################################

  @sapecomm-12379-gt-qa @B2BGT_NewDelMode_Smoke_QA @B2BGT_NewDelMode_Reg_QA
  Scenario:[GDC-12973][B2B GT- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   |b2bgtproductDel      |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | GD                           |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |

      #################################################   Regression   ################################################################
  @sapecomm-12379-gt-qa @B2BGT_NewDelMode_Reg_QA
  Scenario:[GDC-12975][B2B GT- Delivery mode selected -GD] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   |b2bGaleMulProduct_4  |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | GD                           |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-gt-qa @B2BGT_NewDelMode_Reg_QA
  Scenario:[GDC-12974] [B2B GT- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario using promo code- WITH TAX
    Given I Hit Api to create B2BGTTwo Token
    When I hit API to create B2BGTTwo cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BGTTwo store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   |b2bGaleMulProduct_5  |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | GD                           |
      | status    |                          200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode |    B2BGTPromo_4       |
      | status    |            200        |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0.0   |
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          |  not zero|
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |  0.0  |


  @sapecomm-12379-gt-qa @B2BGT_NewDelMode_Reg_QA
  Scenario:[GDC-12976] [B2B GT- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario using mutliple promo code- WITH TAX
    Given I Hit Api to create B2BGTTwo Token
    When I hit API to create B2BGTTwo cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BGTTwo store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   |b2bGaleMulProduct_5  |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | GD                           |
      | status    |                          200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BUSPromoNew         |
      | status    |            200        |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BGT_Free_Ship       |
      | status    |            200        |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |



