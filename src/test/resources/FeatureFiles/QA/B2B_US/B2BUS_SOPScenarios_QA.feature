Feature: B2B US SOP  Scenarios

  @B2B_SOP_QA
  Scenario: [GDC-10188] Verify that user is able to get SOP response details using API:
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
      And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD|
      | status    |                          200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I wait for 10 sec
    And I Hit SOP Response API
      | baseSiteId | cengage-b2b-us |
      | cartId     | Valid          |
      | status     |            200 |
    Then I verify following details in API response
      | cardType       | visa     |
      | expiryYear     | 2026     |
      | subscriptionId | not zero |
      | billingAddress | not null |
    And Test Data for GDC-10188 and Cart details

  @B2B_SOP_QA
  Scenario: [GDC-12827] [B2B US] Verify that API should return the '400' status code in the SOP response API response with an error message if gets an error in CyberSource..
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
      And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD|
      | status    |                          200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2b-us |
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2b-us |
      | cartId     | Valid          |
      | status     |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    Then User place order for B2C cart
      | basestore | cengage-b2b-us |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-12827 and Cart details
    
  #----------------------------Removed code---------------------------------- 
  #@B2B_SOP_Int_Smoke
  #Scenario: [GDC-12826] Verify that the API should return the '400' status code in the SOP response API response with an error message if skipping the CyberSource details.
    #Given I Hit Api to create B2BUS Token
    #When I hit API to create B2B cart
      #| basestore | cengage-b2b-us |
      #| status    |            201 |
    #And User set bill to ship to account number
#			| basestore           | cengage-b2b-us |
      #| shipToAccountNumber |        100114420 |
      #| billToAccountNumber |        100114420 |
      #| status              |            202 |
    #And User add B2B products to cart
      #| basestore | cengage-b2b-us   |
      #| Product   | b2busproduct5 |
      #| status    |              200 |
   #When I hit API to Set  delivery modes
      #| basestore | cengage-b2b-us               |
      #| code      | GD|
      #| status    |                          200 |
    #And I Hit SOP Response API
      #| baseSiteId | cengage-b2b-us |
      #| cartId     | Valid          |
      #| status     |            400 |
    #Then I verify following details in API response
      #| errors[0].message | PaymentInfo [CC Payment info is empty] is invalid for the current cart |
    #And Test Data for GDC-12826 and Cart details
    

 