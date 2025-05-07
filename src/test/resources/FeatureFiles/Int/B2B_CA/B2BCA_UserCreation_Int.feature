Feature: B2B CA user creation
 #################################################  Smoke and Regression  ###########################################################
  #New

  @B2B_CA_User_Creation
  Scenario: Creating B2B CA users
    Given I Hit Api to create B2BCANew Token
    And I need to hit b2b User creation API by passing account number as a input
      | basestore | cengage-b2b-ca |
      | store     | B2BCA          |
      | email     | automation     |
      |account    | 0100109380      |
      | status    |            201 |
    Then I will hit B2BCA activation API by creating the password
      |password | Password1 |
    And log the test Data for username and password details after user creation


  @B2B_CA_User_Creation_iteration
  Scenario: Creating B2B CA users in iteration
    Given I Hit Api to create B2BCANew Token
    And I need to create 3  b2b users for canada environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-ca |
      | store     | B2BCA          |
      | email     | automation     |
      |account    | 0100109380      |
      | status    |            201 |
      |password | Password1        |

  @B2B_CA_User_Creation_Multiple
  Scenario: Creating B2B CA multiple users
    Given I Hit Api to create B2BCANew Token
    And I need to create n number b2b users for canada environment and to activate it and log the results password for user creation for the test case UserCreation
      | basestore | cengage-b2b-ca |
      | store     | B2BCA          |
      | email     | automation     |
      |account    | 0100109380      |
      | status    |            201 |
      |password | Password1        |


#-----------------------------------------------removed-----------------------------------
#  @B2B_CA_User_Creation
#  Scenario: Creating B2B CA users
#    Given I Hit Api to create B2BCANew Token
#    Then I will hit B2BCA activation API
#      |email | b2bgt_int_automation_101776308_latest@mailinator.com |
#      |password | Password1 |
