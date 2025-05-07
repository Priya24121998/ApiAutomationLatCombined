Feature: B2C AU Misc API Scenarios

  #################################################  Smoke   ################################################################
 
  #################################################  Reggression   ###########################################################
  @B2C_AU_Misc
  Scenario: [GDC-10157] Verify no input validation on name field of customer API
    Given I Hit Api to create B2CAU Token
    And I register a user using API
      | basestore | cengage-b2c-au |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | store     | B2CAU          |
      | status    |            201 |
    Then I verify B2CAU customer is registered

  @B2C_AU_Misc
  Scenario: [GDC-10131] Verify no input validation on name email of customer registration API
    Given I Hit Api to create B2CAU Token
    And I register a user using API
      | basestore | cengage-b2c-au         |
      | fName     | FirstName              |
      | lName     | LastName               |
      | email     | test123@yopyy123.wwwrr |
      | store     | B2CAU                  |
      | status    |                    201 |
    Then I verify B2CAU customer is registered
    
    
     @B2C_AU_Misc
  Scenario: [GDC-12952] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    Then I verify following details in API response
      | entityName   | AUSTRALIAN CATHOLIC UNIVERSITY - ST PATRICKS |
      | entityNumber | 1-1604-475                                 |
    And I hit API to update b2c customer Entitydetails_PATCH
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

  @B2C_AU_Misc
  Scenario: [GDC-12949] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    Then I verify following details in API response
      | entityName   | AUSTRALIAN CATHOLIC UNIVERSITY - ST PATRICKS |
      | entityNumber | 1-1604-475                                  |
    And I hit API to update b2c customer Entitydetails_PUT
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
