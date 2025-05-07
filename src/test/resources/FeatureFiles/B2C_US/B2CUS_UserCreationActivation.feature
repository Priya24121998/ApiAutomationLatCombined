Feature: B2C US User Creation and Activation

  #Single User
  @B2CUS_UserCreation_Activation
  Scenario: Creating and activating B2C Users
    Given Create and activate user B2CUS

    #mutliple Users
  @B2CUS_UserCreation_Activation_Iteration
  Scenario: Creating and activating n B2C Users
    Given Create 4 users and activate it for B2CUS store
    Then I will store the username and password details in the excel named "UserCreation.xlsx"
    And Clear data in hashmap after creating users

        #mutliple Users creation at run time
  @B2CUS_UserCreation_Multiple
  Scenario: Creating and activating n B2C Users
    Given I need to create multiple n users and activate it for B2CUS store
    Then I will store the username and password details in the excel named "UserCreation_B2C.xlsx"
    And Clear data in hashmap after creating users









