Feature: B2C EMEA Search and Sort Scenarios

  #------------------------------------------------Emea Smoke----------------------------------------------------------------
  @Emea_Smoke
  Scenario: [GDC-9817] Verify that user is able to search product details [PDP] using API:
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea  |
      | product   | 9781337696456@@NA |
      | status    |               200 |
    Then I verify results in response
      | isbn13            | 9781337696456 |
      | price.currencyIso | GBP           |

  #------------------------------------------------Emea Smoke----------------------------------------------------------------
  @B2C_EMEA_Search
  Scenario: [GDC-224] Verify that Prices can be retrieved for specific currencies via Product API
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea  |
      | product   | 9781337696456@@NA |
      | status    |               200 |
    Then I verify results in response
      | isbn13               | 9781337696456 |
      | price.currencyIso    | GBP           |
      | price.value          |         43.59 |
      | price.formattedValue | £43.59        |

  @B2C_EMEA_Search
  Scenario: [GDC-225] Verify that Prices can be retrieved for specific currencies via Search API
    Given I Hit Api to create B2CEMEA Token
    And I hit search
      | basestore | cengage-b2c-emea |
      | query     |    9781337696456 |
      | status    |              200 |
    Then I verify results in response
      | products[0].code                 | 9781337696456 |
      | products[0].price.currencyIso    | GBP           |
      | products[0].price.value          |         43.59 |
      | products[0].price.formattedValue | £43.59        |

  @B2C_EMEA_Search
  Scenario: [GDC-282] Verify that Product API returns NET_PRICE, OFFER_PRICE
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea  |
      | product   | 9781337696456@@NA |
      | status    |               200 |
    Then I verify results in response
      | isbn13                             | 9781337696456 |
      | price.currencyIso                  | GBP           |
      | priceList.priceRow[0].cngPriceType | OFFER_PRICE   |
      | priceList.priceRow[1].cngPriceType | NET_PRICE     |

  @B2C_EMEA_Search
  Scenario: [GDC-297] Verify that Product search API: /{baseSiteId}/products/search returns search results based on category codes.
    Given I Hit Api to create B2CEMEA Token
    And I hit search
      | basestore | cengage-b2c-emea                   |
      | query     | :fullTitle-asc:allCategories:MNG06 |
      | status    |                                200 |
    Then I verify results in response
      | pagination.pageSize     |            20 |
      | pagination.sort         | fullTitle-asc |
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             2 |

  @B2C_EMEA_Search
  Scenario: [GDC-10424] Verify that facet Copyright Year is appearing in Search API response.
    Given I Hit Api to create B2CEMEA Token
    And I hit search
      | basestore | cengage-b2c-emea |
      | query     | Portfolios       |
      | status    |              200 |
    Then I verify Copyright Year facet in api response

  @B2C_EMEA_Search
  Scenario: [GDC-338] Verify that OCC API returns the product search result with using sorting as a parameter.
    Given I Hit Api to create B2CEMEA Token
    And I Want to search product with following details
      | basestore | cengage-b2c-emea   |
      | query     | History            |
      | sort      | copyrightYear-desc |
      | status    |                200 |
    Then I verify search results are in descending order

  @B2C_EMEA_Search
  Scenario: [GDC-330] Verify that product search OCC API returns search results based on keywords.
    Given I Hit Api to create B2CEMEA Token
    And I hit search
      | basestore | cengage-b2c-emea |
      | query     | modern           |
      | status    |              200 |
    Then I verify following details in API response
      | pagination.pageSize     | not zero |
      | pagination.totalPages   | not zero |
      | pagination.totalResults | not zero |

  @B2C_EMEA_Search
  Scenario: [GDC-694] Verify that Product API returns the categories that the product belongs to
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea    |
      | product   | 9780357439159@@360D |
      | status    |                 200 |
    Then I verify results in response
      | categories[0].code | ebook |
      
  @B2C_EMEA_Search
  Scenario: [GDC-9815] Verify that user is able to sort the searched result as per 'fullTitle' keywords using API:
    Given I Hit Api to create B2CEMEA Token
    And I Want to search product with following details
      | basestore | cengage-b2c-emea |
      | query     | science         |
      | sort      | fullTitle-desc |
      | status    |            200 |
    Then I check if result is sorted using fullTitle
    
   @B2C_EMEA_Search
  Scenario: [GDC-9814] Verify that user is able to sort the searched result as per 'copyrightYear' keywords using API
    Given I Hit Api to create B2CEMEA Token
    And I Want to search product with following details
      | basestore | cengage-b2c-emea |
      | query     | math        |
      | sort      | copyrightYear-desc |
      | status    |            200 |
    Then I verify search results are in descending order
    
  @B2C_EMEA_Search
  Scenario: [GDC-9813] Verify that user is able to search using ISBNs using API
    Given I Hit Api to create B2CEMEA Token
    And I hit search
      | basestore | cengage-b2c-emea |
      | query     |  9781111129002 |
      | status    |            200 |
    Then I verify results in response
      | pagination.totalPages   |             1 |
      | pagination.totalResults |             1 |
      | products[0].code        | 9781111129002 |
