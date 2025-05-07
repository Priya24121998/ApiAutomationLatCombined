Feature: sapecomm-13558 Scenarios

  @sapecomm-13558-gt
  Scenario: [GDC-10182] Verify user get all the Account Number related to base-store using API:
    Given I Hit Api to create B2BUS Token
    And I hit get all units details
      | basestore   | cengage-b2b-gt|
      | currentPage |              0 |
      | pageSize    |             20 |
      | status      |            200 |
    Then I verify 20 Account Numbers in API response

  @sapecomm-13558-gt
  Scenario: Get specific org unit details -Accounts with high user registration of users, Accounts with many child accounts.
    Given I Hit Api to create B2BUS Token
    And I hit API to get specific orgUnit details
      | basestore   | cengage-b2b-gt|
      |orgUnitID    |   157208       |
      | status      |            200 |

  @sapecomm-13558-gt
  Scenario: Get specific org unit details - Accounts with many child accounts.
    Given I Hit Api to create B2BUS Token
    And I hit API to get specific orgUnit details
      | basestore   | cengage-b2b-gt|
      |orgUnitID    |   157208       |
      | status      |            200 |
    Then I verify child accounts in API response


 @sapecomm-13558-gt
  Scenario: [GDC-10173] Verify that user gets all the base store related information using API
    Given I Hit Api to create B2BUS Token
    And I hit get basestore details API
      | basestore | cengage-b2b-gt|
      | status    |            200 |

  @B2BGT_User_Creation_Perf_Multiple @sapecomm-13558-gt
  Scenario: Creating B2B GT multiple users
    Given I Hit Api to create B2BGT Token
    And I need to create 1  b2b users for us environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-gt |
      | store     | galenew        |
      | email     | automation     |
      |account    | 157208         |
      | status    |            201 |
      |password | Password1        |

  @sapecomm-13558-gt
  Scenario: Place order scenario
    Given I Hit Api to create B2BGTPerf Token
    When I hit API to create B2BGTPerf cart
      | basestore | cengage-b2b-gt |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-gt |
      | shipToAccountNumber |        157208  |
      | billToAccountNumber |        157208  |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-gt |
      | Product   | b2bGaleProduct_4  |
      | status    |            200 |
    When I hit API to get all delivery modes
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-gt               |
      | code      | DefaultGT                    |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-gt  |
      | address   | dropShipAddress |
      | status    |             201 |
    And I put PO number details using API
      | basestore | cengage-b2b-gt |
      | PONumber  | PO1234567      |
      | status    |            200 |
    And I wait for 50 sec
    When I hit get cart details API
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And I verify paymentType
    Then User place order for B2B cart
      | basestore | cengage-b2b-gt |
      | status    |            200 |
    And Test Data for GDC-9929 and order details




