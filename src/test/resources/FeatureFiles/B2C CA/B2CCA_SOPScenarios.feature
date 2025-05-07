Feature: B2C CA SOP Scenarios

  @B2C_CA_SOP
  Scenario: [GDC-10271] Verify that user is able to get SOP response details using API:
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-ca |
      | cartId     | Valid          |
      | status     |            200 |
    Then I verify SOP api response
      | cardType       | visa           |
      | expiryYear     |           2026 |
      | subscriptionId | subscriptionId |
      | billingAddress | Arden          |
    And Test Data for GDC-10271 and Cart details

  @B2C_CA_SOP
  Scenario: [GDC-10481] [B2C] Verify that Reason code '201' appears in the SOP response API and Place Order API when the user has added an invalid credit card number while adding payment details using the CyberSource URL. 
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-ca |
      | cartId     | Valid          |
      | status     |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-10481 and Cart details

  @B2C_CA_SOP
  Scenario: [GDC-10270] Verify that user is able to get SOP request details using API:
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Request API
      | baseSiteId | cengage-b2c-ca |
      | cartId     | Valid          |
      | status     |            200 |
    Then I verify SOP api Request
    And Test Data for GDC-10270 and Cart details

  #----------------------------Removed code---------------------------------- 
  #@B2C_CA_SOP_Smoke
  #Scenario: [GDC-12834] [B2C CA] Verify that API should returns '400' status code in SOP response API response with error message if skipping the CyberSource details.
    #Given I Hit Api to create B2CCA Token
    #Given I hit API to create B2CCA user
    #When I hit API to create B2CCA cart
      #| basestore | cengage-b2c-ca |
      #| status    |            201 |
    #And User add B2C products to cart
      #| basestore | cengage-b2c-ca |
      #| Product   | b2cProduct_2   |
      #| status    |            200 |
    #When User adds delivery address to cart
      #| basestore | cengage-b2c-ca |
      #| address   | CA_address     |
      #| status    |            201 |
    #And User adds billing address to cart
      #| basestore | cengage-b2c-ca |
      #| address   | CA_address     |
      #| status    |            201 |
    #When User puts delivery mode
      #| basestore | cengage-b2c-ca |
      #| mode      | standard-ca    |
      #| status    |            200 |
    #And I Hit SOP Response API
      #| baseSiteId | cengage-b2c-ca |
      #| cartId     | Valid          |
      #| status     |            400 |
    #Then I verify following details in API response
      #| errors[0].message | PaymentInfo [CC Payment info is empty] is invalid for the current cart |
    #And Test Data for GDC-12834 and Cart details
