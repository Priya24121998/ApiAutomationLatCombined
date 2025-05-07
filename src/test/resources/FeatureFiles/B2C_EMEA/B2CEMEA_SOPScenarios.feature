Feature: B2C EMEA SOP Scenarios

  @B2C_EMEA_SOP
  Scenario: [GDC-662] Verify user get the response of Payment details of the cart through Sop response API.
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-emea |
      | cartId     | Valid            |
      | status     |              200 |
    Then I verify SOP api response
      | cardType       | visa           |
      | expiryYear     |           2026 |
      | subscriptionId | subscriptionId |
      | billingAddress | London         |
    And Test Data for GDC-662 and Cart details
    
    
    @B2C_EMEA_SOP
  Scenario: [GDC-10481] [B2C] Verify that Reason code '201' appears in the SOP response API and Place Order API when the user has added an invalid credit card number while adding payment details using the CyberSource URL. 
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_1    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-emea |
      | cartId     | Valid            |
      | status     |              400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-10481 and Cart details
    
  #----------------------------------------Removed code
  #@Emea_Smoke
  #Scenario: [GDC-12834] [B2C EMEA] Verify that API should returns '400' status code in SOP response API response with error message if skipping the CyberSource details.
    #Given I Hit Api to create B2CEMEA Token
    #Given I hit API to create B2CEMEA user
    #When I hit API to create B2CEMEA cart
      #| basestore | cengage-b2c-emea |
      #| status    |              201 |
    #And User add B2C products to cart
      #| basestore | cengage-b2c-emea |
      #| Product   | emeaProduct_1    |
      #| status    |              200 |
    #When User adds delivery address to cart
      #| basestore | cengage-b2c-emea |
      #| address   | emea_address     |
      #| status    |              201 |
    #And User adds billing address to cart
      #| basestore | cengage-b2c-emea |
      #| address   | emea_address     |
      #| status    |              201 |
    #When User puts delivery mode
      #| basestore | cengage-b2c-emea               |
      #| mode      | EMEA_Express_Shipping_Domestic |
      #| status    |                            200 |
    #And I Hit SOP Response API
      #| baseSiteId | cengage-b2c-emea |
      #| cartId     | Valid          |
      #| status     |            400 |
    #Then I verify following details in API response
      #| errors[0].message | PaymentInfo [CC Payment info is empty] is invalid for the current cart |
    #And Test Data for GDC-12834 and Cart details
