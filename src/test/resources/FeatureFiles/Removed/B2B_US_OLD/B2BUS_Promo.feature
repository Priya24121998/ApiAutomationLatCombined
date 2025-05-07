Feature: B2B US Promo Code Scenarios

  #################################################  Smoke   ################################################################
  @B2B_Promo_Smoke
  Scenario: [GDC-9925] Verify that user is able to place order using PO number on discounted amount using promo code [Free shipping]
    Given I Hit Api to create B2BUSTax Token
    When I hit API to create B2BUSTax cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4220902 |
      | billToAccountNumber |        4220902 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct8  |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | totalDiscounts.value    | 0.0      |
    When I want to apply B2B coupon
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | totalDiscounts.value    | not zero |
      | deliveryMode.deliveryCost.value      |   0     |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |

  @B2B_Promo_Smoke
  Scenario: [GDC-9927] Verify that user is able to place order using CC(Discover) on discounted amount using promo code
    Given I Hit Api to create B2BUSTax Token
    When I hit API to create B2BUSTax cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4220902 |
      | billToAccountNumber |        4220902 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct8  |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | totalDiscounts.value    | 0.0      |
    When I want to apply B2B coupon
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value        | not zero |
      | totalPriceWithTax.value | not zero |
      | totalTax.value          | not zero |
      | totalDiscounts.value    | not zero |
      | deliveryMode.deliveryCost.value      |   0     |
    And I put PO number details using API
      | basestore | cengage-b2b-us |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Discover card details
    Then User verifies ACCEPT message
    Then User place order for B2B cart
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And Test Data for GDC-9927 and Order details

  #################################################  Old Reggression   ###########################################################
  #Scenario: [SAPECOMM-8481] Verify the promo code discount on cart
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        4199993 |
  #| billToAccountNumber |        4199993 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2busproduct4  |
  #| status    |            200 |
  #When I try to apply promocode
  #| basestore | cengage-b2b-us |
  #| promoCode | MASTERED50     |
  #| status    |            200 |
  #When I hit get cart details API
  #| basestore | cengage-b2b-us |
  #| status    |            200 |
  #And I verify totalDiscounts amount is 28.48
  #And Test Data for SAPECOMM-8481 and Cart details
  #
  #
  #Scenario: [SAPECOMM-8575] Verify that user is not able to add invalid promo code using API:
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2bUsProduct   |
  #| status    |            200 |
  #When I try to apply promocode
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE301      |
  #| status    |            400 |
  #Then I verifies Promocode Error massage
  #| Msg | Given promo code is not valid |
  #And Test Data for SAPECOMM-8575 and Cart details
  #
  #
  #Scenario: [SAPECOMM-8489] Verify that user is able to remove promo code using API
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        4199993 |
  #| billToAccountNumber |        4199993 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2busproduct3  |
  #| status    |            200 |
  #When I try to apply promocode
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            200 |
  #Then I verify coupon is applied
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            200 |
  #When I try to remove promocode
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            204 |
  #Then I verify coupon is Removed
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            200 |
  #And Test Data for SAPECOMM-8489 and Cart details
  #
  #
  #Scenario: [SAPECOMM-8650] Verify that user is able to apply/remove promo code for multiple products cart using API
  #Given I Hit Api to create B2BUS Token
  #When I hit API to create B2B cart
  #| basestore | cengage-b2b-us |
  #| status    |            201 |
  #And User set bill to ship to account number
  #| basestore           | cengage-b2b-us |
  #| shipToAccountNumber |        4199993 |
  #| billToAccountNumber |        4199993 |
  #| status              |            202 |
  #And User add B2B products to cart
  #| basestore | cengage-b2b-us |
  #| Product   | b2bUsProduct   |
  #| status    |            200 |
  #When I try to apply promocode
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            200 |
  #Then I verify coupon is applied
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            200 |
  #When I try to remove promocode
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            204 |
  #Then I verify coupon is Removed
  #| basestore | cengage-b2b-us |
  #| promoCode | CRSAVE30       |
  #| status    |            200 |
  #And Test Data for SAPECOMM-8650 and Cart details
  ## #################################################				QA				##############################################
  @B2B_Promo
  Scenario: [GDC-10176] Verify the promo code discount on cart
    Given I Hit Api to create B2BUS Token
    When I hit API to create B2B cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4199993 |
      | billToAccountNumber |        4199993 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct8  |
      | status    |            200 |
    When I want to apply B2B coupon
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I verify totalDiscounts amount is 8.74
    And Test Data for GDC-10176 and Cart details

  @B2B_Promo
  Scenario: [GDC-10171] Verify that user is not able to add invalid promo code using API:
    Given I Hit Api to create B2BUS Token
    When I hit API to create B2B cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-us |
      | promoCode | Invalid_Promo  |
      | status    |            400 |
    Then I verifies Promocode Error massage
      | Msg | Given promo code is not valid |
    And Test Data for GDC-10171 and Cart details

  @B2B_Promo
  Scenario: [GDC-10186] Verify that user is able to remove promo code using API
    Given I Hit Api to create B2BUS Token
    When I hit API to create B2B cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4199993 |
      | billToAccountNumber |        4199993 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct8  |
      | status    |            200 |
    When I want to apply B2B coupon
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    When I Want to remove b2b promocode
      | basestore | cengage-b2b-us |
      | status    |            204 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I verify totalDiscounts amount is 0.0
    And Test Data for GDC-10186 and Cart details

  @B2B_Promo
  Scenario: [GDC-10193] Verify that user is able to apply/remove promo code for multiple products cart using API
    Given I Hit Api to create B2BUS Token
    When I hit API to create B2B cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4199993 |
      | billToAccountNumber |        4199993 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct8  |
      | status    |            200 |
    When I want to apply B2B coupon
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0
    When I Want to remove b2b promocode
      | basestore | cengage-b2b-us |
      | status    |            204 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I verify totalDiscounts amount is 0.0
    And Test Data for GDC-10193 and Cart details

  @B2B_Order
  Scenario: [GDC-10463] Verify that delivery cost for Other - Fill out Special Shipping Instructions is getting calculated after removing the free shipping promo.
    Given I Hit Api to create B2BUS Token
    When I hit API to create B2B cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | B2B_US_Phy_02  |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4199993 |
      | billToAccountNumber |        4199993 |
      | status              |            202 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us                                 |
      | code      | Other - Fill out Special Shipping Instructions |
      | status    |                                            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems         |                                              1 |
      | subTotal.value     |                                         115.95 |
      | deliveryMode.code  | Other - Fill out Special Shipping Instructions |
      | deliveryCost.value |                                          15.57 |
      | paymentType.code   | CARD                                           |
      | orderType          | REGULAR                                        |
    When I try to apply promocode
      | basestore | cengage-b2b-us     |
      | promoCode | B2BUS_FreeShipping |
      | status    |                200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems         |                                              1 |
      | subTotal.value     |                                         115.95 |
      | deliveryMode.code  | Other - Fill out Special Shipping Instructions |
      | deliveryCost.value |                                              0 |
      | paymentType.code   | CARD                                           |
      | orderType          | REGULAR                                        |
    When I try to remove promocode
      | basestore | cengage-b2b-us     |
      | promoCode | B2BUS_FreeShipping |
      | status    |                204 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems         |                                              1 |
      | subTotal.value     |                                         115.95 |
      | deliveryMode.code  | Other - Fill out Special Shipping Instructions |
      | deliveryCost.value |                                          15.57 |
      | paymentType.code   | CARD                                           |
      | orderType          | REGULAR                                        |
    And Test Data for GDC-10463 and Cart details

  @B2B_Order
  Scenario: [GDC-10462] Verify that delivery cost for 'Use preferred ground shipper' is getting calcuated after removing the free shipping promo.
    Given I Hit Api to create B2BUS Token
    When I hit API to create B2B cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | B2B_US_Phy_02  |
      | status    |            200 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us |
      | shipToAccountNumber |        4199993 |
      | billToAccountNumber |        4199993 |
      | status              |            202 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | Use preferred ground shipper |
      | status    |                          200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems         |                            1 |
      | subTotal.value     |                       115.95 |
      | deliveryMode.code  | Use preferred ground shipper |
      | deliveryCost.value |                        15.57 |
      | paymentType.code   | CARD                         |
      | orderType          | REGULAR                      |
    When I try to apply promocode
      | basestore | cengage-b2b-us     |
      | promoCode | B2BUS_FreeShipping |
      | status    |                200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems         |                            1 |
      | subTotal.value     |                       115.95 |
      | deliveryMode.code  | Use preferred ground shipper |
      | deliveryCost.value |                            0 |
      | paymentType.code   | CARD                         |
      | orderType          | REGULAR                      |
    When I try to remove promocode
      | basestore | cengage-b2b-us     |
      | promoCode | B2BUS_FreeShipping |
      | status    |                204 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems         |                            1 |
      | subTotal.value     |                       115.95 |
      | deliveryMode.code  | Use preferred ground shipper |
      | deliveryCost.value |                        15.57 |
      | paymentType.code   | CARD                         |
      | orderType          | REGULAR                      |
    And Test Data for GDC-10462 and Cart details

