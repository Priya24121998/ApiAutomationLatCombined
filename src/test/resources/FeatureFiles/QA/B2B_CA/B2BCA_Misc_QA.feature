Feature: B2B CA Misc API Scenarios

  #################################################  Smoke   ################################################################
    @B2BCA_Misc_QA
  Scenario: [GDC-12955] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2BCA Token
      And I hit b2b user creation API with regex
        | basestore | cengage-b2b-ca |
        | fName     | read           |
        | lName     | read           |
        | email     | automation     |
        | store     | CAERPQA        |
        | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PATCH
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
  

  @B2BCA_Misc_QA
  Scenario: [GDC-12953] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2BCA Token
    And I hit b2b user creation API with regex
      | basestore | cengage-b2b-ca |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | store     | CAERPQA        |
      | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PUT
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

