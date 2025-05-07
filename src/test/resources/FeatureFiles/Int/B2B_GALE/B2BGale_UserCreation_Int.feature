Feature: B2B GT user creation
 #################################################  Smoke and Regression  ###########################################################
  #New

  @B2B_GT_User_Creation
  Scenario: Creating B2B GT users
    Given I Hit Api to create B2BGTOne Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-gt |
      | email     | automation     |
      | store     | galenew        |
      | status    |            201 |
    Then I will hit B2BGT activation API by creating the password
      |password | Password1 |
    And log the test Data for username and password details after user creation

  @B2B_GT_User_Creation_iteration
  Scenario: Creating B2B GT users
    Given I Hit Api to create B2BGTOne Token
    And I need to create 3  b2b users for gale environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-gt |
      | store     | galenew        |
      | email     | automation     |
      |account    | 0100112405      |
      | status    |            201 |
      |password | Password1        |

  @B2B_GT_User_Creation_Multiple
  Scenario: Creating B2B GT multiple users
    Given I Hit Api to create B2BGTOne Token
    And I need to create n number b2b users for gale environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-gt |
      | store     | galenew        |
      | email     | automation     |
      |account    | 0100112405      |
      | status    |            201 |
      |password | Password1        |

