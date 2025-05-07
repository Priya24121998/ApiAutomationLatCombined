Feature: B2B CA Search and Sort Scenarios

  #################################################  Smoke   ################################################################
  @B2BCA_Search_Smoke
  Scenario: [GDC-9904] Verify that user is able to search using ISBNs using API
    Given I Hit Api to create B2BCA Token
    And I hit search
      | basestore | cengage-b2b-ca |
      | query     |  9781285446646 |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9781285446646 |

  @Perf_B2BCA_Search_Smoke
  Scenario: [GDC-9904] Verify that user is able to search using ISBNs using API
    Given I Hit Api to create B2BCA Token
    And I hit search
      | basestore | cengage-b2b-ca |
      | query     |  9780357702239 |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9780357702239 |

  #################################################  Reggression   ################################################################
  @B2BCA_Search
  Scenario: [GDC-330] Verify that product search OCC API returns search results based on keywords.
    Given I Hit Api to create B2BCA Token
    And I hit search
      | basestore | cengage-b2b-ca |
      | query     | modern         |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.pageSize     | not zero |
      | pagination.totalPages   | not zero |
      | pagination.totalResults | not zero |

  @B2BCA_Search
  Scenario: [GDC-225] Verify that Prices can be retrieved for specific currencies via Search API
    Given I Hit Api to create B2BCA Token
    And I hit search
      | basestore | cengage-b2b-ca |
      | query     |  9781337696456 |
      | status    |            200 |
    Then I verify results in response
      | products[0].code                 | 9781337696456 |
      | products[0].price.currencyIso    | CAD           |
      | products[0].price.value          |         74.95 |
      | products[0].price.formattedValue | $74.95        |

 
  @B2BCA_Search
  Scenario: [GDC-297] Verify that Product search API: /{baseSiteId}/products/search returns search results based on category codes.
    Given I Hit Api to create B2BCA Token
    And I hit search
      | basestore | cengage-b2b-ca                     |
      | query     | :fullTitle-asc:allCategories:MNG06 |
      | status    |                                200 |
    Then I verify following details in API response
      | pagination.pageSize     | not zero      |
      | pagination.sort         | fullTitle-asc |
      | pagination.totalPages   | not zero      |
      | pagination.totalResults | not zero      |

  @B2BCA_Search
  Scenario: [GDC-10424] Verify that facet Copyright Year is appearing in Search API response.
    Given I Hit Api to create B2BCA Token
    And I hit search
      | basestore | cengage-b2b-ca |
      | query     | Portfolios     |
      | status    |            200 |
    Then I verify Copyright Year facet in api response

  #------------------------------Sorting---------------------------------------------#
  @B2BCA_Search
  Scenario: [GDC-10261] Verify that user is able to sort the searched result as per copyrightYear keywords using API:
    Given I Hit Api to create B2bCA Token
    And I Want to search product with following details
      | basestore | cengage-b2b-ca     |
      | query     | maths              |
      | sort      | copyrightYear-desc |
      | status    |                200 |
    Then I verify search results are in descending order

  @B2BCA_Search
  Scenario: [GDC-10260] Verify that user is able to sort the searched result as per fullTitle keywords using API:
    Given I Hit Api to create B2BCA Token
    And I Want to search product with following details
      | basestore | cengage-b2b-ca |
      | query     | Maths          |
      | sort      | fullTitle-desc |
      | status    |            200 |
    Then I check if result is sorted using fullTitle

