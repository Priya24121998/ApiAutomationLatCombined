Feature: Grace Period Scenarios

  Scenario: [SAPECOMM-7583] User should not be able to upgrade from CUeT to CU Full after 30 days no discount will be provided
    Given Create Grace30Day user 
    Given I open cengage commerce page
    And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Cuet_Payload product to cart
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    When I click on Go To Dashboard link  
    Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    Then I add -30 days to startDate
    When Update startDate to new calculated date for CU_ETextBook
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    Then User fetches cart details
    Then I check totalDiscounts amount is 0.0
    Then I check totalPriceWithTax amount is 124.99
    And Add NonTaxable_Address to billing address
    And launch paypal
    Then I verify PayPal portal has launched successfully
    When I enter paypal login details and make purchase
    Then I verify order number is displayed
    When I click on Go To Dashboard link  
    Then I place order using Paypal
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    And I log Test Data for subscription
    When I click on sidebar sign out button
