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
Feature: B2C EMEA Price Verify scenarios

  #--------------------------------SAPECOMM-10790 ---NEW --------------------------------------
  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify @B2C_EMEA_PriceRefIdVerify_QA @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12893] PDP SCE - Verifying the price master Id is displayed in the response of Get PDP API
    Given I Hit Api to create B2CEMEA Token
    And I hit specific product details API by passing pricemaster id as input
      | basestore         | cengage-b2c-emea   |
      | fields            | FULL               |
      | status            |                200 |
    Then I will compare the specific purchaseOptions[0].priceList.priceRow[1].cngPriceType in API response with cmePriceLabel value
    Then I will compare the specific purchaseOptions[0].priceList.priceRow[1].priceReferenceId in API response with cmePriceMasterId value

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify @B2C_EMEA_PriceRefIdVerify_QA @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12894] PDP SCE - Verifying the price reference Id is displayed in the response of Get PDP API
    Given I Hit Api to create B2CEMEA Token
    And I need to hit specific product details API by passing priceref id as input
      | basestore         | cengage-b2c-emea |
      | fields            | FULL             |
      | status            |              200 |
    Then I will compare the specific purchaseOptions[0].priceList.priceRow[1].cngPriceType in API response with cmePriceLabel value
    Then I will compare the specific purchaseOptions[0].priceList.priceRow[1].priceReferenceId in API response with cmePriceRefId value
  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify 
  Scenario: [GDC-12897] ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_MID |
      | status    |                 200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 521817482244419956  |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_QA
  Scenario: [GDC-12897] ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea       |
      | Product   | emeaProduct_CME_MID_S2 |
      | status    |                    200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 258314744870496220 |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12897] ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea       |
      | Product   | emeaProduct_CME_MID_P2 |
      | status    |                    200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 312287246424238032|

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify @B2C_EMEA_PriceRefIdVerify_QA
  Scenario: [GDC-12896] ADD PRODUCT TO CART SCE - Verifying the price reference Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_PID |
      | status    |                 200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 1026496A |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12896] ADD PRODUCT TO CART SCE - Verifying the price reference Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea       |
      | Product   | emeaProduct_CME_PID_P2 |
      | status    |                 200    |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 1226605A |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify
  Scenario: [GDC-12898] RECALCULATE CART SCE-ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_MID |
      | status    |                 200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 521817482244419956  |
    And I hit recalculate B2CEMEA cart API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 521817482244419956  |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_QA
  Scenario: [GDC-12898] RECALCULATE CART SCE-ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea       |
      | Product   | emeaProduct_CME_MID_S2 |
      | status    |                    200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 258314744870496220 |
    And I hit recalculate B2CEMEA cart API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 258314744870496220 |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12898] RECALCULATE CART SCE-ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea       |
      | Product   | emeaProduct_CME_MID_P2 |
      | status    |                    200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 312287246424238032 |
    And I hit recalculate B2CEMEA cart API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 312287246424238032 |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify @B2C_EMEA_PriceRefIdVerify_QA
  Scenario: [GDC-12895] RECALCULATE CART SCE ADD PRODUCT TO CART SCE - Verifying the price reference Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_PID |
      | status    |                 200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 1026496A |
    And I hit recalculate B2CEMEA cart API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 1026496A |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12895] RECALCULATE CART SCE ADD PRODUCT TO CART SCE - Verifying the price reference Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    Given I hit API to create B2CEMEA user
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_PID_P2 |
      | status    |                 200 |
    Then I verify following details in API response
      | bulkCartModificationList[0].cartModification.entry.priceReferenceId | 1226605A |
    And I hit recalculate B2CEMEA cart API
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 1226605A |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify @B2C_EMEA_PriceRefIdVerify_QA
  Scenario: [GDC-12899] MERGE CART SCE ADD PRODUCT TO CART SCE -  Verifying the price reference Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_PID |
      | status    |                 200 |
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_PID |
      | status    |                 200 |
    And I merge anonymous cart with specified user cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 1026496A |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12899] MERGE CART SCE ADD PRODUCT TO CART SCE -  Verifying the price reference Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_PID_P2 |
      | status    |                 200 |
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_PID_P2 |
      | status    |                 200 |
    And I merge anonymous cart with specified user cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 1226605A |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify
  Scenario: [GDC-12900]  MERGE CART SCE ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_MID |
      | status    |                 200 |
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_MID |
      | status    |                 200 |
    And I merge anonymous cart with specified user cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 521817482244419956  |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_Perf
  Scenario: [GDC-12900]  MERGE CART SCE ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_MID_P2 |
      | status    |                 200 |
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea    |
      | Product   | emeaProduct_CME_MID_P2 |
      | status    |                 200 |
    And I merge anonymous cart with specified user cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 312287246424238032	  |

  @sapecomm-10790 @B2C_EMEA_PriceRefIdVerify_QA
  Scenario: [GDC-12900]  MERGE CART SCE ADD PRODUCT TO CART SCE - Verifying the price master Id is displayed in the response of Add product to cart API
    Given I Hit Api to create B2CEMEA Token
    When I want to create anonymous cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea       |
      | Product   | emeaProduct_CME_MID_S2 |
      | status    |                    200 |
    When I hit API to create B2CEMEA cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-emea       |
      | Product   | emeaProduct_CME_MID_S2 |
      | status    |                    200 |
    And I merge anonymous cart with specified user cart
      | basestore | cengage-b2c-emea |
      | status    |              201 |
    Then I verify following details in API response
      | entries[0].priceReferenceId | 258314744870496220 |
