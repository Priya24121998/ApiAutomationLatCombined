Feature: Rental Combination Scenarios

  #StandAlone Rental + Cu Rental
  @CombinationScenario
  Scenario: [GDC-10104] Verify that user should be check-out Standalone Rental+CU Rental from a single cart.
    Given Create RentalComb_1 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneplusCURen product to cart
    Then User fetches cart details
    Then I verify 2 product in cart is StandAloneplusCURen
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal

  #Standalone Product+CU Rental
  @CombinationScenario
  Scenario: [GDC-10031] Verify that user should be check-out Standalone Product+CU Rental from a single cart.
    When I Hit the API to add cart to user account and verify status code
    And User adds STProductplusCURen product to cart
    Then User fetches cart details
    Then I verify 2 product in cart is STProductplusCURen
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal

  #Standalone Product+Standalone Rental
  @CombinationScenario
  Scenario: [GDC-10166] Verify that user should be check-out Standalone Product+Standalone Rental from a single cart.
    When I Hit the API to add cart to user account and verify status code
    And User adds STRenplusSTProd product to cart
    Then User fetches cart details
    Then I verify 2 product in cart is STRenplusSTProd
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal
    #When I click on sidebar sign out button

  #CU Rental + CU Extension + Standalone rental
  @CombinationScenario
  Scenario: [GDC-10155] Verify that user should be able to check-out a cart with products: CU Rental + CU Extension + Standalone rental.
    Given Create RentalComb_2 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_5 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds StandAloneplusCURen product to cart
    Then User fetches cart details
    Then I verify 2 product in cart is StandAloneplusCURen
    And Verify rental extension for cuRental_5
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal
    #When I click on sidebar sign out button

  #Standalone Product + CU rental + Standalone Rental + Ebook with Access length
  @CombinationScenario
  Scenario: [GDC-10077] Verify that user should be check-out Standalone Product + CU rental + Standalone Rental + Ebook with Access length from a single cart.
    Given Create RentalComb_3 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds EbkStpRental product to cart
    Then User fetches cart details
    Then I verify 4 product in cart is EbkStpRental
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal
    #When I click on sidebar sign out button

  #Standalone Product + Standalone Rental + CU Rental
  @CombinationScenario
  Scenario: [GDC-10115] Verify that user should be check-out Standalone Product + Standalone Rental + CU Rental from a single cart.
    Given Create RentalComb_4 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds StRenPCUrStp product to cart
    Then User fetches cart details
    Then I verify 3 product in cart is StRenPCUrStp
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal
    #When I click on sidebar sign out button

  #CU rental + Standalone Rental+ Digital product+ Rental extension
  @CombinationScenario
  Scenario: [GDC-10151] Verify that user should be able to check-out a cart with products: CU rental + Standalone Rental+ Digital product+ Rental extension.
    Given Create RentalComb_5 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds STCUrenDP product to cart
    Then User fetches cart details
    Then I verify 3 product in cart is STCUrenDP
    And Verify rental extension for StandAloneRental_2
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal
    #When I click on sidebar sign out button