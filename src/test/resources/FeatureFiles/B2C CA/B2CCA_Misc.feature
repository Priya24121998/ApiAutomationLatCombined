Feature: B2C CA Misc API Scenarios

  @B2C_CA_Misc
  Scenario: [GDC-10157] Verify no input validation on name field of customer API
    #regexp: ^[\w'\-,.][^0-9_!¡?÷?¿\/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$
    Given I Hit Api to create B2CCA Token
    And I register a user using API
      | basestore | cengage-b2c-ca |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | store     | B2CCA          |
      | status    |            201 |
    Then I verify B2CCA customer is registered

  @B2C_CA_Misc
  Scenario: [GDC-10131] Verify no input validation on name email of customer registration API
    #regexp: \b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\b
    Given I Hit Api to create B2CCA Token
    And I register a user using API
      | basestore | cengage-b2c-ca         |
      | fName     | FirstName              |
      | lName     | LastName               |
      | email     | test123@yopyy123.wwwrr |
      | store     | B2CCA                  |
      | status    |                    201 |
    Then I verify B2CCA customer is registered

  @B2C_CA_Misc
  Scenario: [GDC-12945] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    Then I verify following details in API response
      | entityName   | BURMAN UNIVERSITY |
      | entityNumber |          11882499 |
    And I hit API to update b2c customer Entitydetails_PATCH
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

  @B2C_CA_Misc
  Scenario: [GDC-12946] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    Then I verify following details in API response
      | entityName   | BURMAN UNIVERSITY |
      | entityNumber |          11882499 |
    And I hit API to update b2c customer Entitydetails_PUT
      | basestore | cengage-b2c-emea |
      | status    |              200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
