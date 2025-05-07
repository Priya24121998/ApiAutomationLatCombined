Feature: B2B CA GET API Scenarios

  #################################################  Smoke   ################################################################
  @B2B_CA_Smoke
  Scenario: [GDC-954] [Partially Automated] Verify OCC API: updates customer status from Pending to Active.
    Given I Hit Api to create B2BCA Token
    And I hit b2b User creation API
      | basestore | cengage-b2b-ca |
      | store     | Pending_CA     |
      | email     | automation     |
      | status    |            201 |
    Then I verify B2BCA customer is registered
    Then I get customer details
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | roles[0]      | purchaser |
      | accountStatus | PENDING   |
    And I hit API to update b2b customer status
      | basestore | cengage-b2b-ca |
      | status    |            204 |
    Then I get customer details
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | accountStatus | ACTIVE |

  ################################################# Reggression   ###########################################################
  @B2B_CA
  Scenario: [GDC-1004] Verify that proper error message should be returned while using worng b2b unit in API
    Given I Hit Api to create B2BCA Token
    And I hit API to get specific orgUnit details
      | basestore | cengage-b2b-ca |
      | orgUnitID |          42208 |
      | status    |            404 |
    Then I verify following details in API response
      | errors[0].message | Organizational unit with id [42208] was not found |

  #New
  @B2B_CA
  Scenario: [GDC-10259] Verify no input validation on name field of customer API
    Given I Hit Api to create B2BCA Token
    And I hit b2b user creation API with regex
      | basestore | cengage-b2b-ca |
      | store     | CA             |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | status    |            201 |
    Then I verify B2BCA customer is registered

  #New
  @B2B_CA
  Scenario: [GDC-10187] User is able to fetch customer account details using API
    Given I Hit Api to create B2BCA Token
    And I hit get customer Account details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | billToAccounts[0].accountNumber            | 84002336 |
      | customerDefaultBillToAccount.accountNumber | 84002335 |
      | customerDefaultShipToAccount.accountNumber | 84002336 |
      | shipToAccounts[0].accountNumber            | 84002336 |
    And I look for customerId in API response
    
  @B2B_CA_INT
  Scenario: [GDC-10187] User is able to fetch customer account details using API
    Given I Hit Api to create B2BCA Token
    And I hit get b2bca customer Account details API
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | billToAccounts[0].accountNumber            | 84000381 |
      | customerDefaultBillToAccount.accountNumber | 84000381 |
      | customerDefaultShipToAccount.accountNumber | 84000381 |
      | shipToAccounts[0].accountNumber            | 84000384 |
    And I will get the respective customerId in API response

  #New
  @B2B_CA
  Scenario: [GDC-10258] Verify no input validation on name email of customer registration API
    Given I Hit Api to create B2BCA Token
    And I hit b2b user creation API with regex
      | basestore | cengage-b2b-ca         |
      | store     | CA                     |
      | fName     | FirstName              |
      | lName     | LastName               |
      | email     | test123@yopYY123.wR.us |
      | status    |                    201 |
    Then I verify B2BCA customer is registered

  #Need Verification
  @B2B_CA
  Scenario: [GDC-697] Verify that GET Product API retrieves all prices (together with the default prices) in case priceReferenceIds is passed
    Given I Hit Api to create B2BCA Token
    And I hit product details API
      | basestore         | cengage-b2b-ca    |
      | query             | 9780155063174@@NA |
      | priceReferenceIds |          20141000 |
      | fields            | FULL              |
      | status            |               200 |
    Then I verify results in response
      | priceList.priceRow[0].cngPriceType | NET_PRICE   |
      | priceList.priceRow[1].cngPriceType | OFFER_PRICE |
     

  @B2B_CA
  Scenario: [GDC-694] Verify that Product API returns the categories that the product belongs to
    Given I Hit Api to create B2BCA Token
    And I hit PDP search
      | basestore | cengage-b2b-ca |
      | product   |  9780357132869 |
      | status    |            200 |
    Then I verify results in response
      | categories[0].name | Health Economics |

  @B2B_CA
  Scenario: [GDC-695] Verify that Catalog API returns category tree for the store using API.
    # /{baseSiteId}/catalogs
    Given I Hit Api to create B2BCA Token
    And I hit to get list of catalogs
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | catalogs[1].catalogVersions[1].categories                  | not null |
      | catalogs[1].catalogVersions[1].categories[0].subcategories | not null |

  @B2B_CA
  Scenario: [GDC-307] Verify that user is able to get details about the products related to bundles through API:
    Given I Hit Api to create B2BCA Token
    And I hit to get produts associated with bundle
      | basestore | cengage-b2b-ca |
      | product   |  9781285256351 |
      | status    |            200 |
    Then I verify results in response
      | code                               |     9781285256351 |
      | bundleComponents[0].code           | 9781133611097@@NA |
      | bundleComponents[1].code           | 9781133611509@@NA |
      | priceList.priceRow[0].cngPriceType | NET_PRICE         |
      | priceList.priceRow[1].cngPriceType | OFFER_PRICE       |
      
 
  @sapecomm-9783 @B2B_CA
  Scenario: [GDC-12909] Revisit/Research Bundle Stock logic (K vs. A stock type) - Bundle Scenario check for B2B CA Store
    Given I Hit Api to create B2BCA Token
    And I will hit to get products associated with bundle and get the minimum stock price
      | basestore | cengage-b2b-ca |
      | product   |  9781774749623 |
      | status    |            200 |
    And I hit PDP search
      | basestore | cengage-b2b-ca |
      | product   |  9781774749623 |
      | status    |            200 |
    Then assert verify stock level of the PDP response equals minstock
    
   @SAPECOMM-11315
  Scenario: [GDC-12984 ]Update existing unique identifier(UID) of any b2b unit to EAN and Account number field to MID
    Given I Hit Api to create B2BCA Token
    And I hit b2b User creation API
      | basestore | cengage-b2b-ca |
      | email     | automation     |
      | store     | CAAccNumE1             |
      | status    |            201 |
    And I hit get user specific accounts deatails API
      | basestore  | cengage-b2b-ca |
      | status     |            200 |
    Then I verify following details in API response
      | billToAccounts.e1AccountNumber               | 840254111 |
      | customerDefaultBillToAccount.e1AccountNumber | 840254111 |
      | shipToAccounts.e1AccountNumber               | 840254111 |
    And I hit API to get specific orgUnit details
      | basestore | cengage-b2b-ca |
      | orgUnitID |          840254111 |
      | status    |            200 |
    Then I verify following details in API response
      | e1AccountNumber               | 840254111 |  
     And I hit get all Org units details
      | basestore   | cengage-b2b-ca |
      | currentPage |              0 |
      | pageSize    |             100|
      | status      |            200 |
    Then e1AccountNumber is not being returned in get customer profile
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    When I Hit the API to add cart to user account and verify status code E1
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |         840254111 |
      | billToAccountNumber |         840254111 |
      | status              |            202 | 
     And Test Data for GDC-10423 and Order details
    
    
