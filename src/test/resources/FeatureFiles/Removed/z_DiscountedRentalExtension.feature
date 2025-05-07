Feature: Discounted Rental Extension [CC]

  #CUeT
  #@DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CUeT-4
    Given Create CUeTRentalEx user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
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
    Then I get rentalEndDate

  #@DiscountRenExtCC
  Scenario: [GDC-9983] Verify User is able to extend rental textbook to 15 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 15
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

 # @DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CUeT-4
    Given Create CUeT30RentalEx user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase eTextbook120_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is CU-ETextBook-120
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate

 # @DiscountRenExtCC
  Scenario: [GDC-10053] Verify User is able to extend CUeT-4 months rental to 30 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 30 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 30
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU-4
  #@DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-4
    Given Create CU4RentalEx user 
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
    Then I get rentalEndDate

  #@DiscountRenExtCC
  Scenario: [GDC-10071] Verify User is able extend CU-4 months rental to 15 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 15
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #@DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-4
    Given Create CU430RentalEx user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 4Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-120
    When I Hit the API to add cart to user account and verify status code
    And User adds cuRental_4 product to cart
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
    Then I get rentalEndDate

  #@DiscountRenExtCC
  Scenario: [GDC-10060] Verify User is able to extend CU-4 months rental to 30 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 30 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 30
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU-12
  #@DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-12
    Given Create CU12RentalEx user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
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
    Then I verify shipping method is standard-us
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate

  #@DiscountRenExtCC
  Scenario: [GDC-10095] Verify User is able extend CU-12 months rental to 15 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 15
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #@DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-12
    Given Create CU1230RentalEx user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 12Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-365
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
    Then I get rentalEndDate

  #@DiscountRenExtCC
  Scenario: [GDC-10162] Verify User is able to extend CU-12 months rental to 30 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 30 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 30
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #CU-24
  #@DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-24
    Given Create CU24RentalEx user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate

  #@DiscountRenExtCC
  Scenario: [GDC-10067] Verify User is able to extend CU-24 months rental to 15 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 15
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button

  #@DiscountRenExtCC
  Scenario: Verify User is able to purchase discounted  rentals of CU-24
    Given Create CU2430RentalEx user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I purchase 24Mon_SKU subscription plan through API
    Then I verify get state API response value of subscriptionPlan field is Full-Access-730
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
    Then I get rentalEndDate

  #@DiscountRenExtCC
  Scenario: [GDC-9986] Verify User is able to extend CU-24 months rental to 30 days.
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 30 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 30
    And I log Test Data for discountedRentals
    #When I click on sidebar sign out button
