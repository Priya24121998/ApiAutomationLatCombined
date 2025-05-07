Feature: B2B US New Delivery Mode Scenarios
  
  #################################################   Smoke and Regression   ################################################################
  
    #Purchase order
 @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12990][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductDel      |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
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

 @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12991][B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductDel      |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | MS                           |
      | status    |                          200 |
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

 @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12992] [B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductDel      |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | 2D                           |
      | status    |                          200 |
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

  @sapecomm-12379-us-qa @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12993][B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductDel      |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | 1D                           |
      | status    |                          200 |
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

  @sapecomm-12379-us-qa @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12994][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order scenario using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductDel      |
      | status    |            200      |
    When I try to apply promocode
      | basestore | cengage-b2b-us        |
      | promoCode | B2BUSPromoNew     |
      | status    |            200        |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0.0   |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0.0    |

  @sapecomm-12379-us-qa @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12995][B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order using Purchase orderscenario using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductDel      |
      | status    |            200      |
    When I try to apply promocode
      | basestore | cengage-b2b-us                                |
      | promoCode | B2BUSPromoNew                                 |
      | status    |            200                                |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | MS                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0.0      |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0.0     |

  @sapecomm-12379-us-qa @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12996][B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order using Purchase order scenario using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductErp      |
      | status    |            200      |
    When I try to apply promocode
      | basestore | cengage-b2b-us |
      | promoCode | B2BUSPromoNew     |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | 2D                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |   0.0      |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |    0.0     |

 @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12997][B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order using Purchase order scenario using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2busproductErp      |
      | status    |            200      |
    When I try to apply promocode
      | basestore | cengage-b2b-us |
      | promoCode | B2BUSPromo     |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | 1D                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |    0.0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0.0    |

  @sapecomm-12379-us-qa @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario: [GDC-12998][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_4     |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value    |    0.0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value    |   0.0      |


 @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-12999] [B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_4     |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | MS                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |    0.0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0.0      |

 @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario: [GDC-13000][B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_4      |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | 2D                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |  0.0      |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |    0.0     |


 @B2BUS_PO_SCE_PERF @B2BUS_NewDelMode_Reg_Perf
  Scenario:[GDC-13001] [B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code
    Given I Hit Api to create B2BUSNewPO Token
    When I hit API to create B2BUSNewPO cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_4      |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | 1D                           |
      | status    |                          200 |
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
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |  0.0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0.0    |











