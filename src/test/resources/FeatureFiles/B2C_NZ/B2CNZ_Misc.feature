Feature: B2C NZ Misc API Scenarios

  @B2C_NZ_Misc
  Scenario: [GDC-10157] Verify no input validation on name field of customer API
    Given I Hit Api to create B2CNZ Token
    And I register a user using API
      | basestore | cengage-b2c-nz |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | store     | B2CNZ          |
      | status    |            201 |
    Then I verify B2CNZ customer is registered

  @B2C_NZ_Misc
  Scenario: [GDC-10131] Verify no input validation on name email of customer registration API
    Given I Hit Api to create B2CNZ Token
    And I register a user using API
      | basestore | cengage-b2c-nz         |
      | fName     | FirstName              |
      | lName     | LastName               |
      | email     | test123@yopyy123.wwwrr |
      | store     | B2CNZ                  |
      | status    |                    201 |
    Then I verify B2CNZ customer is registered
    
    
    @B2C_NZ_Misc
  Scenario: [GDC-12950] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    Then I verify following details in API response
      | entityName   | MASSEY UNIVERSITY - ALBANY (AUCKLAND) |
      | entityNumber | 1-27HX-1533                          |
    And I hit API to update b2c customer Entitydetails_PATCH
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

  @B2C_NZ_Misc
  Scenario: [GDC-12947] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    Then I verify following details in API response
      | entityName   | MASSEY UNIVERSITY - ALBANY (AUCKLAND) |
      | entityNumber | 1-27HX-1533                          |
    And I hit API to update b2c customer Entitydetails_PUT
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
