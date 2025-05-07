Feature: B2B GT Misc API Scenarios

  #################################################  Smoke   ################################################################

  @B2BGT_Misc_Smoke_Int
  Scenario: [GDC-10364] User is able to create using API
    Given I Hit Api to create B2BGTOne Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | account   | 100112405      |
      | store     | galenew        |
      | status    |            201 |
    Then I verify galenew customer is registered

  @B2BGT_Misc_Smoke_Int
  Scenario: [GDC-9921] User is able to update customer details using API
    Given I Hit Api to create B2BGTOne Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | galenew        |
      | status    |            201 |
    Then I verify galenew customer is registered
    Then I get customer details
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | roles[0]      | purchaser  |
      | roles[1]      | gale-store |
      | accountStatus | ACTIVE     |
    And I hit API to update b2b customer details
      | basestore | cengage-b2b-gt |
      | status    |            204 |
    Then I get customer details
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | roles[0]      | inquiry-only     |
      | roles[1]      | cengage-employee |
      | accountStatus | ACTIVE           |
      

  #################################################				Int				##############################################
  @B2BGT_Misc_Int
  Scenario: [GDC-10157] Verify no input validation on name field of customer API
    Given I Hit Api to create B2BGTOne Token
    And I hit b2b user creation API with regex
      | basestore | cengage-b2b-gt |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | store     | GTERP          |
      | status    |            201 |
    Then I verify B2BGT customer is registered

  @B2BGT_Misc_Int
  Scenario: [GDC-10378] User is able to get user profile details using API
    Given I Hit Api to create B2BGTOne Token
    And I will be hitting get B2BGale customer details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | accountStatus | ACTIVE                            |
      | storeName     | NSCC-BOOKSTORE (47 MARCONI CAMPUS)|
      | roles         | not null                          |
      | orgUnit       | not null                          |
    And I will get the appropriate B2BGale customerId in API response

  @B2BGT_Misc_Int
  Scenario: [GDC-10187] User is able to fetch customer account details using API
    Given I Hit Api to create B2BGTOne Token
    And I will be hitting get B2BGale customer account details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | billToAccounts[0].accountNumber            | not zero |
      | customerDefaultBillToAccount.accountNumber | not zero |
      | customerDefaultShipToAccount.accountNumber | not zero |
      | shipToAccounts[0].accountNumber            | not zero |
    And I will get the appropriate B2BGale customerId in API response

  @B2BGT_Misc_Int
  Scenario: [GDC-12668] [Partially Automated] Verify registration payload for gale user with role gale-store.
    Given I Hit Api to create B2BGTOne Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | galenew        |
      | status    |            201 |
    Then I verify galenew customer is registered

  @B2BGT_Misc_Int
  Scenario: [GDC-12669] [Partially Automated] Verify registration payload for Thorndikes user with role Purchaser
    Given I Hit Api to create B2BGTOne Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | thorndikenew   |
      | status    |            201 |
    Then I verify thorndike customer is registered
    
    
    @B2BGT_Misc_Int
  Scenario: [GDC-12956] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2BGTOne Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | galenew        |
      | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PATCH
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

  @B2BGT_Misc_Int
  Scenario: [GDC-12954] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2BGTOne Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | galenew        |
      | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PUT
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
      
