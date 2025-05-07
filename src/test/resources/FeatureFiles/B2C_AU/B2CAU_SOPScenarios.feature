Feature: B2C AU SOP Scenarios

  @B2C_AU_SOP
  Scenario: [GDC-10243] Verify that user is able to get SOP response details using API:
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-au |
      | cartId     | Valid          |
      | status     |            200 |
    Then I verify SOP api response
      | cardType       | visa            |
      | expiryYear     |            2026 |
      | subscriptionId | subscriptionId  |
      | billingAddress | New South Wales |
    And Test Data for GDC-10243 and Cart details

  @B2C_AU_SOP
  Scenario: [GDC-10481] [B2C] Verify that Reason code '201' appears in the SOP response API and Place Order API when the user has added an invalid credit card number while adding payment details using the CyberSource URL.
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-au |
      | cartId     | Valid          |
      | status     |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-au |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-10481 and Cart details
    
  @B2C_AU_SOP_Smoke
  Scenario: [GDC-10232] Verify that user is able to get SOP request details using API:
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Request API
      | baseSiteId | cengage-b2c-au |
      | cartId     | Valid            |
      | status     |                200 |
    Then I verify SOP api Request
    And Test Data for GDC-10232 and Cart details
    
    
   #---------------------------------Removed code-------------------------
  #@B2C_AU_SOP_Smoke
  #Scenario: [GDC-12834] [B2C AU] Verify that API should returns '400' status code in SOP response API response with error message if skipping the CyberSource details.
    #Given I Hit Api to create B2CAU Token
    #Given I hit API to create B2CAU user
    #When I hit API to create B2CAU cart
      #| basestore | cengage-b2c-au |
      #| status    |            201 |
    #And User add B2C products to cart
      #| basestore | cengage-b2c-au |
      #| Product   | b2cProduct_1   |
      #| status    |            200 |
    #When User adds delivery address to cart
      #| basestore | cengage-b2c-au |
      #| address   | AU_address     |
      #| status    |            201 |
    #And User adds billing address to cart
      #| basestore | cengage-b2c-au |
      #| address   | AU_address     |
      #| status    |            201 |
    #Then User gets all delivery modes
      #| basestore | cengage-b2c-au |
      #| status    |            200 |
    #When User puts delivery mode
      #| basestore | cengage-b2c-au |
      #| mode      | standard-au    |
      #| status    |            200 |
    #And I Hit SOP Response API
      #| baseSiteId | cengage-b2c-au |
      #| cartId     | Valid          |
      #| status     |            400 |
    #Then I verify following details in API response
      #| errors[0].message | PaymentInfo [CC Payment info is empty] is invalid for the current cart |
    #And Test Data for GDC-12834 and Cart details