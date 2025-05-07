Feature: B2B GT GET API Scenarios

  #################################################  Smoke   ################################################################
  #################################################				QA				##############################################
  @B2BGT_QA
  Scenario: [GDC-10379] Verify that user gets all the base store related inormation using API
    Given I Hit Api to create B2BGT Token
    And I hit get basestore details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | allowedCardTypes    | not null |
      | allowedPaymentModes | not null |
      | currencies          | not null |
      | defaultCurrency     | not null |
      | defaultLanguage     | not null |
      | deliveryCountries   | not null |
      | deliveryModes       | not null |
      | name                | GT B2B   |

  @B2BGT_QA
  Scenario: [GDC-12685] Verify the availability of property "clProductGroup" in search API response for Gale & Thordike
    Given I Hit Api to create B2BGTOne Token
    And I hit search
      | basestore | cengage-b2b-gt |
      | query     | math           |
      | status    |            200 |
    Then I verify results in response
      | products[1].clProductGroup  |      Thorndike      |
      | products[10].clProductGroup | Gale                |
    And I hit PDP search
      | basestore | cengage-b2b-gt |
      | product   |  9783319005782 |
      | status    |            200 |
    Then I verify results in response
      | clProductGroup | Gale |
    And I hit PDP search
      | basestore | cengage-b2b-gt |
      | product   |  9780062843050 |
      | status    |            200 |
    Then I verify results in response
      | clProductGroup | Thorndike |

  @sapecomm-9783 @B2BGT_QA
  Scenario: [GDC-12910] Revisit/Research Bundle Stock logic (K vs. A stock type) - Bundle Scenario check for B2B GT Store
    Given I Hit Api to create B2BGT Token
    And I hit PDP search
      | basestore | cengage-b2b-gt |
      | product   |  9780007772650 |
      | status    |            200 |
    Then I verify following details in API response
      | purchaseOptions[0].stock.stockLevel       | not zero |
      | purchaseOptions[0].stock.stockLevelStatus | inStock  |
      | type                                      | EBOOK    |


  @B2BGT_QA
  Scenario: [GDC-12985]Update existing unique identifier(UID) of any b2b unit to EAN and Account number field to MID
    Given I Hit Api to create B2BGT Token
    And I hit b2bgale user creation api
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | GTAccNumE1QA          |
      | status    |            201 |
    And I hit get user specific accounts deatails API
      | basestore  | cengage-b2b-gt |
      | status     |            200 |
    Then I verify following details in API response
      | billToAccounts.e1AccountNumber               | 157208 |
      | customerDefaultBillToAccount.e1AccountNumber | 157208 |
      | shipToAccounts.e1AccountNumber               | 157208 |
    And I hit API to get specific orgUnit details
      | basestore | cengage-b2b-gt |
      | orgUnitID |          0100177038 |
      | status    |            200 |
    Then I verify following details in API response
      | e1AccountNumber               | 157208 |
    And I hit get all Org units details
      | basestore   | cengage-b2b-gt |
      | currentPage |              0 |
      | pageSize    |             100|
      | status      |            200 |
    Then e1AccountNumber is not being returned in get customer profile
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I Hit the API to add cart to user account and verify status code E1
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt     |
      | shipToAccountNumber |         0100177038 |
      | billToAccountNumber |         0100177038 |
      | status              |            202     |


      
