Feature: B2C EMEA Get API Scenarios

  @B2C_EMEA_Get
  Scenario: [GDC-307] Verify that user is able to get details about the products related to bundles through API:
    Given I Hit Api to create B2CEMEA Token
    And I hit to get produts associated with bundle
      | basestore | cengage-b2c-emea |
      | product   |    9780357527696 |
      | status    |              200 |
    Then I verify results in response
      | code                                 |       9780357527696 |
      | bundleComponents[0].code             | 9780357641941@@NA   |
      | bundleComponents[1].code             | 9781305955691@@360D |
      | priceList.priceRow[0].cngPriceType   | OFFER_PRICE         |
      | priceList.priceRow[0].formattedValue | £35.50              |

  @B2C_EMEA_Get
  Scenario: [GDC-697] Verify that GET Product API retrieves all prices (together with the default prices) in case priceReferenceIds is passed
    Given I Hit Api to create B2CEMEA Token
    And I hit product details API
      | basestore         | cengage-b2c-emea  |
      | query             | 9780357641224@@NA |
      | priceReferenceIds | 1J-1234, 1106951A |
      | fields            | FULL              |
      | status            |               200 |
    Then I verify results in response
      | priceList.priceRow[0].cngPriceType | OFFER_PRICE |
      | priceList.priceRow[1].cngPriceType | IA_PRICE    |
      | priceList.priceRow[2].cngPriceType | CME_PRICE   |

  @B2C_EMEA_Get
  Scenario: [GDC-695] Verify that Catalog API returns category tree for the store using API.
    Given I Hit Api to create B2CEMEA Token
    And I hit to get list of catalogs
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | catalogs[0].catalogVersions[1].categories                  | not null |
      | catalogs[0].catalogVersions[1].categories[0].subcategories | not null |

  @B2C_EMEA_Get
  Scenario: [GDC-668] Payment Details OCC API: successfully reads credit card from a customer account
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea |
      | Product   | emeaProduct_2    |
      | status    |              200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-emea |
      | address   | emea_address     |
      | status    |              201 |
    When I hit get cart details API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    When User puts delivery mode
      | basestore | cengage-b2c-emea               |
      | mode      | EMEA_Express_Shipping_Domestic |
      | status    |                            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-emea |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And I hit api to get saved paymentInfo list for B2CEMEA
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | payments                      | not null         |
      | payments[0].accountHolderName | Test User        |
      | payments[0].cardType.name     | Visa             |
      | payments[0].cardNumber        | xxxxxxxxxxxx1111 |

  @B2C_EMEA_Get
  Scenario: [GDC-993] API should throw an error with incorrect baseSiteId
    Given I Hit Api to create B2CEMEA Token
    And I hit API to get a list countries
      | basestore | cengage-b2c-emea1 |
      | type      | BILLING           |
      | status    |               400 |
    Then I verify following details in API response
      | errors[0].message | Base site cengage-b2c-emea1 doesn't exist |

  #---------------------------SAPECOMM-9783-NEW ---------------------------------------------------------#
  @sapecomm-9783 @B2C_EMEA_Get
  Scenario: [GDC-12906] Revisit/Research Bundle Stock logic (K vs. A stock type) - Bundle Scenario check for B2C EMEA Store
    Given I Hit Api to create B2CEMEA Token
    And I will hit to get products associated with bundle and get the minimum stock price
      | basestore | cengage-b2c-emea |
      | product   |    9781473783515 |
      | status    |              200 |
    And I hit PDP search
      | basestore | cengage-b2c-emea |
      | product   |    9781473783515 |
      | status    |              200 |
    Then assert verify stock level of the PDP response equals minstock

  @sapecomm-9783 @B2C_EMEA_Get
  Scenario: [GDC-12918] Revisit/Research Bundle Stock logic (K vs. A stock type) - Invalid scenario - 400 OK Response by passing invalid product ID
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea |
      | product   |    9780357004722 |
      | status    |              400 |

  @sapecomm-9783 @B2C_EMEA_Get
  Scenario: [GDC-12917] Revisit/Research Bundle Stock logic (K vs. A stock type) - Ebook type Scenario check for B2C EMEA Store
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea |
      | product   |    9780357191828 |
      | status    |              200 |
    Then I verify following details in API response
      | purchaseOptions[0].code                   | 9780357191828@@720D |
      | purchaseOptions[0].duration               |                 720 |
      | purchaseOptions[0].durationUOM            | DAY                 |
      | purchaseOptions[0].stock.stockLevel       | not zero            |
      | purchaseOptions[0].stock.stockLevelStatus | inStock             |
      | type                                      | EBOOK               |

  @sapecomm-9783 @B2C_EMEA_Get
  Scenario: [GDC-12916] Revisit/Research Bundle Stock logic (K vs. A stock type) -Narrative type Scenario check for B2C EMEA Store
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea |
      | product   |    9781473764798 |
      | status    |              200 |
    Then I verify following details in API response
      | purchaseOptions[0].stock.stockLevel       | not zero  |
      | purchaseOptions[0].stock.stockLevelStatus | inStock   |
      | type                                      | NARRATIVE |

  @sapecomm-9783 @B2C_EMEA_Get
  Scenario: [GDC-12915] Revisit/Research Bundle Stock logic (K vs. A stock type) -Supplemental type Scenario check for B2C EMEA Store
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea |
      | product   |    9780495385066 |
      | status    |              200 |
    Then I verify following details in API response
      | productReferences[0].target.purchaseOptions[0].stock.stockLevel | not zero     |
      | purchaseOptions[0].stock.stockLevelStatus | inStock      |
      | type                                      | SUPPLEMENTAL |

  @sapecomm-9783 @B2C_EMEA_Get
  Scenario: [GDC-12914] Revisit/Research Bundle Stock logic (K vs. A stock type) - Course ware type Scenario check for B2C EMEA Store
    Given I Hit Api to create B2CEMEA Token
    And I hit PDP search
      | basestore | cengage-b2c-emea |
      | product   |    9780357392157 |
      | status    |              200 |
    Then I verify following details in API response
      | purchaseOptions[0].stock.stockLevel       | not zero   |
      | purchaseOptions[0].stock.stockLevelStatus | inStock    |
      | type                                      | COURSEWARE |

  #---------------------------SAPECOMM-10797-NEW ---------------------------------------------------------#
  @sapecomm-10797  @B2C_EMEA_Get
  Scenario: [GDC-697] Verify the attribute product master id is present in base product
    Given I Hit Api to create B2CEMEA Token
    And I hit get product details API
      | basestore | cengage-b2c-emea |
      | product   |    9781473773905 |
      | status    |              200 |
    Then I verify results in response
      | productMasterId | 579348482544976173 |
      
      
  @sapecomm-10797  @B2C_EMEA_Get
  Scenario: [GDC-697] Verify the attribute product master id is present in base product
    Given I Hit Api to create B2CEMEA Token
    And I hit get product details API
      | basestore | cengage-b2c-emea |
      | product   |    9781473774049 |
      | status    |              200 |
    Then I verify results in response
      | productMasterId | 579348482989572376 |
      
      
   @sapecomm-10797  @B2C_EMEA_Get
  Scenario: [GDC-697] Verify the attribute product master id is present in base product
    Given I Hit Api to create B2CEMEA Token
    And I hit get product details API
      | basestore | cengage-b2c-emea |
      | product   |    9781473773639 |
      | status    |              200 |
    Then I verify results in response
      | productMasterId | 579348482989572268 |
      
    @sapecomm-10797  @B2C_EMEA_Get
  Scenario: [GDC-697] Verify the attribute product master id is present in base product
    Given I Hit Api to create B2CEMEA Token
    And I hit get product details API
      | basestore | cengage-b2c-emea |
      | product   |    9781473774360 |
      | status    |              200 |
    Then I verify results in response
      | productMasterId | 579348482989572262 |
      
      
    @sapecomm-10797  @B2C_EMEA_Get
  Scenario: [GDC-697] Verify the attribute product master id is present in base product
    Given I Hit Api to create B2CEMEA Token
    And I hit get product details API
      | basestore | cengage-b2c-emea |
      | product   |    9781473774612 |
      | status    |              200 |
    Then I verify results in response
      | productMasterId | 579348483920707738|
      
      
    @sapecomm-10797  @B2C_EMEA_Get
  Scenario: [GDC-697] Verify the attribute product master id is present in base product
    Given I Hit Api to create B2CEMEA Token
    And I hit get product details API
      | basestore | cengage-b2c-emea |
      | product   |    9781473774575 |
      | status    |              200 |
    Then I verify results in response
      | productMasterId | 579348483920707616|  
    
