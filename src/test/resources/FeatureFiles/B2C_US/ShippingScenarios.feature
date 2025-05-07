Feature: Shipping Scenarios


  ###########################################   [  Reggression  ]    #######################################################
  
  
  #Multiple Standalone Rentals
  @Shipping
  Scenario: [GDC-10052] Verify that user is able to ship[activate] the multiple standalone rentals in one go.
    Given Create ShipScenario8374 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds MulRental_1 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I Try to Ship 2 rentals in one go
    Then Verify 2 rental status in return list of rental API is ACTIVE
    And I log Test Data for rentals
    #When I click on sidebar sign out button

    
     #Multiple CU Rentals
  @Shipping
  Scenario: [GDC-9975] Verify that user is able to ship [activate] the multiple CU rentals in one go.
    Given Create ShipScenario8375 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
    When I Hit the API to add cart to user account and verify status code
    And User adds MulcuRental_2 product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify 2 rental status in return list of rental API is ORDERED
    And I Try to Ship 2 rentals in one go
    Then Verify 2 rental status in return list of rental API is ACTIVE    
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
    
   #[Rental+Ebook] 
  @Shipping
  Scenario: [GDC-10008] verify that the order status is set to completed if the user activates(shipped) the rental product.
    Given Create ShipScenario8388 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
     And User adds Ebook product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    And I verify Order status is COMPLETED
    And I log Test Data for Normal
    #When I click on sidebar sign out button
    
    #[Rental+Paperback/Hardcover+Ebook]
      @Shipping
  Scenario: [GDC-10122] verify that the order status is set to completed if the user activates(shipped) the shippable products.
    Given Create ShipScenario8388 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
     And User adds HardCover product to cart
    And User adds Ebook product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
     And I Try to Ship Hardcover product at entry number 2
    And I verify Order status is COMPLETED
    And I log Test Data for Normal
    #When I click on sidebar sign out button
    
    
    #[Rental+Paperback/Hardcover]
     @Shipping
  Scenario: [GDC-10159] verify that the order status is set to completed if the user activates(shipped) the shippable products.
    Given Create ShipScenario8390 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds StandAloneRental product to cart
     And User adds HardCover product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
     And I Try to Ship Hardcover product at entry number 2
    And I verify Order status is COMPLETED
    And I log Test Data for Normal
    #When I click on sidebar sign out button