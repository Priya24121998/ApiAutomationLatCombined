Feature: B2B US New Delivery Mode Scenarios

  #PO+Credit card
  #################################################   Smoke and Regression   ################################################################

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Smoke @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12957][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Smoke @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12963][B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Smoke @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12972] [B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Smoke @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12969][B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |

     #################################################   Regression   ################################################################
  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12958][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | promoCode | CENGAGE001_Coupon     |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12962][B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | promoCode | FreeShipping_Coupon_Cengage_PromoCodeFour     |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12971][B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | basestore | cengage-b2b-us |
      | promoCode | FreeShipping_Coupon_Cengage_PromoCodeThree     |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12968][B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order using Purchase order+ credit card scenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | basestore | cengage-b2b-us |
      | promoCode | FreeShipping_Coupon_Cengage_PromoCodeThree     |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario: [GDC-12959][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3     |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |


  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12961] [B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3     |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario: [GDC-12970][B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3      |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |   0     |


  @sapecomm-12379-us @sapecomm-12379 @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12967] [B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order+ credit card scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3      |
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0     |

    #Purchase order
  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12990][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12991][B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12992] [B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12993][B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12994][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order using Purchase order scenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | promoCode | CENGAGE001_Coupon     |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12995][B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order using Purchase orderscenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | promoCode | FreeShipping_Coupon_Cengage_PromoCodeFour     |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12996][B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order using Purchase order scenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | basestore | cengage-b2b-us |
      | promoCode | FreeShipping_Coupon_Cengage_PromoCodeThree     |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12997][B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order using Purchase order scenario using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
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
      | basestore | cengage-b2b-us |
      | promoCode | FreeShipping_Coupon_Cengage_PromoCodeThree     |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario: [GDC-12998][B2B US- Delivery mode selected -GD] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3     |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   GD     |
      | deliveryMode.deliveryCost.value      |   0     |


  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-12999] [B2B US- Delivery mode selected -MS] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3     |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   MS     |
      | deliveryMode.deliveryCost.value      |   0     |

  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario: [GDC-13000][B2B US- Delivery mode selected -2D] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3      |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   2D     |
      | deliveryMode.deliveryCost.value      |   0     |


  @sapecomm-12379-us @sapecomm-12379 @B2BUS_PO_SCE @B2BUS_NewDelMode_Reg
  Scenario:[GDC-13001] [B2B US- Delivery mode selected -1D] Verify if we can able to place a B2B Order by adding multiple products to cart using Purchase order scenario without using promo code- WITH TAX AND NO SHIPPING COST
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us      |
      | Product   |b2bMulQuantity_3      |
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
      | deliveryMode.deliveryCost.value      |   0     |
    When I hit get order details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | deliveryMode.code       |   1D     |
      | deliveryMode.deliveryCost.value      |   0     |











