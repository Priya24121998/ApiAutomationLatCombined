Feature: B2B GT Promo Code Scenarios

  #################################################  Smoke   ################################################################

    #Int
  @B2BGT_Promo_Smoke_Int
  Scenario: [GDC-10383] Verify the promo code discount on cart
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_1 |
      | status    |              200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    And Test Data for GDC-10383 and Cart details


  @B2BGT_Promo_Smoke_Int
  Scenario: [GDC-10467] Verify that user is able to apply multiple promo codes[Item Level/Free Shipping] on a cart & able to place order.
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | FreeShipping_Coupon_Cengage_PromoCodeThree   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | prod-po-test   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Discover2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10467 and Order details

  

  ################################################# Reggression #########################################################
  @B2BGT_Promo_Int
  Scenario: [GDC-10392] Verify that user is able to place an order using Credit card + Promo code.
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_2 |
      | status    |              200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I verify totalDiscounts amount is 0.0
    And I want check total amount is not 0.0
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    Then I verify coupon is applied
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0.0
    And I want check total amount is not 0.0
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-10392 and Order details

 @B2BGT_Promo_Int
  Scenario: [GDC-10381] Verify that user is not able to add invalid promo code using API:
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_1 |
      | status    |              200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt     |
      | promoCode | B2BGTPromo_Invalid |
      | status    |                400 |
    Then I verifies Promocode Error massage
      | Msg | Given promo code is not valid |
    And Test Data for GDC-10381 and Cart details

  @B2BGT_Promo_Int
  Scenario: [GDC-10396] Verify that user is able to remove promo code using API
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |         100112405 |
      | billToAccountNumber |         100112405 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt   |
      | Product   | b2bGaleProduct_4 |
      | status    |              200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    When I try to remove promocode
      | basestore | cengage-b2b-gt |
      | promoCode | B2BGTPromo_2   |
      | status    |            204 |
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I verify totalDiscounts amount is 0.0
    And Test Data for GDC-10396 and Cart details


  @B2BGT_NewDelMode_PromoCode_Int
  Scenario:[GDC-12976] [B2B GT- Delivery mode selected -GD] Verify if we can able to place a B2B Order using 100% promo code
    Given I Hit Api to create B2BGTOne Token
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   |b2bGaleProduct_2     |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | GD                           |
      | status    |                          200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BPromo100         |
      | status    |            200        |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0


  @B2BGT_NewDelMode_PromoCode_Int
  Scenario:[GDC-12976] [B2B GT- Delivery mode selected -GD] Verify if we can able to place a B2B Order using 75%+25% promo code
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   |b2bGaleProduct_2     |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | GD                           |
      | status    |                          200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BPromo75            |
      | status    |            200        |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BGTPromo_5          |
      | status    |            200        |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0



  @B2BGT_NewDelMode_PromoCode_Int
  Scenario:[GDC-12976] [B2B GT- Delivery mode selected -GD] Verify if we can able to place a B2B Order using 75%+25%+Freeshipping promo code
    When I hit API to create B2BGTOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt      |
      | Product   |b2bGaleProduct_2     |
      | status    |            200      |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | GD                           |
      | status    |                          200 |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BPromo75            |
      | status    |            200        |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BGTPromo_5          |
      | status    |            200        |
    When I try to apply promocode
      | basestore | cengage-b2b-gt        |
      | promoCode | B2BGTPromo_4          |
      | status    |            200        |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    When I hit get order details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0

    
    
    

