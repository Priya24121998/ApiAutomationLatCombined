Feature: B2C CA Search and Sort Scenarios

  #################################################  Smoke   ################################################################
  @B2C_CA_Search_Smoke
  Scenario: [GDC-9968] Verify user is able to get the product details using API[for PDP]
    Given I Hit Api to create B2CCA Token
    And I hit PDP search
      | basestore | cengage-b2c-ca |
      | product   |  9780176766009 |
      | status    |            200 |
    Then I verify results in response
      | isbn13                  |     9780176766009 |
      | purchaseOptions[0].code | 9780176766009@@NA |
      | mediaType               | Print             |
      | stock.stockLevelStatus  | outOfStock        |
      | type                    | NARRATIVE         |

  #################################################  Reggression   ###########################################################


  @B2C_CA_Search
  Scenario: [GDC-10282] Verify that user is able to search using keywords using API
    Given I Hit Api to create B2CCA Token
    And I hit search
      | basestore | cengage-b2c-ca |
      | query     | math           |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.pageSize     | not zero |
      | pagination.totalPages   | not zero |
      | pagination.totalResults | not zero |

  @B2C_CA_Search
  Scenario: [GDC-10281] Verify that user is able to search using ISBNs using API
    Given I Hit Api to create B2CCA Token
    And I hit search
      | basestore | cengage-b2c-ca |
      | query     |  9780176766009 |
      | status    |            200 |
    Then I verify results in response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9780176766009 |

  @B2C_CA_Search
  Scenario: [GDC-10292] Verify that user is able to sort the searched result as per copyrightYear keywords using API:
    Given I Hit Api to create B2CCA Token
    And I Want to search product with following details
      | basestore | cengage-b2c-ca     |
      | query     | maths              |
      | sort      | copyrightYear-desc |
      | status    |                200 |
    Then I verify search results are in descending order

  @B2C_CA_Search
  Scenario: [GDC-10286] Verify that user is able to sort the searched result as per fullTitle keywords using API:
    Given I Hit Api to create B2CCA Token
    And I Want to search product with following details
      | basestore | cengage-b2c-ca |
      | query     | History        |
      | sort      | fullTitle-desc |
      | status    |            200 |
    Then I check if result is sorted using fullTitle

  @B2C_CA_Search
  Scenario: [GDC-10262] Verify that user is able to sort the searched result as per publicationDate keywords using API
    Given I Hit Api to create B2CCA Token
    And I Want to search product with following details
      | basestore | cengage-b2c-ca       |
      | query     | Maths                |
      | sort      | publicationDate-desc |
      | status    |                  200 |
    Then I check if result is sorted desc using PublishingDate
     And I Want to search product with following details
      | basestore | cengage-b2c-ca       |
      | query     | Maths                |
      | sort      | publicationDate-asc |
      | status    |                  200 |
    Then I check if result is sorted asc using PublishingDate

  @B2C_CA_Search
  Scenario: [GDC-10424] Verify that facet Copyright Year is appearing in Search API response.
    Given I Hit Api to create B2CCA Token
    And I hit search
      | basestore | cengage-b2c-ca |
      | query     | Portfolios     |
      | status    |            200 |
    Then I verify Copyright Year facet in api response
