Feature: B2B CA Order Scenarios

  #################################################  Smoke   ################################################################
  #################################################  Reggression   ###########################################################
  #New
  @B2BCA_Order_QA
  Scenario: [GDC-1001] Verify OCC API: orders throws error with cartId which does not have payment details
    Given I Hit Api to create B2BCANew Token
    When I hit API to create B2BCANew cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BCA store
      | basestore           | cengage-b2b-ca |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca           |
      | Product   | b2bca_Product_ErpPhase   |
      | status    |            200           |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | GD             |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-1001 and Cart details

