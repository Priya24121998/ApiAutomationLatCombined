#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template
Feature: B2C US Get Api Scenarios

  @sapecomm-9783 @B2C_US_Get
  Scenario: [GDC-12904] Revisit/Research Bundle Stock logic (K vs. A stock type) - Bundle Scenario check for B2C US Store
    Given I Hit Api to create B2CUS Token
    And I will hit to get products associated with bundle and get the minimum stock price
      | basestore | cengage-b2c-us |
      | product   |  9780357000113 |
      | status    |            200 |
    And I hit PDP search
      | basestore | cengage-b2c-us |
      | product   |  9780357000113 |
      | status    |            200 |
    Then assert verify stock level of the PDP response equals minstock

  @sapecomm-9783
  Scenario: [GDC-12911] Revisit/Research Bundle Stock logic (K vs. A stock type) - Ebook Scenario check for B2C US Store [4,6 and 12 month access]
    Given I Hit Api to create B2CUS Token
    And I hit PDP search
      | basestore | cengage-b2c-us |
      | product   |  9780357692981 |
      | status    |            200 |
    Then I verify following details in API response
      | purchaseOptions[0].code                   | 9780357692981@@120D |
      | purchaseOptions[0].duration               |                 120 |
      | purchaseOptions[0].durationUOM            | DAY                 |
      | purchaseOptions[0].stock.stockLevel       | not zero            |
      | purchaseOptions[0].stock.stockLevelStatus | inStock             |
      | type                                      | EBOOK               |
    And I hit PDP search
      | basestore | cengage-b2c-us |
      | product   |  9780357692981 |
      | status    |            200 |
    Then I verify following details in API response
      | purchaseOptions[1].code                   | 9780357692981@@180D |
      | purchaseOptions[1].duration               |                 180 |
      | purchaseOptions[1].durationUOM            | DAY                 |
      | purchaseOptions[1].stock.stockLevel       | not zero            |
      | purchaseOptions[1].stock.stockLevelStatus | inStock             |
      | type                                      | EBOOK               |
    And I hit PDP search
      | basestore | cengage-b2c-us |
      | product   |  9780357692981 |
      | status    |            200 |
    Then I verify following details in API response
      | purchaseOptions[2].code                   | 9780357692981@@360D |
      | purchaseOptions[2].duration               |                 360 |
      | purchaseOptions[2].durationUOM            | DAY                 |
      | purchaseOptions[2].stock.stockLevel       | not zero            |
      | purchaseOptions[2].stock.stockLevelStatus | inStock             |
      | type                                      | EBOOK               |

  @sapecomm-9783
  Scenario: [GDC-12912] Revisit/Research Bundle Stock logic (K vs. A stock type) -Physical type Scenario check for B2C US Store
    Given I Hit Api to create B2CUS Token
    And I hit PDP search
      | basestore | cengage-b2c-us |
      | product   |  9780357513088 |
      | status    |            200 |
    Then I verify following details in API response
      | purchaseOptions[0].stock.stockLevel       | not zero  |
      | purchaseOptions[0].stock.stockLevelStatus | inStock   |
      | type                                      | NARRATIVE |

  @sapecomm-9783
  Scenario: [GDC-12913] Revisit/Research Bundle Stock logic (K vs. A stock type) -Course ware type Scenario check for B2C US Store
    Given I Hit Api to create B2CUS Token
    And I hit PDP search
      | basestore | cengage-b2c-us |
      | product   |  9780357727546 |
      | status    |            200 |
    Then I verify following details in API response
      | purchaseOptions[0].stock.stockLevel       | not zero   |
      | purchaseOptions[0].stock.stockLevelStatus | inStock    |
      | type                                      | COURSEWARE |
      
      
      
      @sapecomm-12181
  Scenario: [SAPECOMM-12181] Commonly Used Query Parameters - LISTING
    Given I Hit Api to create B2CUS Token
      And I hit product details API to Commonly Used Query Parameters
      | basestore | cengage-b2c-us |
      | product   |  9780357932063 |
      | field    |        LISTING |
      | status    |            200 |
    Then I verify following details in API response
      | isbn13      | 9780357932063   |
   
    @sapecomm-12181
  Scenario: [SAPECOMM-12181] Commonly Used Query Parameters - CNGPRODUCTS
    Given I Hit Api to create B2CUS Token
      And I hit product details API to Commonly Used Query Parameters
      | basestore | cengage-b2c-us |
      | product   |  9780357932063 |
      | field    |        CNGPRODUCTS |
      | status    |            200 |
    Then I verify following details in API response
      | isbn13      | 9780357932063   |
      
      
    @sapecomm-12181
  Scenario: [SAPECOMM-12181] Commonly Used Query Parameters - productSearchApi_BYTERM
    Given I Hit Api to create B2CUS Token
      And I hit search request with productSearchApi_BYTERM
      | basestore | cengage-b2c-us |
      | field    |        BYTERM |
      | status    |            200 |
    Then I verify following details in API response
      | type      | productCategorySearchPageWsDTO   |   
      
      
