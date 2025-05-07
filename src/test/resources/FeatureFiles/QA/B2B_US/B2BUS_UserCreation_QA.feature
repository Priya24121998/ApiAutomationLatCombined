Feature: B2B US user creation
 #################################################  Smoke and Regression  ###########################################################
  #New

  @B2B_US_User_Creation_QA
  Scenario: Creating B2B US users
    Given I Hit Api to create B2BUSNew Token
    And I have to pass b2b User creation API which requires account number as a input
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      | status    |            201 |
    Then I will hit B2BUS activation API by creating the password
      |password | Password1 |
    And log the test Data for username and password details after user creation

  @B2B_US_User_Creation_iteration_QA
  Scenario: Creating B2B US users
    Given I Hit Api to create B2BUSNew Token
    And I need to create 3  b2b users for us environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      |account    | 0100159146     |
      | status    |            201 |
      |password | Password1        |

  @B2B_US_User_Creation_Multiple_QA
  Scenario: Creating B2B US multiple users
    Given I Hit Api to create B2BUSNew Token
    And I need to create n number b2b users for us environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      |account    | 0100159146     |
      | status    |            201 |
      |password | Password1        |

  @B2B_US_User_Creation_Multiple_QA_RunTime
  Scenario: Creating B2B US multiple users
    Given I Hit Api to create B2BUSNew Token
    And I have to create and activate n number b2b us users at run time for qa environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      | status    |            201 |
      |password | Password1        |
    And Get the key and value pairs stored in user creation hashmap
    Then Write the n user details stored in hashmap in the excel named "UserCreationB2BUS.xlsx"

