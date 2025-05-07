Feature: sapecomm-13558 Scenarios

  @sapecomm-13558
  Scenario: [GDC-10182] Verify user get all the Account Number related to base-store using API:
    Given I Hit Api to create B2BUS Token
    And I hit get all units details
      | basestore   | cengage-b2b-us |
      | currentPage |              0 |
      | pageSize    |             20 |
      | status      |            200 |
    Then I verify 20 Account Numbers in API response

  @sapecomm-13558
  Scenario: Get specific org unit details -Accounts with high user registration of users, Accounts with many child accounts.
    Given I Hit Api to create B2BUS Token
    And I hit API to get specific orgUnit details
      | basestore   | cengage-b2b-us |
      |orgUnitID    |   4200508     |
      | status      |            200 |

  @sapecomm-13558
  Scenario: Get specific org unit details - Accounts with many child accounts.
    Given I Hit Api to create B2BUS Token
    And I hit API to get specific orgUnit details
      | basestore   | cengage-b2b-us |
      |orgUnitID    |   4200508     |
      | status      |            200 |
    Then I verify child accounts in API response

  @sapecomm-13558
  Scenario: Get specific org unit details - Intermediate accounts with multiple children.
    Given I Hit Api to create B2BUS Token
    And I need to hit b2b User creation API by passing account number as a input
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      |account    | 10392219       |
      | status    |            201 |
    Then I will hit B2BUS activation API by creating the password
      |password | Password1 |
    And log the test Data for username and password details after user creation
    Then I get customer details
      | basestore | cengage-b2b-us |
      | status    |            200 |
    And I hit get user specific accounts deatails API
      | basestore   | cengage-b2b-us |
      | status      |            200 |
    Then I verify ship to intermediate Unit child accounts set to true in API response


 @sapecomm-13558
  Scenario: [GDC-10173] Verify that user gets all the base store related information using API
    Given I Hit Api to create B2BUS Token
    And I hit get basestore details API
      | basestore | cengage-b2b-us |
      | status    |            200 |

  @B2BUS_User_Creation_Perf_Multiple @sapecomm-13558
  Scenario: Creating B2B US users
    Given I Hit Api to create B2BUSNew Token
    And I need to create 1  b2b users for us environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      |account    | 4200508        |
      | status    |            201 |
      |password | Password1        |

  @sapecomm-13558
    Scenario: Place order scenario
      Given I Hit Api to create B2BUSPerf Token
      When I hit API to create B2BUSPerf cart
        | basestore | cengage-b2b-us |
        | status    |            201 |
      And User set bill to ship to account number
        | basestore           | cengage-b2b-us |
        | shipToAccountNumber |        4200508 |
        | billToAccountNumber |        4200508 |
        | status              |            202 |
      And User add B2B products to cart
        | basestore | cengage-b2b-us |
        | Product   | b2bMulQuantity_1  |
        | status    |            200 |
      When I hit API to get all delivery modes
        | basestore | cengage-b2b-us |
        | status    |            200 |
      When I hit API to Set  delivery modes
        | basestore | cengage-b2b-us               |
        | code      | Use preferred ground shipper |
        | status    |                          200 |
      Then I hit API to Set drop ship address
        | basestore | cengage-b2b-us  |
        | address   | dropShipAddress |
        | status    |             201 |
      And I put PO number details using API
        | basestore | cengage-b2b-us |
        | PONumber  | PO1234567      |
        | status    |            200 |
      And I wait for 50 sec
      When I hit get cart details API
        | basestore | cengage-b2b-us |
        | status    |            200 |
      And I verify paymentType
      Then User place order for B2B cart
        | basestore | cengage-b2b-us |
        | status    |            200 |
      And Test Data for GDC-9929 and order details





