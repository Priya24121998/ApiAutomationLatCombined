Feature: B2B CA New Delivery Mode Scenarios
 #################################################  Smoke and Regression  ###########################################################
  #New
  @B2BCA_NewDelMode_Smoke_QA @B2BCA_NewDelMode_Reg_QA
  Scenario: [GDC-12960] [B2B CA- Delivery mode selected -GD] Verify if we can able to place a B2B Order by adding product to cart using Purchase order scenario
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
    And I put PO number details using API
      | basestore | cengage-b2b-ca |
      | PONumber  | PO123479       |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    And I wait for 30 sec
    And Test Data for GDC-12960 and Order details


