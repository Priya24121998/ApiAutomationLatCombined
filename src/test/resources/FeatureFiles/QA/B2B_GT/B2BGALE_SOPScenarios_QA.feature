Feature: B2B GT SOP  Scenarios

  @B2BGT_SOP_QA
  Scenario: [GDC-10406] Verify that user is able to get SOP response details using API:
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
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2b-gt |
      | cartId     | Valid          |
      | status     |            200 |
    Then I verify following details in API response
      | cardType       | visa     |
      | expiryYear     | 2026     |
      | subscriptionId | not zero |
      | billingAddress | not null |
    And Test Data for GDC-10406 and Cart details

  @B2BGT_SOP_QA
  Scenario: [GDC-10405] Verify that user is able to get SOP request details using API:
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
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Request API
      | baseSiteId | cengage-b2b-gt |
      | cartId     | Valid          |
      | status     |            200 |
    Then I verify SOP api Request
    And Test Data for GDC-10405 and Cart details

  @B2BGT_SOP_QA
  Scenario: [GDC-12828] [Gale] Verify that API should return the '400' status code in the SOP response API response with an error message if gets an error in CyberSource.
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
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2b-gt |
      | cartId     | Valid          |
      | status     |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-12828 and Cart details

  @B2BGT_SOP_QA
  Scenario: [GDC-12829] [Thorndike] Verify that API should return the '400' status code in the SOP response API response with an error message if gets an error in CyberSource.
    Given I Hit Api to create B2BGThorndikeOne Token
    When I hit API to create B2BGThorndikeOne cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BGT store
      | basestore           | cengage-b2b-gt |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt        |
      | Product   | b2bGaleProduct_1      |
      | status    |                   200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt |
      | code      | GD             |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2b-gt |
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2b-gt |
      | cartId     | Valid          |
      | status     |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-12829 and Cart details


