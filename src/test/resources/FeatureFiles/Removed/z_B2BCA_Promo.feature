Feature: B2B CA Promo Code Scenarios

  #################################################  Smoke   ################################################################
  #New  #Smoke
  Scenario: [GDC-1118] B2B: Verify that API successfully removes promotion from customers cart
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84002336 |
      | billToAccountNumber |       84002335 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I want to apply B2B coupon
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0.0
    When I Want to remove b2b promocode
      | basestore | cengage-b2b-ca |
      | status    |            204 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I verify totalDiscounts amount is 0.0
    And Test Data for GDC-1118 and Cart details

  #New  #Smoke
  Scenario: [GDC-1065] Verify the highest discount promocode replaced the other promocode in the cart
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84002336 |
      | billToAccountNumber |       84002335 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-ca |
      | promoCode | USDISCFRSB2B   |
      | status    |            200 |
    Then I verify coupon is applied
      | basestore | cengage-b2b-ca |
      | promoCode | USDISCFRSB2B   |
      | status    |            200 |
    When I try to apply promocode
      | basestore | cengage-b2b-ca |
      | promoCode | USB2BCUST23    |
      | status    |            200 |
    Then I verify coupon is applied
      | basestore | cengage-b2b-ca |
      | promoCode | USB2BCUST23    |
    Then I verify coupon is Removed
      | basestore | cengage-b2b-ca |
      | promoCode | USDISCFRSB2B   |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0.0
    And Test Data for GDC-1065 and Cart details

  #################################################  Reggression   ###########################################################
  #New
  Scenario: [GDC-554] Verify the API response after promotion is applied under the GET API: /{baseSiteId}/users/{userId}/carts
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84002336 |
      | billToAccountNumber |       84002335 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I want to apply B2B coupon
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I want to check totalDiscounts amount is not 0.0
    Then I verify coupon is applied
      | basestore | cengage-b2b-ca |
      | promoCode | USDISCFRSB2B   |
      | status    |            200 |
    And Test Data for GDC-554 and Cart details
