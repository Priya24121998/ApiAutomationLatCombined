Feature: B2B US GET API Scenarios

  #################################################  Smoke   ################################################################
  @B2B_US_Smoke_Perf
  Scenario: [GDC-9921] User is able to update customer details using API
    Given I Hit Api to create B2BUSNew Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      | status    |            201 |
    Then I verify B2BUSNew customer is registered
    Then I get customer details
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | roles[0]      | purchaser |
      | accountStatus | ACTIVE    |
    And I hit API to update b2b customer details
      | basestore | cengage-b2b-us |
      | status    |            204 |
    Then I get customer details
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | roles[1]      | inquiry-only     |
      | roles[0]      | cengage-employee |
      | accountStatus | ACTIVE           |

  #################################################				QA				##############################################
   @B2B_US_Reg_Perf
  Scenario: [GDC-10173] Verify that user gets all the base store related inormation using API
    Given I Hit Api to create B2BUSNew Token
    And I hit get basestore details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | allowedCardTypes    | not null |
      | allowedPaymentModes | not null |
      | currencies          | not null |
      | defaultCurrency     | not null |
      | defaultLanguage     | not null |
      | deliveryCountries   | not null |
      | deliveryModes       | not null |
      | name                | US B2B   |

   @B2B_US_Reg_Perf
  Scenario: [GDC-10182] Verify user get all the Account Number related to base-store using API:
    Given I Hit Api to create B2BUSNew Token
    And I hit get all units details
      | basestore   | cengage-b2b-us |
      | currentPage |              0 |
      | pageSize    |             20 |
      | status      |            200 |
    Then I verify 20 Account Numbers in API response

   @B2B_US_Reg_Perf
  Scenario: [GDC-10174] User is able to create using API
    Given I Hit Api to create B2BUSNew Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      | status    |            201 |
    Then I verify B2BUSNew customer is registered

   @B2B_US_Reg_Perf
  Scenario: [GDC-10181] User is able to get user profile deatils using API
    Given I Hit Api to create B2BUSNew Token
    And I will hit get B2BUS customer details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | accountStatus | ACTIVE        |
      | storeName     | not null |
      | roles         | not null      |
      | orgUnit       | not null      |
    And I will find B2BUS customerId in API response

  @B2B_US_Reg_Perf
  Scenario: [GDC-10187] User is able to fetch customer account details using API
    Given I Hit Api to create B2BUSNew Token
     When I hit API to create B2BUSNew cart
       | basestore | cengage-b2b-ca |
       | status    |            201 |
     And I hit get user specific accounts deatails API
       | basestore | cengage-b2b-ca |
       | status    |            200 |
     Then I verify following details in API response
       | billToAccounts[0].accountNumber            | not zero |
       | customerDefaultBillToAccount.accountNumber | not zero |
       | customerDefaultShipToAccount.accountNumber | not zero |
       | shipToAccounts[0].accountNumber            | not zero |
       | customerId                                 | test_b2bus_erpphasethree_perf@yopmail.com |
    
  @B2B_US_Reg_Perf
  Scenario: [GDC-12908] Revisit/Research Bundle Stock logic (K vs. A stock type) - Bundle Scenario check for B2B US Store
    Given I Hit Api to create B2BUS Token
    And I will hit to get products associated with bundle and get the minimum stock price
      | basestore | cengage-b2b-us |
      | product   |  9780324603613 |
      | status    |            200 |
    And I hit PDP search
      | basestore | cengage-b2b-us |
      | product   |  9780324603613 |
      | status    |            200 |
    Then assert verify stock level of the PDP response equals minstock
    
   @B2B_US_Reg_Perf
  Scenario: [GDC-12983 ]Update existing unique identifier(UID) of any b2b unit to EAN and Account number field to MID
    Given I Hit Api to create B2BUS Token
    And I hit b2b User creation API
      | basestore | cengage-b2b-us |
      | email     | automation     |
      | store     | USAccNumE1QA   |
      | status    |            201 |
    And I hit get user specific accounts deatails API
      | basestore  | cengage-b2b-us |
      | status     |            200 |
    Then I verify following details in API response
      | billToAccounts.e1AccountNumber               | 4199904 |
      | customerDefaultBillToAccount.e1AccountNumber | 4199904 |
      | shipToAccounts.e1AccountNumber               | 4199904 |
    And I hit API to get specific orgUnit details
      | basestore | cengage-b2b-us |
      | orgUnitID |          0100159146 |
      | status    |            200 |
    Then I verify following details in API response
      | e1AccountNumber               | 4199904 |
     And I hit get all Org units details
      | basestore   | cengage-b2b-us |
      | currentPage |              0 |
      | pageSize    |             100|
      | status      |            200 |
    Then e1AccountNumber is not being returned in get customer profile
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I Hit the API to add cart to user account and verify status code E1
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-us    |
      | shipToAccountNumber |         0100159146 |
      | billToAccountNumber |         0100159146 |
      | status              |            202     |
     And Test Data for GDC-10423 and Order details
    
    

