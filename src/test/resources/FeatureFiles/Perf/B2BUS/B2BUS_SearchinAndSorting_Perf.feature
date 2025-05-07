Feature: B2B US Search and Sort Scenarios

  #################################################  Smoke   ################################################################
  @B2BUS_Search_Smoke_Perf
  Scenario: [GDC-9922] Verify that user is able to search using ISBNs using API
    Given I Hit Api to create B2BUS Token
    And I hit search
      | basestore | cengage-b2b-us |
      | query     |  9780357378977 |
      | status    |            200 |
    Then I verify results in response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9780357378977 |

  #################################################  Reggression   ################################################################
  @B2BUS_Search_Perf
  Scenario: [GDC-10184] Verify that user is able to search using keywords using API
    Given I Hit Api to create B2BUS Token
    And I hit search
      | basestore | cengage-b2b-us |
      | query     | Maths          |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.pageSize     | not zero |
      | pagination.totalPages   | not zero |
      | pagination.totalResults | not zero |

  @B2BUS_Search_Perf
  Scenario: [GDC-10191] Verify user is able to navigate through PDP using API:
    Given I Hit Api to create B2BUS Token
    And I hit PDP search
      | basestore | cengage-b2b-us |
      | product   |  9780357378977 |
      | status    |            200 |
    Then I verify results in response
      | isbn13                  |     9780357378977 |
      | purchaseOptions[0].code | 9780357378977@@NA |
      | stock.stockLevelStatus  | outOfStock        |
      | type                    | NARRATIVE         |

  @B2BUS_Search_Perf
  Scenario: [GDC-10424] Verify that facet Copyright Year is appearing in Search API response.
    Given I Hit Api to create B2BUS Token
    And I hit search
      | basestore | cengage-b2b-us |
      | query     | science        |
      | status    |            200 |
    Then I verify Copyright Year facet in api response
