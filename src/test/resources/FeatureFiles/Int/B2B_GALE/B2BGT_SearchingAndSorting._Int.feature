Feature: B2B GT Search and Sort Scenarios

 #################################################  Smoke   ################################################################
 	@B2BGT_Search_Smoke_Int
  Scenario: [GDC-10403] Verify user is able to navigate through PDP using API:
    Given I Hit Api to create B2BGT Token
    And I hit PDP search
      | basestore | cengage-b2b-gt |
      | product     |  9780028671833 |
      | status    |            200 |
    Then I verify results in response
      | isbn13                  |     9780028671833 |
      | purchaseOptions[0].code | 9780028671833@@NA |
      | stock.stockLevelStatus  |  inStock          |
      | type                    | NARRATIVE         |

  @B2BGT_Search_Smoke_Int
  Scenario: [GDC-10404] Verify that user is able to search result with ISBN using API:
     Given I Hit Api to create B2BGT Token
    And I hit search
      | basestore | cengage-b2b-gt |
      | query     | 9780028671833  |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.totalPages   |  1 |
      | pagination.totalResults | 1 |
 	
 
  #################################################				QA				##############################################
  @B2BGT_Search_Int
  Scenario: [GDC-10402] Verify that user is able to search using keywords using API
    Given I Hit Api to create B2BGT Token
    And I hit search
      | basestore | cengage-b2b-gt |
      | query     | Maths          |
      | status    |            200 |
    Then I verify following details in API response
      | pagination.totalPages   |  not zero |
      | pagination.totalResults | not zero |
    #Then I verify results in response
      #| pagination.totalPages   |  20 |
      #| pagination.totalResults | 385 |