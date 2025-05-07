Feature: Maximum Discounted Rentals


  #CU4
  @MaxDisRentalsCC
  Scenario: [GDC-10145] Verify User is able to purchase maximum 4 discounted  rentals of CU-4 months.
    Given Create CU4MaxRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_Max product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 4 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU12
  @MaxDisRentalsCC
  Scenario: [GDC-10097] Verify User is able to purchase maximum 4 discounted  rentals of CU-12 months.
    Given Create CU12MaxRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_Max product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 4 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #-------------------------------------------------Removed ---------------------------------------------------------------#   

  Scenario: [GDC-10165] Verify User is able to purchase maximum 4 discounted  rentals of CU-24 months
    Given Create CU24MaxRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_Max product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 4 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
    
    
      #CUet
  #@MaxDisRentalsCC
  #---------------------------Removed as a part of SAPECOMM-11358--------------------------------------------
  Scenario: [GDC-10130] Verify User is able to purchase maximum 4 discounted  rentals of CUeT-4 months in one go
    Given Create CUeTMaxRental user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_Max product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 4 rental status in return list of rental API is ORDERED
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
 