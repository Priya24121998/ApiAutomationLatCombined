Feature: Rental Migration

  #CU-4 ORDERED
  @RentalMigration
  Scenario: [GDC-10036] Verify that user is able to transfer rental  in ORDERED state from one subscription to another subscription.
    Given Create RentalMig_1 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    When I update subscription status to CANCELLED
    Then User verify subscription is CANCELLED
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I transfer rental to latest active subscription
    Then Verify rental status in return list of rental API is ORDERED
    And I verify subscriptionId is latest active subscription
    #When I click on sidebar sign out button

  #CU-4 ACTIVE
  @RentalMigration
  Scenario: [GDC-9993] Verify that user is able to transfer rental  in ACTIVE state from one subscription to another subscription .
    Given Create RentalMig_2 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I update subscription status to CANCELLED
    Then User verify subscription is CANCELLED
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    And I transfer rental to latest active subscription
    Then Verify rental status in return list of rental API is ACTIVE
    And I verify subscriptionId is latest active subscription
    #When I click on sidebar sign out button

  #CU-4 FORCEDPURCHASE
  @RentalMigration
  Scenario: [GDC-10011] Verify that user is able to transfer rental  in FORCEDPURCHASE state from one subscription to another subscription.
    Given Create RentalMig_3 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_3 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I return rental in BAD state
    Then Verify rental status in return list of rental API is FORCEDPURCHASE
    When I update subscription status to CANCELLED
    Then User verify subscription is CANCELLED
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    And I transfer rental to latest active subscription
    Then Verify rental status in return list of rental API is ACTIVE
    And I verify subscriptionId is latest active subscription
    Then I verify end date of discounted rental and end date Cu is same
    #When I click on sidebar sign out button
