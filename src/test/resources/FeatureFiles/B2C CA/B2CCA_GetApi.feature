#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template
Feature: B2C CA Get API Scenarios

  @sapecomm-9783 @B2C_CA_Get
  Scenario: [GDC-12905] Revisit/Research Bundle Stock logic (K vs. A stock type) - Bundle Scenario check for B2C CA Store
    Given I Hit Api to create B2CCA Token
    And I will hit to get products associated with bundle and get the minimum stock price
      | basestore | cengage-b2c-ca |
      | product   |  9781305250833 |
      | status    |            200 |
    And I hit PDP search
      | basestore | cengage-b2c-ca |
      | product   |  9781305250833 |
      | status    |            200 |
    Then assert verify stock level of the PDP response equals minstock
