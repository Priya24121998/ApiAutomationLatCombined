Feature: B2C AU Search and Sort Scenarios

  #################################################  Smoke   ################################################################
  @B2C_AU_Search_Smoke
  Scenario: [GDC-9948] Verify that user is able to search using keywords using API
    Given I Hit Api to create B2CAU Token
    And I hit search
      | basestore | cengage-b2c-au |
      | query     | math           |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.pageSize     | not zero |
      | pagination.totalPages   | not zero |
      | pagination.totalResults | not zero |

  #################################################  Reggression   ###########################################################
  @B2C_AU_Search
  Scenario: [GDC-10240] Verify that user is able to search using ISBNs using API
    Given I Hit Api to create B2CAU Token
    And I hit search
      | basestore | cengage-b2c-au |
      | query     |  9780170416771 |
      | status    |            200 |
    Then I verify results in response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9780170416771 |
      
  @B2C_AU_Search
  Scenario: [GDC-10236] Verify user is able to get the product details using API[for PDP]
    Given I Hit Api to create B2CAU Token
    And I hit PDP search
      | basestore | cengage-b2c-au |
      | product   |  9781418021238 |
      | status    |            200 |
    Then I verify results in response
      | isbn13                  |     9781418021238 |
      | purchaseOptions[0].code | 9781418021238@@NA |
      | mediaType               | Print             |
      | stock.stockLevelStatus  | outOfStock        |
      | type                    | NARRATIVE         |

  @B2C_AU_Search
  Scenario: [GDC-10244] Verify that user is able to sort the searched result as per copyrightYear keywords using API:
    Given I Hit Api to create B2CAU Token
    And I Want to search product with following details
      | basestore | cengage-b2c-au     |
      | query     | maths              |
      | sort      | copyrightYear-desc |
      | status    |                200 |
    Then I verify search results are in descending order

  @B2C_AU_Search
  Scenario: [GDC-10237] Verify that user is able to sort the searched result as per fullTitle keywords using API:
    Given I Hit Api to create B2CAU Token
    And I Want to search product with following details
      | basestore | cengage-b2c-au |
      | query     | History        |
      | sort      | fullTitle-desc |
      | status    |            200 |
    Then I check if result is sorted using fullTitle

  @B2C_AU_Search
  Scenario: [GDC-10424] Verify that facet Copyright Year is appearing in Search API response.
    Given I Hit Api to create B2CAU Token
    And I hit search
      | basestore | cengage-b2c-au |
      | query     | Portfolios     |
      | status    |            200 |
    Then I verify Copyright Year facet in api response
